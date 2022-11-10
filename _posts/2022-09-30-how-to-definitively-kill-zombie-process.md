---
author:
- cissic
date: '\<2022-09-30 Fri\>'
tags: 'linux command-line'
title: How to definitively kill zombie process
---

How to definitively kill zombie process {#how-to-definitively-kill-zombie-process-1}
---------------------------------------

Sometimes it may happen that process invoked by the parent process
becomes zombie and stays in the memory. It should be removed from the
task list when the parent process stops working, but what if the parent
process is to be running? In my case I run in Dolphin I invoked terminal
window (bash) to run pdflatex. Many unsuccesful pdf compilations lead to
the moment when I had many pdflatex zombie processes which resulted in
huge RAM usage. Running `killall pdflatex` didn\'t work.

### Solution

Run

``` {.example}
ps l
# or 
ps l | grep pdflatex
# or (for a better view)
pstree -p
# or 
pstree -p | grep pdflatex
```

to find id of the parent of all pdflatex zombie processes. In my case
the structure looked like

``` {.example}
 ├─dolphin(992)─┬─bash(1018)─┬─{pdflatex}(1033)
 │              │            ├─{pdflatex}(1034)
 │              │            ├─{pdflatex}(1035)
 │              │            ├─{pdflatex}(1036)
 │              │            ├─{pdflatex}(1046)
 │              │            ├─{pdflatex}(1047)
 │              │            ├─{pdflatex}(1048)
 │              │            ├─{pdflatex}(1049)
 │              │            └─{pdflatex}(1054)
...            ...                ...
```

Then I could kill bash by

``` {.example}
kill -9 1018
```

and retain its parent dolphin(992).