---
author: cissic
date: 2023-02-22 Wed
tags: 'emacs org org-babel property'
title: 'Global and local properties in org-mode'
---


# Global and local properties in org-mode


## Example of using local (per section) org property

    #+TITLE: Post
    
    * Section 1
    :PROPERTIES:
    :PRJ-DIR: ./src1/
    :END:
    
    #+begin_src py :tangle (concat (org-entry-get nil "PRJ-DIR" t) "MWE1.py") :mkdirp yes :results verbatim :wrap resultsminted :eval no :export no
    s = " This is string"
    #+end_src


## Example of using global org property

    #+TITLE: Post
    #+PROPERTY: PRJ-DIR ./src2/
    
    * Section 1
    
    #+begin_src py :tangle (concat (org-entry-get nil "PRJ-DIR" t) "MWE2.py") :mkdirp yes :results verbatim :wrap resultsminted :eval no :export no
    s = " This is string 2"
    #+end_src

