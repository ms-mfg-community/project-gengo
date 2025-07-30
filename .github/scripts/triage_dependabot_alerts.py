import os
import requests

OWNER = "ms-mfg-community"
REPO = "project-gengo"

HEADERS = {
    "Authorization": f"Bearer ${{secret.PERSONAL_ACCESS_TOKEN}}",
    "Accept": "application/vnd.github+json"
}

def get_alerts():
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/dependabot/alerts"
    return requests.get(url, headers=HEADERS).json()

def dismiss_alert(alert_id, reason="tolerable_risk"):
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/dependabot/alerts/{alert_id}"
    data = {
        "state": "dismissed",
        "dismissed_reason": reason,
        "dismissed_comment": "Auto-triaged: accepted by policy"
    }
    requests.patch(url, headers=HEADERS, json=data)

for alert in get_alerts():
    # if alert["severity"] == "low" and "test" in alert["manifest_path"]:
    if alert["severity"] == "low":
        dismiss_alert(alert["number"])
