import os
import requests

OWNER = "ms-mfg-community"
REPO = "project-gengo"

HEADERS = {
    "Authorization": f"Bearer $GITHUB_TOKEN",
    "Accept": "application/vnd.github+json"
}

def get_alerts():
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/dependabot/alerts"
    resp = requests.get(url, headers=HEADERS)
    data = resp.json()
    if isinstance(data, list):
        return data
    else:
        print("Unexpected response:", data)
        return []

def dismiss_alert(alert_id, reason="tolerable_risk"):
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/dependabot/alerts/{alert_id}"
    data = {
        "state": "dismissed",
        "dismissed_reason": reason,
        "dismissed_comment": "Auto-triaged: accepted by policy"
    }
    requests.patch(url, headers=HEADERS, json=data)

for alert in get_alerts():
    if isinstance(alert, dict) and alert.get("severity") == "low":
        dismiss_alert(alert["number"])