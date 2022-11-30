&#x2014;
author: cissic
date: 2022-11-29 Tue
tags: 'org-mode beamer export'
title: 'Beamer exporter not working'
&#x2014;


# Beamer exporter not working


## Problem and solution

While working in Emacs 27.1 I encountered on a problem that comes down 
unavailability of exporting to beamer. So:
 :C-c C-e l b
didn't work.
Besides when exporting a file I got  `unknown "nil" back-end` error.

After many hours of searching and trying for example to exlicitely import `ox-beamer` which seems
to be embedded into emacs I finally found solution in the 
[internet](https://github.com/larstvei/ox-gfm/issues/28). 

To solve the problem I needed to do:

    C-u M-x org-reload

