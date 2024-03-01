
# Table of Contents

1.  [General org-mode-book stencil](#orga93caa5)
    1.  [General book stencil consisting of indepenedent chapters/articles.](#Sec-general-book-stencil)
    2.  [Problem](#orgabd78ac)
    3.  [Org-mode tangling](#org770a632)

---
author: cissic
date: 2022-11-07 Mon
tags: 'org-mode literate-programming tangling'
title: 'Book stencil in org-mode'
---


<a id="orga93caa5"></a>

# General org-mode-book stencil


<a id="Sec-general-book-stencil"></a>

## General book stencil consisting of indepenedent chapters/articles.

I'd like to prepare an org-mode book stencil. Book should consist of several chapters/sections.
The main file with book content looks like this:

    
    #+LaTeX_CLASS: report      
    #+SETUPFILE: ./bookPreamble.org           
    * Chapter 1
    #+INCLUDE: "./chapters/ch1_main.org" :minlevel 2
    * Chapter 2
    #+INCLUDE: "./chapters/ch2_main.org" :minlevel 2  

where `bookPreamble.org` contains preamble for LaTeX (or any other format I might need), for example:

    #+TITLE: Book title
    #+AUTHOR: Book Authors
    #+LATEX_HEADER:\usepackage{hyperref} 
    #+LATEX_HEADER:\hypersetup{colorlinks=true,linkcolor=green,filecolor=magenta,urlcolor=green}

However, during the work I'd like to be able to compile each chapter as a seperate document (article) with its own title, authors etc. , so the content of `ch1.org` should look like this:

    #+LaTeX_CLASS: article
    
    #+SETUPFILE: ./artPreamble.org
    
    * Introduction
    * Section 1

where `ch1/artPreamble.org` contains LaTeX preamble for the first article, for example:

    #+TITLE: First Article - title
    #+AUTHOR: First Article/Section Author
    #+LATEX_HEADER:\usepackage{hyperref} 
    #+LATEX_HEADER:\hypersetup{colorlinks=true,linkcolor=blue,filecolor=magenta,urlcolor=blue}

Analogously, we can define 

    #+LaTeX_CLASS: article
    
    #+SETUPFILE: ./art2Preamble.org
    
    * Introduction to section/article 2
    * Section 1

    #+TITLE: Second Article - title
    #+AUTHOR: Second Article/Section Author
    #+LATEX_HEADER:\usepackage{hyperref} 
    #+LATEX_HEADER:\hypersetup{colorlinks=true,linkcolor=blue,filecolor=magenta,urlcolor=blue}


<a id="orgabd78ac"></a>

## Problem

The problem may appear if put any of the fields directly in an org file. For example, imagine 
that `main-book.org` looks like this:

    #+LaTeX_CLASS: report
    #+TITLE: Book title     
    
    #+SETUPFILE: ./bookPreamble.org
    * Chapter 1 ---
    #+INCLUDE: "./chapters/ch1_main.org" :minlevel 2
    * Chapter 2
    #+INCLUDE: "./chapters/ch2_main.org" :minlevel 2  

and `ch1.org` should looks like this:

    #+LaTeX_CLASS: article
    #+TITLE: First Article - title
    
    #+SETUPFILE: ./artPreamble.org
    
    * Introduction
    * Section 1

Since both files contain `#+TITLE` field placed directly in them when exporting 
book to pdf file, the title of pdf document will be a concatenation of all the title, 
i.e. it will be `"Book title First Article - title"`. To avoid this kind of situation
all the fields should be placed in setup files `bookPreamble.org` and
 `artPreamble.org` respectively, as it is shown in section [1.1](#Sec-general-book-stencil).


<a id="org770a632"></a>

## Org-mode tangling

This org-mode file can generate 
book project directory structure described in this document. 
Basing on the code placed in `#+begin_src #+end_src` blocks the directory structure is placed
inside `./2022-11-06-org-mode-book/`.
The procedure is called **tangling** and can be easily invoked by keyboard shortcut `C-c C-v t`.

