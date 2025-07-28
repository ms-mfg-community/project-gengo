#!/bin/bash

# .NET CI/CD GitHub Environment Setup Script
# Bash script to automate GitHub environments, secrets, and variables setup

set -e  # Exit on any error

# Color output functions
print_success() { echo -e "\e[32m✅ $1\e[0m"; }
print_info() { echo -e "\e[34mℹ️  $1\e[0m"; }
print_warning() { echo -e "\e[33m⚠️  $1\e[0m"; }
print_error() { echo -e "\e[31m❌ $1\e[0m"; }

# Function to show usage
show_usage() {
    echo "Usage: $0 --owner <github-owner> --repo <github-repo> [--env-file <env-file>]"
    echo ""
    echo "Options:"
    echo "  --owner      GitHub username or organization"
    echo "  --repo       GitHub repository name"
    echo "  --env-file   Path to environment file (default: .env)"
    echo "  --help       Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --owner myorg --repo myrepo --env-file .env"
    exit 1
}

# Parse command line arguments
OWNER=""
REPO=""
ENV_FILE=".env"

while [[ $# -gt 0 ]]; do
    case $1 in
        --owner)
            OWNER="$2"
            shift 2
            ;;
        --repo)
            REPO="$2"
            shift 2
            ;;
        --env-file)
            ENV_FILE="$2"
            shift 2
            ;;
        --help)
            show_usage
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            ;;
    esac
done

# Validate required arguments
if [[ -z "$OWNER" ]] || [[ -z "$REPO" ]]; then
    print_error "Owner and repository are required"
    show_usage
fi

# Function to check if GitHub CLI is installed and authenticated
check_github_cli() {
    print_info "Checking GitHub CLI installation and authentication..."
    
    # Check if gh is installed
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) is not installed. Please install it first:"
        echo "  macOS: brew install gh"
        echo "  Linux: See https://cli.github.com/"
        exit 1
    fi
    
    # Check if authenticated
    if ! gh auth status &> /dev/null; then
        print_error "GitHub CLI is not authenticated. Please run: gh auth login"
        exit 1
    fi
    
    print_success "GitHub CLI is installed and authenticated"
}

# Function to load environment variables from .env file
load_env_vars() {
    if [[ ! -f "$ENV_FILE" ]]; then
        print_error "Environment file not found: $ENV_FILE"
        print_info "Please copy .env.template to .env and fill in your values"
        exit 1
    fi
    
    print_info "Loading environment variables from $ENV_FILE..."
    
    # Load environment variables
    set -a  # automatically export all variables
    source "$ENV_FILE"
    set +a  # stop automatically exporting
    
    # Validate required variables
    required_vars=("AZURE_CLIENT_ID" "AZURE_CLIENT_SECRET" "AZURE_TENANT_ID" "AZURE_SUBSCRIPTION_ID")
    
    for var in "${required_vars[@]}"; do
        if [[ -z "${!var}" ]] || [[ "${!var}" == *"your-"*"-here" ]]; then
            print_error "Required environment variable $var is not set or has placeholder value"
            exit 1
        fi
    done
    
    print_success "Environment variables loaded successfully"
}

# Function to create GitHub environments
create_github_environment() {
    local env_name=$1
    local wait_timer=$2
    local reviewers=$3
    
    print_info "Creating GitHub environment: $env_name"
    
    # Create environment
    if gh api "repos/$OWNER/$REPO/environments/$env_name" --method PUT --silent 2>/dev/null; then
        print_success "Environment '$env_name' created successfully"
    else
        print_warning "Environment '$env_name' may already exist or there was an issue"
    fi
    
    # Configure protection rules if specified
    if [[ $reviewers -gt 0 ]] || [[ $wait_timer -gt 0 ]]; then
        print_info "Configuring protection rules for $env_name..."
        
        protection_config="{
            \"wait_timer\": $wait_timer,
            \"reviewers\": [],
            \"deployment_branch_policy\": {
                \"protected_branches\": true,
                \"custom_branch_policies\": false
            }
        }"
        
        if echo "$protection_config" | gh api "repos/$OWNER/$REPO/environments/$env_name" --method PUT --input - 2>/dev/null; then
            print_success "Protection rules configured for $env_name"
            if [[ $reviewers -gt 0 ]]; then
                print_warning "Manual step required: Configure $reviewers reviewers in GitHub UI"
            fi
        else
            print_warning "Failed to configure protection rules for $env_name"
        fi
    fi
}

# Function to set repository secrets
set_repository_secret() {
    local secret_name=$1
    local secret_value=$2
    
    print_info "Setting repository secret: $secret_name"
    
    if gh secret set "$secret_name" --body "$secret_value" --repo "$OWNER/$REPO" 2>/dev/null; then
        print_success "Repository secret '$secret_name' set successfully"
    else
        print_error "Failed to set repository secret '$secret_name'"
    fi
}

# Function to set environment secrets
set_environment_secret() {
    local env_name=$1
    local secret_name=$2
    local secret_value=$3
    
    print_info "Setting environment secret: $secret_name for $env_name"
    
    if gh secret set "$secret_name" --body "$secret_value" --env "$env_name" --repo "$OWNER/$REPO" 2>/dev/null; then
        print_success "Environment secret '$secret_name' set for $env_name"
    else
        print_error "Failed to set environment secret '$secret_name' for $env_name"
    fi
}

