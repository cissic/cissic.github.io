
# Table of Contents

1.  [undefined reference warning](#orgca3c144)
    1.  [An example](#org8d43653)
    2.  [Solution - explanation:](#org23a21ad)

---
author: cissic
date: 2023-09-22 Fri
tags: 'org-mode latex export references'
title: 'undefined reference warning'
---


<a id="orgca3c144"></a>

# TODO undefined reference warning


<a id="org8d43653"></a>

## An example

When uncommenting the following line:

    This is formula (\ref{Eq:refA}). 

This is formula (\ref{Eq:refA}). 

`PDF file produced with warnings (undefined reference)` 
message is displayed, although everything is fine in the output.


<a id="org23a21ad"></a>

## Solution - explanation:

It seems that everything is fine with pdf (provided you are threes time 'pdflatex'-ing
the documenent like in:

    * COMMENT Local Variables
    
    # Local Variables:
    # eval: (add-hook 'org-export-before-processing-hook 
    # 'my/org-export-markdown-hook-function nil t)
    # eval: (setq org-latex-pdf-process
    #  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    #    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    #    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
    # End:

).

It's just like emacs is displaying the warning after the first iteration
of compilation. The second and the third compilation finish wihtout
errors but the 'empty messages of successful compilation' does
not hide the warning from the first compilation.

