
# Table of Contents

<<<<<<< HEAD
1.  [Properties in org-mode](#orga7c315f)
    1.  [Properties in org-mode](#org2f36db5)
        1.  [Problem - the beggining](#org5059fb8)
    2.  [Useful links:](#org950780f)



<a id="orga7c315f"></a>
=======
1.  [Properties in org-mode](#org931b892)
    1.  [Properties in org-mode](#orgd8ecd67)
        1.  [Problem - the beggining](#orgf2b82a9)
    2.  [Useful links:](#orgdd7e1ce)



<a id="org931b892"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

# TODO Properties in org-mode


<<<<<<< HEAD
<a id="org2f36db5"></a>
=======
<a id="orgd8ecd67"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

## Properties in org-mode


<<<<<<< HEAD
<a id="org5059fb8"></a>
=======
<a id="orgf2b82a9"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

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


<<<<<<< HEAD
<a id="org950780f"></a>
=======
<a id="orgdd7e1ce"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

## Useful links:

