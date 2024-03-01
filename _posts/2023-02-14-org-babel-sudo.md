---
author: cissic
date: 2023-02-14 Tue
tags: 'org-mode org-babel sudo'
title: 'Running sudo commands in org-babel'
---


# Running sudo commands in org-babel

Tramp-mode is useful or running sudo commands in org-babel. Just add `:dir /sudo::`
to src block preamble like this:

    #+begin_src sh :dir /sudo::
    sudo blkid
    #+end_src

and in the bottom line Emacs will ask you about the password.


## Links

-   <https://emacs.stackexchange.com/questions/39158/how-to-execute-sudo-command-in-org-babel-in-relative-path-under-current-working>

-   <https://www.reddit.com/r/orgmode/comments/lercjw/tip_org_babel_sudo_command/>

