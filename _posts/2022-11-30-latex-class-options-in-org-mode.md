&#x2014;
author: cissic
date: 2022-11-30 Wed
tags: 'org-mode latex-class options'
title: 'Adding options when loading LaTeX class in org-mode'
&#x2014;


# Adding options when loading LaTeX class in org-mode


## Problem and solution

When loading LaTeX class you may sometimes want to add specific options.
For example you may want to have 16:9 aspect ratio which in plain latex is added
with:

    \documentclass[aspectratio=169]{beamer}

To add this option when using  (for example) beamer in org-mode, just do

    #+STARTUP: ...
    #+OPTIONS: ....
    #+LATEX_CLASS: beamer
    #+LATEX_CLASS_OPTIONS: [presentation,aspectratio=169]
    ...

This solution can be found [here](https://tex.stackexchange.com/a/259062).

