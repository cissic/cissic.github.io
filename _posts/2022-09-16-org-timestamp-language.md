---
author:
- cissic
date: '\<2022-09-08 thu\>'
tags: 'emacs org-mode '
title: 'How to set the language of org-mode timestamps'
---

How to set the language of org-mode timestamps {#how-to-set-the-language-of-org-mode-timestamps-1}
----------------------------------------------

<https://stackoverflow.com/questions/28913294/emacs-org-mode-language-of-time-stamps>

``` {.example}
;; System locale to use for formatting time values.
(setq system-time-locale "C")         ; Make sure that the weekdays in the
                                      ; time stamps of your Org mode files and
                                      ; in the agenda appear in English.
```
