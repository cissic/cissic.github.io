
# Table of Contents

1.  [Properties in org-mode](#org562af2e)
    1.  [Properties in org-mode](#orgdeebbbf)
        1.  [Problem - the beggining](#orgd6ec3a1)
    2.  [Useful links:](#org15e6e06)



<a id="org562af2e"></a>

# TODO Properties in org-mode


<a id="orgdeebbbf"></a>

## Properties in org-mode


<a id="orgd6ec3a1"></a>

### Problem - the beggining

Let's say we've got the following org file

    * Section about src_elisp{(org-entry-get nil "Name")}
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Name")}
    :PROPERTIES:
    :Name:     W.A. Mozart
    :END:
    
    
    #+begin_src elisp :eval yes :results output :exports both
    
     (defun level1-headlines-filter ()
      (setq headline (org-entry-get nil "ITEM"))
      (setq allHeadlines (list headline) )    
      )
    
    (setq level1-headlines (org-map-entries #'level1-headlines-filter "LEVEL=1") )
    
    (defun my-export ()
      (while level1-headlines
        (setq tytul (nth 0 (car level1-headlines)) )
        (print (concat "\n- " tytul  ))
    
        (setq level1-headlines (cdr level1-headlines)))
      (print "\n " )
      )
    
    
    (print level1-headlines)
    
    #+end_src

    
    (("{{{title}}}") ("COMMENT Solution") ("Useful links:"))


<a id="org15e6e06"></a>

## Useful links:

