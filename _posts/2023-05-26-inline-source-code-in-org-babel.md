---
author: cissic
date: 2023-05-26 Fri
tags: 'org org-mode org-babel org-babel-session'
title: 'Sourcing inline code blocks within the context of the named sessions in org-mode'
---


# TODO Sourcing inline code blocks within the context of the named sessions in org-mode


## TODO Todos:

This post needs some amendments. In the free time I need to
think why exporting of all org blocks does not work when exporting to
pdf while it works when exporting to html.
Besides, while exporting the last block of inline code, it does not
show the same result as the result that is evaluated in Emacs buffer!


## How to include inline source blocks in org-babel

When working in `org-mode`  `org-babel` you can stumble
upon a problem when
including inline blocks that should be run in the context of
a certain session.

Consider the following examples of the simplest inline sourcing:

-   This works:
    
        src_python{x = 5; return(x+2)}{{{results(=7=)}}}
    
    Returning:
    
    `7`

-   This does not work:
    
        src_python{x = 5; x+2}{{{results(=None=)}}} 
    
    The results is:
    
    `None`


## Named sessions and inline source blocks

However when the inline code is meant to be executed in the context
of some session the opposite is true!

    a = 4
    b = 3

-   The following 
    
        #+begin_src python :session *py_e* :tangle (concat (org-entry-get nil "PRJ-DIR" t) "example.py")     :mkdirp yes :exports code :exports yes :wrap export latex :eval yes :results both
           a = 4
           b = 3
        #+end_src
        
        src_python[:session *py_e*]{x = 5; return(x+a)} {{{results(==)}}}
    
    returns:
    
    ==

-   While the following 
    
        src_python[:session *py_e*]{x = 5; x+a} {{{results(=9=)}}}
    
    gives
    
    ==


## Python source blocks

Another possible point of problems is inappropriate drawers description.
Take for example the following pieces of code:

1.  Code 1
    
        #+begin_src python :session *py_e* :tangle (concat (org-entry-get nil "PRJ-DIR" t) "const_e.py") :mkdirp yes :exports code :exports results :wrap export latex :eval yes :results both
        # initialize session
        import sys
        sys.path.insert(1, '/home/mb/.emacs.d/myarch/')
        from pythonscripts4emacs import *
        
        a = 5
        #+end_src
        
        Now call python inline:
        a plus 2 is src_python[:session *py_e*]{x = 2; (x+a)} {{{results(=6=)}}}

2.  Code 2
    
        #+begin_src python :session *py_e* :tangle (concat (org-entry-get nil "PRJ-DIR" t) "const_e.py") :mkdirp yes :exports code :exports yes :wrap export latex :eval yes :results both
        # initialize session
        import sys
        sys.path.insert(1, '/home/mb/.emacs.d/myarch/')
        from pythonscripts4emacs import *
        
        a = 5
        #+end_src
        
        Now call python inline:
        a plus 2 is src_python[:session *py_e*]{x = 2; (x+a)} {{{results(=6=)}}}

In the first example everything is ok and the inline invoking
of python code in the expected result.

However in the second example drawer `exports` was described
inappropriately (`exports` can take the following values: `none`, `both`,
`code`, `results`).
This inappropriate word causes that inline invoking of python gives
no results!!!


## Links that can be useful

-   <https://lists.gnu.org/archive/html/emacs-orgmode/2015-03/msg01001.html>

