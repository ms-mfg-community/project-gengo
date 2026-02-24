# Project Agents Configuration

This file provides project-specific context and guidelines for GitHub Copilot agents working in this .NET and Angular application.

## Project Overview

This is a full-stack application with:
- **Backend:** .NET 6.0 with ASP.NET Core Web API
- **Frontend:** Angular 17+ with TypeScript
- **Database:** SQL Server / Azure SQL Database
- **Testing:** xUnit (backend), Jasmine/Karma (frontend), Playwright (E2E)
- **CI/CD:** Azure DevOps / GitHub Actions
- **Cloud:** Azure (App Service, SQL Database, Key Vault, Application Insights)

## Architecture

### Backend Structure
```
src/
├── API/                    # ASP.NET Core Web API
├── Core/                   # Domain models and interfaces
├── Infrastructure/         # Data access and external services
└── Tests/                  # Unit and integration tests
```

### Frontend Structure
```
src/
├── app/
│   ├── core/              # Singleton services and guards
│   ├── shared/            # Reusable components and utilities
│   ├── features/          # Feature modules (lazy loaded)
│   └── app.component.ts   # Root component
```

## Coding Standards

### .NET/C# Standards
- Use **async/await** for all I/O operations
- Follow **SOLID principles** and **clean architecture**
- Use **dependency injection** for all services
- Implement **repository pattern** for data access
- Use **FluentValidation** for input validation
- Apply **AutoMapper** for object mapping
- Write **XML documentation** for public APIs

### Angular/TypeScript Standards
- Use **standalone components** (Angular 17+)
- Implement **OnPush change detection** where possible
- Use **RxJS** for reactive programming
- Follow **Angular style guide** naming conventions
- Use **lazy loading** for feature modules
- Implement **route guards** for authentication
- Use **Angular signals** for state management

### Testing Standards
- Maintain **minimum 80% code coverage**
- Follow **Arrange-Act-Assert (AAA)** pattern
- Use **mocking frameworks** (Moq for .NET, Jasmine spies for Angular)
- Write **integration tests** for critical paths
- Use **Playwright** for E2E tests

## Security Guidelines

- **Never hardcode secrets** - use Azure Key Vault
- **Validate all inputs** on both client and server
- **Use parameterized queries** to prevent SQL injection
- **Implement CORS** properly for API endpoints
- **Use HTTPS** for all communications
- **Implement JWT authentication** with refresh tokens
- **Apply principle of least privilege** for database access

## Database Conventions

- Use **plural table names** (e.g., Products, Orders)
- Use **PascalCase** for table and column names
- Add **indexes** on foreign keys and frequently queried columns
- Use **soft deletes** (IsDeleted flag) instead of hard deletes
- Include **audit columns** (CreatedAt, CreatedBy, UpdatedAt, UpdatedBy)
- Use **Entity Framework Core migrations** for schema changes

## API Conventions

- Use **RESTful** conventions for endpoints
- Return **appropriate HTTP status codes**
- Use **versioning** for APIs (e.g., /api/v1/products)
- Implement **pagination** for list endpoints
- Use **DTOs** for request/response models
- Apply **rate limiting** for public endpoints
- Document APIs using **Swagger/OpenAPI**

## DevOps Practices

- Use **feature branches** with pull requests
- Require **code reviews** before merging
- Run **automated tests** in CI pipeline
- Use **semantic versioning** for releases
- Deploy to **staging** before production
- Implement **blue-green deployment** for zero downtime
- Monitor with **Application Insights**

## Common Tasks

### Adding a New Feature
1. Create feature branch from main
2. Implement backend API endpoint with tests
3. Create Angular service and component
4. Add E2E tests with Playwright
5. Update API documentation
6. Submit pull request for review

### Database Changes
1. Create Entity Framework migration
2. Review migration SQL script
3. Test migration on local database
4. Apply migration in staging environment
5. Verify data integrity
6. Apply migration in production

### Deploying Changes
1. Merge to main branch
2. CI pipeline runs tests and builds artifacts
3. Deploy to staging environment
4. Run smoke tests
5. Deploy to production
6. Monitor Application Insights for errors

## Tools and Extensions

- **GitHub Copilot** - AI pair programming
- **ReSharper** or **Rider** - .NET development
- **Angular Language Service** - Angular development
- **Azure Tools** - Azure resource management
- **REST Client** - API testing
- **Playwright** - E2E testing

## Contact Information

For questions about:
- **Architecture decisions:** Contact the Tech Lead
- **Security concerns:** Contact the Security Engineer
- **DevOps issues:** Contact the Platform Engineer
- **Database questions:** Contact the DBA

## Additional Resources

- [Architecture Decision Records](./docs/adr/)
- [API Documentation](./docs/api/)
- [Deployment Guide](./docs/deployment.md)
- [Troubleshooting Guide](./docs/troubleshooting.md)

---

**Note:** This file is automatically read by GitHub Copilot agents to provide project-specific context. Keep it updated as the project evolves.
