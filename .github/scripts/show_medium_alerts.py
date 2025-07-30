import os
import requests

OWNER = os.getenv("GH_OWNER")
REPO = os.getenv("GH_REPO")
TOKEN = os.getenv("GH_TOKEN")

HEADERS = {
    "Authorization": f"Bearer {TOKEN}",
    "Accept": "application/vnd.github+json"
}

def get_code_scanning_alerts():
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/code-scanning/alerts"
    resp = requests.get(url, headers=HEADERS)
    data = resp.json()
    if isinstance(data, list):
        return data
    else:
        print("Unexpected response:", data)
        return []

def display_alert_details(alert):
    """Display detailed information about a code scanning alert"""
    number = alert.get('number', 'N/A')
    rule_id = alert.get('rule', {}).get('id', 'Unknown')
    rule_name = alert.get('rule', {}).get('name', 'No name')
    severity = alert.get('rule', {}).get('security_severity_level', 'Unknown')
    state = alert.get('state', 'Unknown')
    tool = alert.get('tool', {}).get('name', 'Unknown')
    
    print(f"  Alert #{number}")
    print(f"    Rule ID: {rule_id}")
    print(f"    Rule Name: {rule_name}")
    print(f"    Severity: {severity}")
    print(f"    State: {state}")
    print(f"    Tool: {tool}")
    
    # Show locations if available
    most_recent_instance = alert.get('most_recent_instance', {})
    if most_recent_instance:
        location = most_recent_instance.get('location', {})
        path = location.get('path', 'Unknown path')
        start_line = location.get('start_line', 'Unknown')
        print(f"    Location: {path}:{start_line}")
    
    print()  # Empty line for readability

print("Fetching CodeQL code scanning alerts...")
alerts = get_code_scanning_alerts()

if not alerts:
    print("No code scanning alerts found or unable to fetch alerts.")
else:
    print(f"Total alerts found: {len(alerts)}")
    
    # Filter for medium severity alerts
    medium_alerts = []
    for alert in alerts:
        if isinstance(alert, dict):
            severity = alert.get('rule', {}).get('security_severity_level', '').lower()
            if severity == "medium":
                medium_alerts.append(alert)
    
    print(f"\nMedium severity alerts found: {len(medium_alerts)}")
    
    if medium_alerts:
        print("\n" + "="*60)
        print("MEDIUM SEVERITY CODE SCANNING ALERTS")
        print("="*60)
        
        for alert in medium_alerts:
            display_alert_details(alert)
    else:
        print("\n✅ No medium severity code scanning alerts found!")

print("Code scanning alert review completed.")
