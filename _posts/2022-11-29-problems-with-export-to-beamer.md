---
author: cissic
date: 2022-11-29 Tue
tags: 'org-mode beamer export'
title: 'Beamer exporter not working (EDITED: 2023.05.29)'
---


# Beamer exporter not working (EDITED: 2023.05.29)


## Problem and solution

While working in Emacs 27.1 I encountered on a problem that comes down to
unavailability of exporting to beamer. So:
 :C-c C-e l b
didn't work.
Besides when exporting a file I got  `unknown "nil" back-end` error.

After many hours of searching and trying for example to explicitely import `ox-beamer` which seems
to be embedded into emacs I finally found solution in the 
[internet](https://github.com/larstvei/ox-gfm/issues/28). 

To solve the problem I needed to do:

    C-u M-x org-reload


## Another solution

It appears that beamer exporter can be enabled by

    M-x org-beamer-mode

