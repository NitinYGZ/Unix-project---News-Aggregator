#!/bin/bash

# Define the NewsAPI endpoint and your API key
API_KEY="e7a7d36068c144c09fae3cf6be6809c6"
ENDPOINT="https://newsapi.org/v2/top-headlines"

# Optionally, set parameters for the API request
COUNTRY="us"   # Get news from the US
CATEGORY="general"   # General news category (other options: business, entertainment, health, etc.)
LANGUAGE="en"   # Language of news articles (English)

# Output file
OUTPUT_FILE="news_output.txt"

# Make the API request using curl
response=$(curl -s "${ENDPOINT}?country=${COUNTRY}&category=${CATEGORY}&language=${LANGUAGE}&apiKey=${API_KEY}")

# Check if the response is valid (status code)
status=$(echo "$response" | jq -r '.status')

if [ "$status" != "ok" ]; then
    echo "Error fetching news: $(echo $response | jq -r '.message')" > "$OUTPUT_FILE"
    exit 1
fi

# Parse and write the articles' titles and URLs to the file
echo "Top Headlines in $CATEGORY:" > "$OUTPUT_FILE"
echo "--------------------------------------" >> "$OUTPUT_FILE"
echo "$response" | jq -r '.articles[] | "\(.title) - \(.url)"' >> "$OUTPUT_FILE"

exit 0
