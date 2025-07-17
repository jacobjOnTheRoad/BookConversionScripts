To use:

Copy all the scripts into a folder.  Your book contents should be in the same folder in .md files.  I've been using UTF-8 text file format.

Open a terminal and run ./monitor.sh.  It will watch the folder for any saves.  Any time you save, it will kick off both generate_PDF.sh and generate_epub.sh - your .md files will have their contents copied into each in sequential sort order by the .md file name.  When the script finishes, you should have a PDF file and an epub file (this is used by Amazon KDP).  Note that every time you save, it overwrites the previous of both of those two, so if you want to keep old versions around, copy / save off at some point for each checkpoint you want.

Make sure to keep those checkpoints in a different folder -> by copying away the .pdf and .epub files when you reach good points.

The file watcher will keep running as long as your terminal is open running the script.  If there are ever any errors, you should be able to see them in the terminal history.

Here are the basics / how to use mark down for the simplest stuff in your text .md files:

If you want a new page (page break), put a \newpage on a line by itself in your story.md file:
The markdown for each instance below will in turn get converted into the appropriate tags for PDF and epub by their different generation scripts.

\newpage

If you want a chapter title, put a '#' character followed by a space, then the name of the chapter, like this:
# Chapter 1
or
# A New Beginning

If you want a subheader, put two of those: '##' followed by a space, then the subheader:
## Things get interesting
or
## Bugs get Burgled
