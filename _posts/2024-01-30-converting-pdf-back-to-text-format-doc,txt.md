
# Table of Contents

1.  [Converting pdf back to text format (doc,txt)](#orgdbb1063)
    1.  [Problem description](#org63eae6c)
        1.  [With the use of LibreOffice:](#org7d60670)
        2.  [With the use of `poppler`](#org4b6869b)
    2.  [Useful links](#org745c9fc)



<a id="orgdbb1063"></a>

# TODO Converting pdf back to text format (doc,txt)


<a id="org63eae6c"></a>

## Problem description


<a id="org7d60670"></a>

### With the use of LibreOffice:

<https://askubuntu.com/questions/1259632/convert-pdf-to-word-using-libreoffice-in-terminal>
<https://stackoverflow.com/questions/63593345/how-to-convert-pdf-to-docx-in-libreoffice-6-4>


<a id="org4b6869b"></a>

### With the use of `poppler`

    sudo apt install poppler-utils

Now you can use

    pdftotext file.pdf

There are many options for the programme. You can see them with
`pdftotext -h`


<a id="org745c9fc"></a>

## Useful links

<https://www.linuxadictos.com/en/go-from-pdf-to-word.html>
<https://www.linuxuprising.com/2019/05/how-to-convert-pdf-to-text-on-linux-gui.html?m=1>

