---
author: cissic
date: 2022-11-20 Sun
tags: 'org-mode'
title: 'Admonitions in different formats'
---


# Admonitions in different formats


## Problem

If the document written in org-mode is intended to be published there might 
appear an idea to have your own style for some parts of the text. 
These special parts are commonly called *admonitions*.
There are two ways of handling the problem.


## Solution 1: Definitios of your own enviroments \label{Sec:own-environments}

\ref{Sec:own-environments}
Let us assume that we would like to have the box for warnings. After writing the 
following code in an org file:

    
    #+LATEX_CLASS: article      
    
    * Chapter 1
    This is the text.
    
    #+begin_warning
    This text should be in a warning box.
    #+end_warning      

we would like to have it export to the specific format (for example to pdf via pdflatex,
using `C-c C-e l p`). However the pdf file will be produced with errors, since after the export .tex includes the following statement:

    \begin{warning}
    This text should be in a warning box.
    \end{warning}

and the `warning` enviroment is not defined in it.
We can instruct LaTeX how to interpret these lines by adding our own `warning` environement. The suitable org file could have for example the following content:

    
    #+LATEX_CLASS: article      
    #+LATEX_HEADER:\newenvironment{warning}
    #+LATEX_HEADER:    {\begin{center}
    #+LATEX_HEADER:    \begin{tabular}{|p{0.9\textwidth}|}
    #+LATEX_HEADER:    \hline\\
    #+LATEX_HEADER:    }
    #+LATEX_HEADER:    { 
    #+LATEX_HEADER:    \\\\\hline
    #+LATEX_HEADER:    \end{tabular} 
    #+LATEX_HEADER:    \end{center}
    #+LATEX_HEADER:    }
    
    * Chapter 1
    This is the text.
    
    #+begin_warning
    This text should be in a warning box.
    #+end_warning      

Of course, the downside of this approach is that the users need to define all the needed 
admonitions, for all the needed backends (LaTeX, HTML, Markdown, Jupyter, etc.)
by themselves which is rather a daunting task. 
On the other hand by defining your own styles for the needed admonitions 
your code is independent from the external packages (see \ref{Sec:external-packages})


## Solution 2: Using environments defined in external packages

\label{Sec:external-packages}

The counterapproach to the solution presented in Section \ref{Sec:own-environments} is using external packages. 
One of them is `org-special-block-extras` ([Homepage](http://alhassy.com/org-special-block-extras/), [MELPA](https://melpa.org/#/org-special-block-extras), [github](https://github.com/alhassy/org-special-block-extras)).

You can install it with the use of `M-x list-packages`.

Since `org-special-block-extras` package uses `tcolorbox` class when exporting
to LaTeX you need to remember to add this package manually to LaTeX header in an .org file. Since for other blocks `org-special-block-extras` uses also `multicol` package 
it's better to add it in advance, in case we will use other features of the package.

The example of usage of this package is presented below. Details can be found in the links given above. All in all, 

    
    #+LATEX_CLASS: article
    #+LATEX_HEADER: \usepackage{tcolorbox}
    #+LATEX_HEADER: \usepackage{multicol}
    
    * Chapter 1
    This is the text.
    
    #+begin_details NAME :title-color "green"
    #+begin_box Box title
    This text should be in a warning box.
    #+end_box
    #+end_details
    
    #+begin_details NAME :title-color "green"
    # #+begin_box Box title
    This text should be in a warning box.
    # #+end_box
    #+end_details
    
    #+begin_details NAME :title-color "red"
    # #+begin_box Box title
    This text should be in a warning box.
    # #+end_box
    #+end_details
    
    
    #+begin_box Box title 
    This text should be in a standard box.
    #+end_box
    
    #+begin_box Box title :background-color green 
    This text should be in a green box.
    #+end_box
    
    #+begin_red
    This text should be red.
    #+end_red


## Helpful Links:

-   How to force newline inside macro: <https://stackoverflow.com/questions/22132603/define-org-mode-macro-with-line-breaks>
-   variables in emacs: <https://with-emacs.com/posts/tutorials/almost-all-you-need-to-know-about-variables/>
-   hooks in emacs: <https://with-emacs.com/posts/tutorials/what-you-need-to-know-about-hooks/>

