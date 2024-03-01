---
author: cissic
date: 2022-11-27 Sun
tags: 'org-babel session'
title: 'Asynchronous org-babel sessions'
---


# Asynchronous org-babel sessions

Nice feature for blocks of code that are expected to run long.

There are few packages that implement this feature.
Unfortunately `async.el`  package does not support sessions.
On the other hand, I was not able to make [`ob-async`](https://github.com/astahlman/ob-async)
and [ob-session-async](https://github.com/jackkamm/ob-session-async)  (which are reportedly supporting sessions)
get to work.
In the end, I found a package [session-async.el](https://codeberg.org/FelipeLema/session-async.el/src/branch/main/README.md), which did what was promised.
The session showing the application of `session-async.el` is presented below:

    
    #+begin_src bash :async :exports both :session sTitle
      file="Done!"
      sleep 1s
      echo "$file" 
    #+end_src
    
    #+RESULTS:
    |                                                                      |
    | mb@debi:~/projects/cissic.github.io/mysource/public-notes-org$ Done! |
    
    
    #+begin_src bash :exports both :session sTitle
      echo "$file"
    #+end_src
    
    #+RESULTS:
    : Done!

