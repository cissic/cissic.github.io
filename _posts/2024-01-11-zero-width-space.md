
# Table of Contents

1.  [Zero width space](#org5c2a103)
    1.  [Problem description](#org24daac4)
    2.  [Solutions:](#org8262ed7)
        1.  [Add `-` (minus sign) if applicable](#orge841872)
        2.  [Use zero width space](#org91a60ef)
    3.  [WARNING!:](#org79ebbac)



<a id="org5c2a103"></a>

# TODO Zero width space


<a id="org24daac4"></a>

## Problem description

[org-mode manual](https://orgmode.org/manual/Escape-Character.html)

Sometimes you may need to concatenate some word written with org-mode
markup syntax with the one written in plain text. Leeaving no space
between these two word leads to loosing emacs markup feature.
Consider the example:

This word is **bold** ed, but you leave unwanted space between `bold` and `ed`. which
is visible after export process.

This word is not =bold=ed because you leave no space between two words in org-mode,
and you loose org-mode syntax.


<a id="org8262ed7"></a>

## Solutions:


<a id="orge841872"></a>

### Add `-` (minus sign) if applicable

It seems that adding minus sign does not intefere with org-mode syntax:

This word is **bold**-ed, and another one is `monospace`-d


<a id="org91a60ef"></a>

### Use zero width space

You can insert so-called `zero width space` as it is
explained in <https://orgmode.org/manual/Escape-Character.html>.
You do it by typing

    C-x 8 <RET> zero width space <RET>
    C-x 8 <RET> 200B <RET>

With this character you can write for example

    [X[1,2]]
    or
    *bold*Xed

where ‘X’ denotes the zero width space character, resulting in:

[​[1,2]]
or
**bold**​ed

Bingo!


<a id="org79ebbac"></a>

## WARNING!:

When using zero width space rememeber to add
`-interaction nonstopmode`
during pdflatex compilation. Otherwise you'll get an error.

If still obtaining an errors during latex compilation it may be
helpful to add to `#+LATEX_HEADER`.

    \ifTUTeX
      \usepackage{fontspec}
    \else
      \usepackage[T1]{fontenc}
      \usepackage[utf8]{inputenc} % The default since 2018
      \DeclareUnicodeCharacter{200B}{{\hskip 0pt}}
    \fi

