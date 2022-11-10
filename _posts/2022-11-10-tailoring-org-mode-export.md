---
TITLE: How to tailor the output of org-mode exporter to our needs
AUTHOR: cissic
DATE: 11-10-2022
TAGS: org-mode export-settings
---


# Problem

The problem appeared in a recent document. I used to use `pandoc` in order to 
transform an .org file into github flavoured .md, i.e when doing

    pandoc -s -t markdown file.org -o file.md

I can obtain content in markdown which includes the header that looks more or less like this:

    ---
    author:
    - cissic
    date: '\<2022-11-10 Thu\>'
    tags: 'org-mode export-settings'
    title: 'How to tailor the output of org-mode exporter to our needs'
    ---

This header is important, especially the 'tags' part, because basing on this my template assigns
tags to the post.

Everything worked fine until I decided to use a more sophisticated syntax for source parts of 
the text in my recent post. Namely I wrote:

    #+begin_src org :tangle (concat (org-entry-get nil "PRJ-DIR" t) "main-book.org") :mkdirp yes

This is too much for `pandoc` converter. An org file with such lines was all messed up.
I decided to use standard emacs exporter (`C-c C-e m m`), however when using it we need 
to instruct it to add special markdown header mentioned above. How can we do this?


# Solution

The solution can be found [here](https://emacs.stackexchange.com/questions/74505/how-can-i-add-specific-text-to-the-content-generated-by-org-mode-export-to-mark#74513).
We need to add 

    #+OPTIONS: -:nil

to the keywords at the start of the org-file in order to disable special treatment of minus sign during the export (This is described [here](https://orgmode.org/org.html#FOOT109).

Additionally we need to add the following to `init.el`:

    (defun org-export-md-format-front-matter ()
      (let ((lines (org-element-map (org-element-parse-buffer 'greater-element) 'keyword
    		 (lambda (keyword)
    		   (let* ((kw (org-element-property :key keyword)))
    		     (when (member kw '("AUTHOR" "DATE" "TAGS" "TITLE"))
    		       (format "%s: %s" kw (let ((val (org-element-property :value keyword)))
    					     (pcase kw
    					       ("DATE" (mapconcat #'number-to-string (org-date-to-gregorian val) "-"))
    					       (_ val))))))))))
        (concat "---\n" (concat (mapconcat #'identity lines "\n")) "\n---")))
    
    (defun my/org-export-markdown-hook-function (backend)
        (if (eq backend 'md)
    	(insert (org-export-md-format-front-matter) "\n")))
    
    (add-hook 'org-export-before-processing-hook #'my/org-export-markdown-hook-function)

Now, the file generated when exporting from .org to .md contains desired data.


# Helpful Links:

-   How to force newline inside macro: <https://stackoverflow.com/questions/22132603/define-org-mode-macro-with-line-breaks>

