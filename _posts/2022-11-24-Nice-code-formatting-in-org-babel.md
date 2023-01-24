---
author: cissic
date: 2022-11-24 Thu
tags: 'org-babel latex org-mode emacs'
title: 'Nice code formatting in org-babel'
---


# TODO Nice code formatting in org-babel

When exporting to LaTeX there are possible two packages for producing
pretty code listings: `lstlistings` and `minted` (UPDATE: In 2022 there
has appeared another exporting option called `engraved`).

The drawback of `lstlistings` is that it is no longer maintened (at the time
of writing this), the drawback of `minted` is that depends on
on external resource (`minted` uses `Pygmentize` which is a `Python` package,
so you need to have `Python` and `Pygmentize` package installed).

Links on the subject:

-   <https://orgmode.org/manual/Source-blocks-in-LaTeX-export.html>
-   <https://emacs.stackexchange.com/questions/27982/export-code-blocks-in-org-mode-with-minted-environment>
-   <https://tex.stackexchange.com/questions/200698/emacs-org-mode-minted-export-with-attr-latex>
-   

Since `mint` seems to be a more robust and recommended way of dealing with
code listings, and furthermore Python is already installed on most
Linux distributions then we'll try to manage with it.


## Source blocks

The following instructions are based on
[this post](https://stackoverflow.com/questions/46438516/how-to-encapsualte-code-blocks-into-a-frame-when-exporting-to-pdf).
Nice tutorial is [here](https://orgmode.org/worg/org-tutorials/org-latex-export.html).

1.  We need to have Python installed and `Pygments` package.

    
    pip install Pygments

1.  In org file preamble you need the line: `#+LaTeX_HEADER: \usepackage{minted}`, but
    this is covered [below](#org6834646).

2.  In `init.el` you could put something like this: <a id="org6834646"></a>

    
    (setq org-latex-listings 'minted
       org-latex-packages-alist '(("" "minted"))
       org-latex-pdf-process
       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

However this will change the global settings of latex exporter.
Especially the triple pdflatex compiling takes a while when exporting, and I believe
it's better to have it enabled only per project that really needs that kind of treatment.

That is why I prefer have it done per local file:

    
    #+TITLE: Some title
    #+AUTHOR: Some author
    #+LATEX_CLASS: article
    
    
    * Minted source highlighting
    :PROPERTIES:
    :PRJ-DIR: ./2023-11-24-nice-code-format/
    :END:  
    
    #+begin_src sh :exports both :tangle (concat (org-entry-get nil "PRJ-DIR" t) "") :mkdirp yes
    ls -la 
    #+end_src

When exporting code like in the example above we use `minted`, but without any
special options. To see `minted` in work we can, for example, add `#+ATTR_LATEX` keyword
with the options for minted environment.

    #+ATTR_LATEX: :options frame=single
    #+begin_src python :exports code :tangle (concat (org-entry-get nil "PRJ-DIR" t) "hello.py") :mkdirp yes 
       print("Hello world")
    #+end_src

To have this attribute always on we can, instead of using the following code
at the bottom of the file:

    
    ,# Local Variables:
    ,# eval: (setq org-latex-listings 'minted
    ,#  org-latex-packages-alist '(("" "minted"))
    ,#  org-latex-pdf-process
    ,#  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    ,#    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    ,#    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
    ,# End:

use something like this

    
    # Local Variables:
    # eval: (setq org-latex-listings 'minted
    #  org-latex-packages-alist '(("" "minted"))
    #  org-latex-minted-options '(("bgcolor" "red") ("frame" "lines"))
    #  org-latex-pdf-process
    #  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    #    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    #    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
    # End:

A now you don't need to add option `#+ATTR_LATEX` per each source block.


## Result blocks

Another problem appears when you would like to have blocks of results
formatted.

In such a case the way to go is to define LaTeX environment
that would be based on minted environement.
Of course, it should be defined in org-file preamble.
Now, if we `wrap` the results of the block evaluation like in the example
below and export results as `raw` everything should work as expected.
After hitting `C-c C-c` when cursor is on code block, the results
block appears embraced with `#+begin_resultsminted #+end_resultsminted`
keywords. This should be exported to pdf as defined
in `resultsminted` package.

    
    #+TITLE: Some title
    #+AUTHOR: Some author
    #+LATEX_CLASS: article
    
    #+LaTeX_HEADER: \usepackage{color}
    #+LaTeX_HEADER: \definecolor{my-gray}{rgb}{0.9,0.9,0.9}
    #+LaTeX_HEADER: \newenvironment{resultsminted}
    #+LaTeX_HEADER: {\VerbatimEnvironment
    #+LaTeX_HEADER: \begin{minted}[
    #+LaTeX_HEADER: % linenos,
    #+LaTeX_HEADER: % fontfamily=courier,
    #+LaTeX_HEADER: % fontsize=\scriptsize,
    #+LaTeX_HEADER: % xleftmargin=21pt,
    #+LaTeX_HEADER: bgcolor=my-gray,
    #+LaTeX_HEADER: frame=single
    #+LaTeX_HEADER: ]{latex}}
    #+LaTeX_HEADER: {\end{minted}}
    
    
    
    * Minted source highlighting
    :PROPERTIES:
    :PRJ-DIR: ./2023-11-24-nice-code-format/
    :END:  
    
    #+begin_src sh :exports both :tangle (concat (org-entry-get nil "PRJ-DIR" t) "") :mkdirp yes :wrap resultsminted :results raw
      ls -la 
    #+end_src
    
    # Local Variables:
    # eval: (setq org-latex-listings 'minted
    #  org-latex-packages-alist '(("" "minted"))
    #  org-latex-minted-options '(("bgcolor" "red") ("frame" "lines"))
    #  org-latex-pdf-process
    #  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    #    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    #    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
    # End:

