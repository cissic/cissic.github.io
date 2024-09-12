
# Table of Contents

1.  [sh and shell modifiers in org babel](#org2ed3525)
    1.  [Link](#org8b3252b)
    2.  [Problem description](#org83362ec)



<a id="org2ed3525"></a>

# TODO sh and shell modifiers in org babel


<a id="org8b3252b"></a>

## Link

<https://emacs.stackexchange.com/questions/35321/what-is-the-difference-between-sh-and-shell-for-org-babel>


<a id="org83362ec"></a>

## Problem description

The difference is which shell gets called to evaluate your block. shell calls whatever your default shell is while sh calls /bin/sh specifically. Your default shell is probably bash, which is an extension of sh. echo $0 will tell you what executable your shell is running:

    echo $0

    echo $0

Any of the shells in org-babel-shell-names that is installed on your system will work.