# Function to set environment variables
set_environment_variable() {
    local env_name=$1
    local var_name=$2
    local var_value=$3
    
    print_info "Setting environment variable: $var_name for $env_name"
    
    if gh variable set "$var_name" --body "$var_value" --env "$env_name" --repo "$OWNER/$REPO" 2>/dev/null; then
        print_success "Environment variable '$var_name' set for $env_name"
    else
        print_error "Failed to set environment variable '$var_name' for $env_name"
    fi
}

# Function to configure branch protection rules
set_branch_protection() {
    local branch=$1
    local required_reviewers=$2
    
    print_info "Configuring branch protection for: $branch"
    
    protection_config="{
        \"required_status_checks\": {
            \"strict\": true,
            \"contexts\": []
        },
        \"enforce_admins\": false,
        \"required_pull_request_reviews\": {
            \"dismiss_stale_reviews\": true,
            \"require_code_owner_reviews\": true,
            \"required_approving_review_count\": $required_reviewers
        },
        \"restrictions\": null,
        \"allow_force_pushes\": false,
        \"allow_deletions\": false
    }"
    
    if echo "$protection_config" | gh api "repos/$OWNER/$REPO/branches/$branch/protection" --method PUT --input - 2>/dev/null; then
        print_success "Branch protection configured for $branch"
    else
        print_warning "Failed to configure branch protection for $branch"
    fi
}

# Main execution function
main() {
    print_info "Starting .NET CI/CD GitHub Environment Setup"
    print_info "Repository: $OWNER/$REPO"
    print_info "Environment file: $ENV_FILE"
    
    # Step 1: Verify prerequisites
    check_github_cli
    
    # Step 2: Load environment variables
    load_env_vars
    
    # Step 3: Create GitHub environments
    create_github_environment "dev" 0 0
    create_github_environment "qa" 0 1
    create_github_environment "prod" 300 2  # 5 minutes wait, 2 reviewers
    
    # Step 4: Set repository-level secrets
    print_info "Setting repository-level secrets..."
    set_repository_secret "AZURE_CLIENT_ID" "$AZURE_CLIENT_ID"
    set_repository_secret "AZURE_CLIENT_SECRET" "$AZURE_CLIENT_SECRET"
    set_repository_secret "AZURE_TENANT_ID" "$AZURE_TENANT_ID"
    set_repository_secret "AZURE_SUBSCRIPTION_ID" "$AZURE_SUBSCRIPTION_ID"
    
    # Step 5: Set environment-specific variables
    print_info "Setting environment-specific variables..."
    
    # Dev environment
    if [[ -n "$AZURE_WEBAPP_NAME_DEV" ]]; then
        set_environment_variable "dev" "AZURE_WEBAPP_NAME" "$AZURE_WEBAPP_NAME_DEV"
        set_environment_variable "dev" "AZURE_RESOURCE_GROUP" "$AZURE_RESOURCE_GROUP_DEV"
        set_environment_variable "dev" "DEPLOYMENT_SLOT" "$AZURE_WEBAPP_SLOT_DEV"
    fi
    
    # QA environment
    if [[ -n "$AZURE_WEBAPP_NAME_QA" ]]; then
        set_environment_variable "qa" "AZURE_WEBAPP_NAME" "$AZURE_WEBAPP_NAME_QA"
        set_environment_variable "qa" "AZURE_RESOURCE_GROUP" "$AZURE_RESOURCE_GROUP_QA"
        set_environment_variable "qa" "DEPLOYMENT_SLOT" "$AZURE_WEBAPP_SLOT_QA"
    fi
    
    # Prod environment
    if [[ -n "$AZURE_WEBAPP_NAME_PROD" ]]; then
        set_environment_variable "prod" "AZURE_WEBAPP_NAME" "$AZURE_WEBAPP_NAME_PROD"
        set_environment_variable "prod" "AZURE_RESOURCE_GROUP" "$AZURE_RESOURCE_GROUP_PROD"
        set_environment_variable "prod" "DEPLOYMENT_SLOT" "$AZURE_WEBAPP_SLOT_PROD"
    fi
    
    # Step 6: Configure branch protection rules
    print_info "Configuring branch protection rules..."
    set_branch_protection "main" 1
    
    # Step 7: Summary
    print_success "GitHub environment setup completed successfully!"
    print_info "Next steps:"
    print_info "1. Review the created environments in GitHub: https://github.com/$OWNER/$REPO/settings/environments"
    print_info "2. Configure reviewers for qa and prod environments"
    print_info "3. Add Azure Web App publish profiles as environment secrets"
    print_info "4. Test the workflows by creating a pull request"
    
    print_warning "Important: Remember to add publish profiles manually:"
    echo "  gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body \"<publish_profile_xml>\" --env dev"
    echo "  gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body \"<publish_profile_xml>\" --env qa"
    echo "  gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body \"<publish_profile_xml>\" --env prod"
}

# Execute main function
main "$@"
