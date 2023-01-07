---
author: cissic
date: 2022-12-23 Fri
tags: 'emacs org TODO'
title: 'Bibliography and org-mode'
---


# Bibliography and org-mode


## Problem

How to write in `org` and use bibliography files? 
New, simple and universal way of management of bibliography appeared quite recently in Emacs. It's described in the following links: 
[org-man](https://orgmode.org/manual/Citations.html), 
[author's blog](https://blog.tecosaur.com/tmio/2021-07-31-citations.html), 
[stackexchange post](https://emacs.stackexchange.com/questions/71817/how-to-export-bibliographies-with-org-mode). 

There are some problems with it on my Debian Bullseye. Probably it's too new to work out of the box. It seems that it was introduced in `Org 9.6`, and `Org 9.6` it too new for Emacs from Bullseye repositories.

These problems were described in previous post and are mentioned 
[here](https://github.com/syl20bnr/spacemacs/issues/15360), 
[here](https://www.reddit.com/r/emacs/comments/zd3l7p/org_mode_elpa_intall_invalid_function/) and 
[here](https://list.orgmode.org/87bkonzisl.fsf@gnu.org/T/#u).

Since I don't have time to deal with all those troubles I decided to give up this apprach for now. I'm going to come back again when all those teething problems are solved in the next versions of org and emacs...


## Solution

For now I decided to use some simple workaround. Assuming we have a bib file like this: 

    
    @article{a1,
      title = {Art 1},
      author = {Author, A.},
      year = {1997},
      month = jul,
      journal = {journal},
      volume = {20},
      number = {1},
      pages = {51--61},
    }
    
    @article{a2,
     title = {Art 2},
     author = {Author, B.},
     year = {1997},
     month = jul,
     journal = {journal},
     volume = {20},
     number = {1},
     pages = {51--61},
    }

we can attach it to org-mode document like this:

    
    #+TITLE: Some title
    #+AUTHOR: Some author
    #+LATEX_CLASS: article      
    #+BIBLIOGRAPHY: biblio.bib 
    
    * Chapter 1
    This is the text. \cite{a1}, \cite{a2}
    
    \bibliography{biblio}
    \bibliographystyle{plain}
    
    
    # Local Variables:
    # eval: (setq org-latex-pdf-process (list "latexmk -pdflatex='latex -shell-escape -interaction nonstopmode' -pdf -f  %f"))
    # End:

