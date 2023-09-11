#!/bin/bash

# Check if the IP list file exists
ip_list_file="the_ip.txt"
if [ ! -f "$ip_list_file" ]; then
    echo "IP list file not found: $ip_list_file"
    exit 1
fi

# Read the IP addresses from the file into an array
mapfile -t ip_addresses < "$ip_list_file"

# Loop through the array and run Nmap for each IP address
for ip in "${ip_addresses[@]}"; do
    ip=$(echo "$ip" | tr -d '\r')  # Remove any carriage return characters if present
    echo "Scanning $ip..."
    
    # Run Nmap with your desired options and output format
    nmap -sT -sU -sV -Pn "$ip" -p- -oA "$ip"_scan_result.txt
    
    echo "Scan of $ip completed."
done

echo "All scans completed."
