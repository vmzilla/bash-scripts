#!/bin/bash

# Usage: ./generate-toc.sh README.md

if [ $# -ne 1 ]; then
    echo "Usage: $0 <readme-file>"
    exit 1
fi

README_FILE=$1

if [ ! -f "$README_FILE" ]; then
    echo "Error: File '$README_FILE' not found."
    exit 1
fi

# Ask user for heading depth preference
echo "Do you want to include subheadings in the Table of Contents?"
echo "1) Only main headings (e.g., # and ##)"
echo "2) All headings (including subheadings)"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "Generating TOC with main headings only..."
        # Ask for maximum heading level
        read -p "Enter maximum heading level (1 for #, 2 for ##): " max_level
        ;;
    2)
        echo "Generating TOC with all headings..."
        max_level=6  # Include all heading levels
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "# Table of Contents"
echo

# Process file to extract real headings (not comments in code blocks)
in_code_block=0
while IFS= read -r line; do
    # Check if line starts/ends a code block
    if [[ "$line" =~ ^(\`\`\`|\~\~\~) ]]; then
        if [ $in_code_block -eq 0 ]; then
            in_code_block=1
        else
            in_code_block=0
        fi
        continue
    fi
    
    # Skip lines if we're in a code block
    if [ $in_code_block -eq 1 ]; then
        continue
    fi
    
    # Check if this is a heading line (starts with #)
    if [[ "$line" =~ ^#{1,6}[[:space:]] ]]; then
        # Skip "Table of Contents" heading
        if [[ "$line" =~ "Table of Contents" ]]; then
            continue
        fi
        
        # Extract heading level (number of # symbols)
        heading_level=$(echo "$line" | grep -o "^#\+" | wc -c)
        heading_level=$((heading_level - 1))
        
        # Skip if heading level is greater than max level chosen by user
        if [ "$heading_level" -gt "$max_level" ]; then
            continue
        fi
        
        # Extract heading text
        heading_text=$(echo "$line" | sed -E 's/^#{1,6} (.*)$/\1/')
        
        # Create anchor link (lowercase, replace spaces with hyphens, remove special chars)
        anchor=$(echo "$heading_text" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
        
        # Indent based on heading level and create markdown link
        indent=$(printf "%$((($heading_level - 1) * 2))s" "")
        echo "${indent}- [$heading_text](#$anchor)"
    fi
done < "$README_FILE"
