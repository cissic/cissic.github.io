---
author: cissic
date: 2023-01-17 Tue
tags: 'emacs org org-mode local-variables'
title: 'How to open an org file with local variables without being prompt about them?'
---
---
author: cissic
date: 2023-01-17 Tue
tags: 'emacs org org-mode local-variables'
title: 'How to open an org file with local variables without being prompt about them?'
---


# TODO How to open an org file with local variables without being prompt about them?


## Problem description

While writing this "blog" I have some commands stored in each org-file
which correspond to a single post, that changes the behaviour
of the default org-mode markdown exporter in order to do some
specific stuff automatically (See the post about tailoring org mode
export from <span class="timestamp-wrapper"><span class="timestamp">&lt;2022-10-10 Mon&gt;</span></span>). (I believe there exist some smarter
way of achieving this functionality, than to add local-variables
to each org file, but I'm going to leave it alone until
I get some more knowledge and proficiency in emacs lisp.)

The drawback of this solution is that emacs asks about
activating local variables every time any of those
org-file posts is being opened in editor.

[Here](https://www.reddit.com/r/emacs/comments/6rtwmo/how_do_you_open_a_file_but_keep_it_in_the/) I found a clue how can this be avoided. It seems
I should use the variable `enable-local-variables` but only
in the context of the files in a specific directory (directory
where my org-file posts are stored). 


### TODO Solution

I'd like to have `enable-local-variables` variable 

