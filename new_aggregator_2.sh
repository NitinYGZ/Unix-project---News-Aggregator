#!/bin/bash

# Define paths for the two scripts
SCRIPT1="/home/nitin/Documents/Unix Project shii/00_News_Api.sh"  # Replace with the actual path to the first script
SCRIPT2="/home/nitin/Documents/Unix Project shii/01_News_Data_io.sh"  # Replace with the actual path to the second script

# Execute the first script
if [ -x "$SCRIPT1" ]; then
    echo "Executing $SCRIPT1..."
    bash "$SCRIPT1"
    if [ $? -ne 0 ]; then
        echo "Error: $SCRIPT1 failed to execute successfully."
        exit 1
    fi
else
    echo "Error: $SCRIPT1 is not executable or not found."
    exit 1
fi

# Execute the second script
if [ -x "$SCRIPT2" ]; then
    echo "Executing $SCRIPT2..."
    bash "$SCRIPT2"
    if [ $? -ne 0 ]; then
        echo "Error: $SCRIPT2 failed to execute successfully."
        exit 1
    fi
else
    echo "Error: $SCRIPT2 is not executable or not found."
    exit 1
fi

echo "Both scripts executed successfully."
exit 0
