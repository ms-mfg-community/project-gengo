import ipaddress

# Define the base subnet to check against
baseSubnet = ipaddress.IPv4Network("172.20.8.0/24")

# Array of subnets to check for overlap with the base subnet
subnetsToCheck = [
    ipaddress.IPv4Network("10.48.29.0/24"),
    ipaddress.IPv4Network("10.48.34.0/24")
]

# Check each subnet in the array for overlap with the base subnet
print(f"Base subnet: {baseSubnet}")
print("Checking for overlaps...")

for i, subnet in enumerate(subnetsToCheck, 1):
    overlaps = baseSubnet.overlaps(subnet)
    
    if overlaps:
        print(f"Subnet {i}: {subnet} - OVERLAPS with base subnet")
    else:
        print(f"Subnet {i}: {subnet} - Does NOT overlap with base subnet")
