BookConversionScripts
Scripts to convert Markdown manuscripts to PDF and EPUB for self-publishing.

Prerequisites

Pandoc: For converting Markdown to PDF/EPUB.
TeX Live (for PDF output): Includes latexmk for LaTeX-based PDF generation.
Python (optional, if scripts use Python): Version 3.x.

Installation

Clone the repository:git clone https://github.com/jacobjOnTheRoad/BookConversionScripts.git
cd BookConversionScripts


Install dependencies:
On macOS: brew install pandoc texlive
On Ubuntu: sudo apt-get install pandoc texlive-full
On Windows: Download installers from the Pandoc and TeX Live websites.



Markdown Formatting for Conversion
To create a chapter title in your Markdown file, use a single #:
# Chapter One

For subheadings, use ## or ###:
## Section Title
### Subsection Title

For a page break in PDF output (using Pandoc), use three dashes:
---

Usage

Place your Markdown file (e.g., book.md) in the repository directory.
Run the monitor.sh script.  It will watch the directory for any file changes as long as the terminal is open.  Any time you save a file (for instance your book.md file or files) it will automatically run the generate_PDF.sh and generate_epub.sh for you.
Therefore, any time you save your .md file(s), you should get a pdf file and an epub file version of your book.

Remember that since your .epub and .pdf files are over-written any time you save your book files, it is up to you to save off those files to another folder any time you get to a good stopping point in order to have some version history.

Contributing
Submit issues or pull requests to improve the scripts!
License
MIT License
