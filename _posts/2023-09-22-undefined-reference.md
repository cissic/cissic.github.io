
# Table of Contents

1.  [undefined reference warning](#org04b48f4)
    1.  [An example](#orgff13a73)
    2.  [Solution - explanation:](#orgb8c54ae)

---
author: cissic
date: 2023-09-22 Fri
tags: 'org-mode latex export references'
title: 'undefined reference warning'
---


<a id="org04b48f4"></a>

# TODO undefined reference warning


<a id="orgff13a73"></a>

## An example

When uncommenting the following line:

    This is formula (\ref{Eq:refA}). 

This is formula (\ref{Eq:refA}). 

`PDF file produced with warnings (undefined reference)` 
message is displayed, although everything is fine in the output.


<a id="orgb8c54ae"></a>

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

