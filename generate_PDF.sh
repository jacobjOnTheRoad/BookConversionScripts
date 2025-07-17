#!/bin/bash

# generate_pdf.sh
# Script to generate PDF from Markdown files in the current directory

# Set INPUT_DIR to the directory where this script is run from
INPUT_DIR=$(pwd)
# Output PDF file
OUTPUT_PDF="$INPUT_DIR/book1.pdf"
# Pandoc template for PDF (optional, set to empty string if not used)
TEMPLATE="$INPUT_DIR/book_template.tex"
# Lua filter for page breaks (download from https://raw.githubusercontent.com/pandoc-ext/pagebreak/main/pagebreak.lua and place in this directory)
LUA_FILTER="$INPUT_DIR/pagebreak.lua"

# Check if pandoc is installed
if ! command -v pandoc >/dev/null 2>&1; then
    echo "pandoc not installed. Install it with 'sudo apt install pandoc'."
    exit 1
fi

# Warn if Lua filter is missing
if [ ! -f "$LUA_FILTER" ]; then
    echo "Warning: pagebreak.lua not found at $LUA_FILTER. Download it from https://raw.githubusercontent.com/pandoc-ext/pagebreak/main/pagebreak.lua for unified page breaks."
fi

# Function to generate PDF
generate_pdf() {
    echo "Generating PDF from text files in $INPUT_DIR..."
    # Base command
    CMD="pandoc \"$INPUT_DIR\"/*.md -o \"$OUTPUT_PDF\" \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        -V fontsize=12pt \
        -V mainfont=\"Liberation Serif\" \
        --metadata title=\"The Crown and the Curse\" \
        --metadata author=\"Nyxalith Moonbinder\" \
        --toc \
        --toc-depth=2"

    # Add template if it exists
    if [ -f "$TEMPLATE" ]; then
        CMD="$CMD --template=\"$TEMPLATE\""
    else
        echo "Template file $TEMPLATE not found. Using default Pandoc template."
    fi

    # Add Lua filter if it exists
    if [ -f "$LUA_FILTER" ]; then
        CMD="$CMD --lua-filter \"$LUA_FILTER\""
    fi

    # Execute the command
    eval $CMD
    if [ $? -eq 0 ]; then
        echo "PDF generated: $OUTPUT_PDF"
    else
        echo "Error generating PDF."
        return 1
    fi
}

# Run generation
generate_pdf
