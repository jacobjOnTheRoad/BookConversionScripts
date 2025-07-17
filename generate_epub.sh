#!/bin/bash

# generate_epub.sh
# Script to generate EPUB from Markdown files in the current directory

# Set INPUT_DIR to the directory where this script is run from
INPUT_DIR=$(pwd)
# Output EPUB file
OUTPUT_EPUB="$INPUT_DIR/book1.epub"
# Temporary CSS file for EPUB
TEMP_CSS="/tmp/epub_styles.css"
# Lua filter for page breaks (download from https://raw.githubusercontent.com/pandoc-ext/pagebreak/main/pagebreak.lua and place in this directory)
LUA_FILTER="$INPUT_DIR/pagebreak.lua"

# Check if pandoc is installed
if ! command -v pandoc >/dev/null 2>&1; then
    echo "pandoc not installed. Install it with 'sudo apt install pandoc'."
    exit 1
fi

# Optional: Check if epubcheck is installed for EPUB validation
if command -v epubcheck >/dev/null 2>&1; then
    EPUBCHECK_AVAILABLE=true
else
    echo "epubcheck not installed. Install it to validate EPUB (optional)."
    echo "On Ubuntu: sudo apt install epubcheck"
    EPUBCHECK_AVAILABLE=false
fi

# Warn if Lua filter is missing
if [ ! -f "$LUA_FILTER" ]; then
    echo "Warning: pagebreak.lua not found at $LUA_FILTER. Download it from https://raw.githubusercontent.com/pandoc-ext/pagebreak/main/pagebreak.lua for unified page breaks."
fi

# Create temporary CSS file for EPUB
cat > "$TEMP_CSS" << 'EOF'
body { font-family: Times New Roman, serif; font-size: 12pt; }
h1, h2 { text-align: center; }
h1 { page-break-before: always; } /* Forces chapters (h1) to start on a new page/screen */
.page-break { page-break-before: always; } /* For manual \pagebreak indicators */
EOF

# Function to generate EPUB
generate_epub() {
    echo "Generating EPUB from text files in $INPUT_DIR..."
    # Base command
    CMD="pandoc \"$INPUT_DIR\"/*.md -o \"$OUTPUT_EPUB\" \
        --toc \
        --toc-depth=2 \
        -t epub \
        --metadata title=\"The Crown and the Curse\" \
        --metadata author=\"Nyxalith Moonbinder\" \
        --metadata date=\"$(date +%Y-%m-%d)\" \
        --metadata lang=\"en-US\" \
        --strip-comments \
        --css \"$TEMP_CSS\""

    # Add Lua filter if it exists
    if [ -f "$LUA_FILTER" ]; then
        CMD="$CMD --lua-filter \"$LUA_FILTER\""
    fi

    # Execute the command
    eval $CMD
    if [ $? -eq 0 ]; then
        echo "EPUB generated: $OUTPUT_EPUB"
        # Validate EPUB if epubcheck is available
        if [ "$EPUBCHECK_AVAILABLE" = true ]; then
            echo "Validating EPUB..."
            epubcheck "$OUTPUT_EPUB"
            if [ $? -eq 0 ]; then
                echo "EPUB is valid for KDP."
            else
                echo "EPUB validation failed. Check errors above."
            fi
        fi
    else
        echo "Error generating EPUB."
        return 1
    fi
}

# Run generation
generate_epub

# Clean up temporary CSS file
rm -f "$TEMP_CSS"
