---
author: cissic
date: 2023-01-10 Tue
tags: 'pdf bash pdftk cups'
title: 'Operations on pdfs and printing from command line'
---


# Operations on pdfs and printing from command line


## Problem description

In order to print documents from command line you may use `lpr` command as follows:

    printername=cups-pdf # your printer name
    lpr -P $printername temp.pdf


### Merging pdf pages into multipage layout

In order to print multiple pages per sheet you need to use external program `pdfjam`.
It is said to be a part of `TeXLive` distribution 
(If you don't have it you can always try:
`sudo apt install pdfjam`). Then you can write:

    pdfjam --nup 2x2 aaa.pdf 

I have stumbled upon a problem when trying to do like above. 
It turned out that in order to have the above command working
I need to have `pdflscape.sty` package in my LaTeX distribution.
Usually when working on Linux one have TeXLive with all LaTeX 
packages installed by default. 
Since I have MikTeX distribution with packages installed 
only when required (on-the-fly), in this case I needed to install 
`pdflscape` package explicitely.

In newest `MikTeX` you can do this as follows:

    miktex packages install pdflscape

In this way I could finally have pdfjam working.


### TODO Printing other files than pdf

You might encounter a problem when trying to print on `cups` printer 
non-pdf file, i.e. `.doc`.

TODO: 
<https://en.opensuse.org/SDB:Using_Your_Own_Filters_to_Print_with_CUPS>

1.  A workaround

    When printing LibreOffice documents you may find useful LibreOffice converter
    that enables exporting documents to different formats [like this](https://superuser.com/questions/91779/how-can-i-convert-an-openoffice-document-to-pdf-from-the-linux-command-line):
    
        soffice --headless --convert-to pdf  file.odt 
        soffice --headless --convert-to doc  file.odt 
        soffice --headless --convert-to html file.odt 
    
    Then you can process .pdf file with appropriate program/function etc.

