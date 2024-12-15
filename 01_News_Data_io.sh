#!/bin/bash

# Define the Newsdata.io API endpoint and your API key
API_KEY="pub_624007c51ea5aeddb164ad572451658ede834"
ENDPOINT="https://newsdata.io/api/1/news"

# Set parameters for the API request
COUNTRY="us"       # Fetch news from the US
LANGUAGE="en"      # Language of news articles (English)
CATEGORY="technology" # Use a valid category from the Newsdata.io documentation

# Output file
OUTPUT_FILE="news_output.txt"

# Make the API request using curl
response=$(curl -s -G "${ENDPOINT}" \
    --data-urlencode "apikey=${API_KEY}" \
    --data-urlencode "country=${COUNTRY}" \
    --data-urlencode "language=${LANGUAGE}" \
    --data-urlencode "category=${CATEGORY}")

# Check if the response contains an error
status=$(echo "$response" | jq -r '.status // "error"')
if [ "$status" != "success" ]; then
    echo "Error fetching news: $(echo "$response" | jq -r '.results.message // "Unknown error"')" >> "$OUTPUT_FILE"
    exit 1
fi

# Parse and display the articles' titles and URLs
echo "Top Headlines in $CATEGORY:" >> "$OUTPUT_FILE"
echo "--------------------------------------" >> "$OUTPUT_FILE"
echo "$response" | jq -r '.results[] | "\(.title) - \(.link)"' >> "$OUTPUT_FILE"

exit 0
