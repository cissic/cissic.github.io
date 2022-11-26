---
author: cissic
date: 2022-11-24 Thu
tags: 'org-babel latex org-mode emacs'
title: 'Nice code formatting in org-babel'
---


# Typesetting source blocks and result blocks


## 

Here's a nice example of how to format blocks of codes and results.
Based on <https://orgmode.org/worg/org-tutorials/org-latex-export.html>
and <https://orgmode.org/manual/Results-of-Evaluation.html>.

The example is based on `listings` package, while the [link](file:///home/mb/projects/cissic.github.io/mysource/public-notes-org/2022-11-24-nice-code/orglistings.md) mentions about another approach that 
is based on `minted` package (`lstlistings` is apparently abandoned project while `minted` is
being active one). The downside of `minted` is that it uses Python `pygmentize` package,
and needs running `latex` with `-shell-escape` modifier.

There are several important points in the example below. First, we need export results in latex
and use `:wrap flag` to take advantage of `org-special-block-extras` package. 
Having results surrounded with `#+begin_flag`  `org-special-block-extras` exports
content of `RESULTS` in `\begin{results} \end{results}`.

    ,  #+begin_src bash :exports both :results latex :wrap results
    ,  pwd
    ,  #+end_src
    
    ,  #+RESULTS:
    ,  #+begin_results
    ,  /home/mb/temp/AAAAAAAAAA/emacsminted
    ,  #+end_results

Now, all we need to do is to add `#+LaTeX_HEADER:` content to create appropriate 
environment that will handle the formatting of results block in latex:

    , #+LaTeX_HEADER: \usepackage{framed}
    , #+LaTeX_HEADER: \usepackage{xcolor}
    , #+LaTeX_HEADER: \definecolor{shadecolor}{gray}{.95}
    , #+LaTeX_HEADER: \newenvironment{results}{\begin{shaded}}{\end{shaded}}

The full, working example is given here:

    
    #+LATEX_CLASS: article
    #+LaTeX_HEADER: \usepackage{listings}
    #+LaTeX_HEADER: \lstnewenvironment{common-lispcode}
    #+LaTeX_HEADER: {\lstset{language={Lisp},basicstyle={\ttfamily\footnotesize},frame=single,breaklines=true}}
    #+LaTeX_HEADER: {}
    #+LaTeX_HEADER: \newcommand{\python}[1]{\lstset{language={Python},basicstyle={\ttfamily\small}}\lstinline{#1}}
    ,
    #+LaTeX_HEADER: \usepackage{framed}
    #+LaTeX_HEADER: \usepackage{xcolor}
    #+LaTeX_HEADER: \definecolor{shadecolor}{gray}{.95}
    #+LaTeX_HEADER: \newenvironment{results}{\begin{shaded}}{\end{shaded}}

