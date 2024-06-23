# URL to be curled
URL="https://geekembly.com"

# Duration in seconds
DURATION=120

# List of random user agents
USER_AGENTS=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15"
    "Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1"
    "Mozilla/5.0 (Linux; Android 11; Pixel 4 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Mobile Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0"
)

# Start time
START_TIME=$(date +%s)

# Loop to curl with random user agents
while [ $(($(date +%s) - START_TIME)) -lt $DURATION ]
do
    # Select a random user agent
    RANDOM_USER_AGENT=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}
  
    # Perform the curl request with a random user agent
    curl -A "$RANDOM_USER_AGENT" "$URL"
    
    # Wait for 1 second
		# sleep 0.1
done
