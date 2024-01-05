#!/bin/bash

# Define the URL to retrieve data from
apiEndpoint="https://www.gstatic.com/ipranges/cloud.json"

# Data file with timestamp prefix
dataFile="ip_ranges_data_$(date +'%Y%m%d%H%M%S').json"

# Perform the curl command to get data from the specified URL
curl -s "$apiEndpoint" > "$dataFile"

# Function to log messages with timestamps
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "script_log.txt"
}

# Function to create folders based on service and scope
organizeFolders() {
    local service=$1
    local scope=$2

    # Create folders if they don't exist
    mkdir -p "${service// /_}/$scope/ipv4"
    mkdir -p "${service// /_}/$scope/ipv6"

    # Extract and save IPv4 addresses
    jq -r --arg service "$service" --arg scope "$scope" '.prefixes[] | select(.service == $service and .scope == $scope) | .ipv4Prefix // empty' "$dataFile" > "${service// /_}/$scope/ipv4/ipv4.txt"

    # Extract and save IPv6 addresses
    jq -r --arg service "$service" --arg scope "$scope" '.prefixes[] | select(.service == $service and .scope == $scope) | .ipv6Prefix // empty' "$dataFile" > "${service// /_}/$scope/ipv6/ipv6.txt"
}

# Iterate over each entry in the "prefixes" array
jq -c '.prefixes[] | {service: .service, scope: .scope}' "$dataFile" |
while read -r entry; do
    service=$(echo "$entry" | jq -r '.service')
    scope=$(echo "$entry" | jq -r '.scope')

    log "Processing service: $service, scope: $scope"

    # Organize folders and save IPv4 and IPv6 addresses
    organizeFolders "$service" "$scope"
done

log "Script execution completed successfully."
