---
author: cissic
date: 2022-11-10 Thu
tags: 'org-mode export-settings'
title: 'How to tailor the output of org-mode exporter to our needs'
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


# Solution - first try

The solution can be found [here](https://emacs.stackexchange.com/questions/74505/how-can-i-add-specific-text-to-the-content-generated-by-org-mode-export-to-mark#74513).
We need to add 

    #+OPTIONS: -:nil

to the keywords at the start of the org-file in order to disable special treatment of minus sign during the export (This is described [here](https://orgmode.org/org.html#FOOT109)).

And then we could just add the following to `init.el`:

    (defun org-export-md-format-front-matter ()
      (let* ((kv-alist (org-element-map (org-element-parse-buffer 'greater-element)
    		       'keyword
    		     (lambda (keyword)
    		       (cons (intern (downcase (org-element-property :key keyword)))
    			     (org-element-property :value keyword)))))
    	 (lines (mapcar (lambda (kw)
    			  (let ((val (alist-get kw kv-alist)))
    			    (format (pcase kw
    				      ('author "%s: %s")
    				      ((or 'tags 'title) "%s: '%s'")
    				      (_ "%s: %s"))
    				    (downcase (symbol-name kw))
    				    (pcase kw
    				      ('date (substring val 1 -1))
    				      (_ val)))))
    			'(author date tags title))))
        (concat "---\n" (concat (mapconcat #'identity lines "\n")) "\n---")))
    
    (defun my/org-export-markdown-hook-function (backend)
        (if (eq backend 'md)
    	(insert (org-export-md-format-front-matter) "\n")))
    
    (add-hook 'org-export-before-processing-hook #'my/org-export-markdown-hook-function)

Now, the file generated when exporting from .org to .md contains desired data.


# Solution - a better try

However the above mentioned approach has a drawback that it changes the way how the default Emacs to markdown
exporter works.

So the desired behaviour would be to have this edited way of exporting org files working only
for specific files. In particular, it would be convenient to change the exporter behaviour 
from within the file. In order to do this we need to make use of Emacs' 
[local variables](https://www.emacswiki.org/emacs/FileLocalVariables).

So what we need to do is to comment out the last line of the code above from the `init.el` to 
avoid loading hook globally. So `init.el` should be supplemented only with:

    (defun org-export-md-format-front-matter ()
      (let* ((kv-alist (org-element-map (org-element-parse-buffer 'greater-element)
    		       'keyword
    		     (lambda (keyword)
    		       (cons (intern (downcase (org-element-property :key keyword)))
    			     (org-element-property :value keyword)))))
    	 (lines (mapcar (lambda (kw)
    			  (let ((val (alist-get kw kv-alist)))
    			    (format (pcase kw
    				      ('author "%s: %s")
    				      ((or 'tags 'title) "%s: '%s'")
    				      (_ "%s: %s"))
    				    (downcase (symbol-name kw))
    				    (pcase kw
    				      ('date (substring val 1 -1))
    				      (_ val)))))
    			'(author date tags title))))
        (concat "---\n" (concat (mapconcat #'identity lines "\n")) "\n---")))
    
    (defun my/org-export-markdown-hook-function (backend)
        (if (eq backend 'md)
    	(insert (org-export-md-format-front-matter) "\n")))

The specific .org file should contain the following line at the beginning:

    #+OPTIONS: -:nil

and the following code at the bottom of the file:

    # Local Variables:
    # eval: (add-hook 'org-export-before-processing-hook #'my/org-export-markdown-hook-function nil t)
    # End:

Now have it working one needs to 

**save, close and open the file again**

after adding the above content (or just reload the file with commands `M-x revert buffer` or `C-x C-v RET`).


# Helpful Links:

-   How to force newline inside macro: <https://stackoverflow.com/questions/22132603/define-org-mode-macro-with-line-breaks>
-   variables in emacs: <https://with-emacs.com/posts/tutorials/almost-all-you-need-to-know-about-variables/>
-   hooks in emacs: <https://with-emacs.com/posts/tutorials/what-you-need-to-know-about-hooks/>

