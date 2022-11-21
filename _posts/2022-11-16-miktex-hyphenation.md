

# Workaround \label{Sec:workaround}

After unsuccessful attempts to make hyphenation rules working in MikTeX
I decided to use a workaround, which comes down to adding command

    \sloppy

in the preamble of the LaTeX document (`#+LATEX_HEADER:\sloppy` in an .org file).


# Problem description

Basing on instructions presented on official MikTeX page I installed MikTeX

    echo "deb http://miktex.org/download/debian bullseye universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    
    sudo apt-get update
    sudo apt-get install miktex

and then I configured it. However there exist some problem with language support. hyphenation patterns etc, which prevents from compiling the following MWE:

:PRJ-DIR: ./2022-11-16-MikTeX-Hyph-MWE/

    \documentclass{article}  
    \usepackage{babel}
    \usepackage{polski}
    
    \clubpenalty = 10000
    \widowpenalty = 10000
    \sloppy
    
    \begin{document}
    To jest tekst w języku polskim.
    \end{document}

I tried to follow the hints from [here](https://tex.stackexchange.com/questions/365804/how-to-fix-the-warning-no-hyphenation-patterns-were-preloaded-for-babel-the-l), but with no success.

Finally I rebuilt the format by opening MikTeX Console and choosing

    Settings -> Formats -> (choose from a list) pdflatex 
    -> (click) Build format

and managed to compile with `\usepackage{polski}` without an error, however
I still kept obtaining words that exceeded the text column.
In the end I decided to use a workaround presented in section \ref{Sec:workaround}.

