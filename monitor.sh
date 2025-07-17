#!/bin/bash

# monitor.sh
# Directory monitoring script: Monitors the current directory for changes to .md files
# and triggers both PDF and EPUB generation scripts.

# Set INPUT_DIR to the directory where this script is run from
INPUT_DIR=$(pwd)

# Paths to generator scripts (assuming they are in the same directory)
PDF_SCRIPT="$INPUT_DIR/generate_pdf.sh"
EPUB_SCRIPT="$INPUT_DIR/generate_epub.sh"

# Ensure inotify-tools is installed
if ! command -v inotifywait >/dev/null 2>&1; then
    echo "inotify-tools not installed. Install it with 'sudo apt install inotify-tools'."
    exit 1
fi

# Function to generate both PDF and EPUB by calling the separate scripts
generate_all() {
    if [ -f "$PDF_SCRIPT" ]; then
        bash "$PDF_SCRIPT"
    else
        echo "PDF script not found at $PDF_SCRIPT"
    fi
    if [ -f "$EPUB_SCRIPT" ]; then
        bash "$EPUB_SCRIPT"
    else
        echo "EPUB script not found at $EPUB_SCRIPT"
    fi
}

# Initial generation
echo "Performing initial generation..."
generate_all

# Monitor directory for changes to .md files
echo "Monitoring $INPUT_DIR for changes to .md files..."
inotifywait -m "$INPUT_DIR" -e close_write -e moved_to |
    while read -r directory events filename; do
        if [[ "$filename" =~ \.md$ ]]; then
            echo "Detected change in $filename. Regenerating PDF and EPUB..."
            generate_all
        fi
    done
