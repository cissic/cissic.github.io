---
author: cissic
date: 2023-10-10 Tue
tags: 'debian lenovo trackpoint scroll'
title: 'Kind of function local variables in elisp'
---


# Kind of function local variables in elisp

:PROPERTIES:
:PRJ-DIR: ./2023-10-10-local-vars/:


## Examples

`let` command 

    
    (setq var1 "var11")
    (setq var2 "var22")
    
    (defun test/a ()
      (setq var1 "AAA")
    
      (let ((var2 "BBB"))
      (print (concat var1 var2)) )
    )
    
    (test/a)
    (print (concat var1 var2))

