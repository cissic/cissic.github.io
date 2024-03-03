
# Table of Contents

1.  [Properties in org-mode](#org8e26af9)
    1.  [Approach 1](#org720aa11)
    2.  [Approach 2:](#org2c60efc)
    3.  [Approach 3:](#orgbe15d60)
    4.  [Approach 4:](#org23076c4)
    5.  [Approach 5:](#orgf688f57)
    6.  [Approach 6](#org2f58e90)
    7.  [Idea 7](#org69e3276)
    8.  [Idea 8](#org1b28681)
    9.  [Idea 9](#org0e7484f)
    10. [Idea 10](#orgf4044fd)
    11. [Useful links:](#org817505d)



<a id="org8e26af9"></a>

# TODO Properties in org-mode


<a id="org720aa11"></a>

## Approach 1

Given an org document, I'd like to traverse all headlines of the
given level and extract the headline title, provided that:

1.  Headline title can be generated by inline source blocks that use node properties, and
2.  I don't know beforehand what are the names of the node properties that are going to be used to generate the headline.

For example for the document given below:

    * Section about src_elisp{(org-entry-get nil "Name")} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} :this:
    :PROPERTIES:
    :Composer:     W.A. Mozart
    :END:
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
    
    (defun level1-headlines-filter ()
      (setq headline (org-entry-get nil "ITEM"))
      (setq props (org-get-entry))
      (setq string (concat headline "\n" props))
      (setq string (org-export-string-as string 'org t '(:with-toc nil)))
      (setq all (list string)))
    
    (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
    (print HEADLINES-PARSED)
    
    #+end_src

`HEADLINES-PARSED` should contain strings:

    "Section about J.S. Bach"
    "Section about W.A. Moz [[file:///home/mb/org/RDITiT/PrzewodyDoktorskie/Sidor_Kamil (2023)/2. Lista-obecnosci-na-obronie-publicznej.org]] art"

Now the results are:

    "Section about "
    "Section about "


<a id="org2c60efc"></a>

## Approach 2:

    * Section about src_elisp{(org-entry-get nil "Name")} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} :this:
    :PROPERTIES:
    :Composer:     W.A. Mozart
    :END:
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
    
    (defun replace-in-string (what with in)
      (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
    
    (defun level1-headlines-filter ()
      (let (headline props)
        (setq headline (org-entry-get nil "ITEM"))
        (setq props (org-get-entry))
        (setq string (replace-in-string "\n" ""(replace-in-string "* " "" (replace-in-string "=" "" (org-export-string-as (concat "* " headline "\n" props) 'org t '(:with-toc nil))))))
       ))
    
    (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
    (print HEADLINES-PARSED)
    
    #+end_src


<a id="orgbe15d60"></a>

## Approach 3:

    #+MACRO: mymacro an awesome macro
    #+MACRO: town Boston

    #+INCLUDE: ./mymacros.org
    
    * Section about src_elisp{(org-entry-get nil "Name")} from {{{town}}} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} and {{{mymacro}}} :this:
    :PROPERTIES:
    :Composer:     W.A. Mozart
    :END:
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
    
      (defun replace-in-string (what with in)
        (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
    
      (defun level1-headlines-filter ()
        (let (headline props)
          (setq headline (org-entry-get nil "ITEM"))
          (setq props (org-get-entry))
          (setq string 
                (replace-in-string "\n" "" 
                (replace-in-string "* " "" 
                (replace-in-string "=" "" 
                (org-export-string-as 
                  (concat "#+INCLUDE: mymacros.org" "\n" 
                          "* " headline "\n" props) 
                  'org t '(:with-toc nil))))))
         ))
    
      (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
      (print HEADLINES-PARSED)
    
    #+end_src


<a id="org23076c4"></a>

## Approach 4:

    #+PROPERTY: global-property property Name 

    * Section about src_elisp{(org-entry-get nil "Name")} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} and {{{mymacro}}} :this:
    :PROPERTIES:
    :Composer:     W.A. Mozart
    :END:
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
    
      (defun replace-in-string (what with in)
        (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
    
      (defun level1-headlines-filter ()
        (let (headline props)
          (setq headline (org-entry-get nil "ITEM"))
          (setq props (org-get-entry))
          (setq string 
                (replace-in-string "\n" "" 
                (replace-in-string "* " "" 
                (replace-in-string "=" "" 
                (org-export-string-as 
                  (concat "#+INCLUDE: mymacros.org" "\n" 
                          "* " headline "\n" props) 
                  'org t '(:with-toc nil))))))
         ))
    
      (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
      (print HEADLINES-PARSED)
    
    #+end_src


<a id="orgf688f57"></a>

## Approach 5:

    :Composer: Vivaldi

    :Town: New York

    * Section about src_elisp{(org-entry-get nil "Name")} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} from src_elisp{(org-entry-get nil "Town")} :this:
    :PROPERTIES:
    #+INCLUDE: myprop1.org
    #+INCLUDE: myprop2.org
    :END:
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
    
      (defun replace-in-string (what with in)
        (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
    
      (defun level1-headlines-filter ()
        (let (headline props)
          (setq headline (org-entry-get nil "ITEM"))
          (setq props (org-get-entry))
          (setq string 
                (replace-in-string "\n" "" 
                (replace-in-string "* " "" 
                (replace-in-string "=" "" 
                (org-export-string-as 
                  (concat 
                          "* " headline "\n" props) 
                  'org t '(:with-toc nil))))))
         ))
    
      (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
      (print HEADLINES-PARSED)
    
    (print (org-collect-keywords '("TITLE")) )
    (print (org-collect-keywords '("MYOWNKEYWORD")) )
    (print (org-collect-keywords '("PROPERTY")) )
    
    ;; (print "AAA")
    ;; (print org-global-properties)
    
    ;; (setq p (org-element-parse-buffer))
    ;; (print p)
    
    (org-collect-keywords '("MYOWNKEYWORD"))
    
    (print (nth 1 (nth 0 (org-collect-keywords '("MYOWNKEYWORD")))))
    (print (nth 1 (nth 0 (org-collect-keywords '("NEWKEY")))))
    (print (nth 1 (nth 0 (org-collect-keywords '("NEWKEY") nil "globalProps.org"))))
    
    #+end_src


<a id="org2f58e90"></a>

## Approach 6

    :Composer: Vivaldi

    :Town: New York

    #+MACRO: dateOfMeeting 22.11.2023
    #+MACRO: anotherMacro another Macro

    * Section about src_elisp{(org-entry-get nil "Name")} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} from src_elisp{(org-entry-get nil "Town")} :this:
    :PROPERTIES:
    #+INCLUDE: myprop1.org
    #+INCLUDE: myprop2.org
    :END:
    
    ** Subsection checking if properties included in the node above are still valid - The name of the composer: src_elisp{(org-entry-get nil "Composer")} <- should be here
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
      ; tests
      (setq stri "#+MACRO: macroname value and more")
      (setq firstSpace  (string-match " " stri))
      (print firstSpace)
      (setq propName (substring stri 0 firstSpace))
      (setq propVal  (substring stri (+ firstSpace 1) (length stri) ))
      (print propName)
      (print propVal)
    
    
       (defun macros2properties (inputFile outputFile)
         ;; Parse inputFile in search of lines beginning with #+MACRO: mName mVal
         ;; and transform them into property lines: :mName: mVal
         ;; in the outputFile
    
         (setq splitPos 0) ;; cursor position of split, for each line
         (setq restLine "")
         (setq moreLines t )
    
         ;; open the file
         (find-file inputFile)
         (goto-char (point-min)) ;; needed in case the file is already open.
    
    
         (find-file outputFile)
         (erase-buffer)
         (save-buffer)
         (kill-buffer (current-buffer))
    
         (while moreLines
           (search-forward "#+MACRO: ")
    
           (setq splitPos (1- (point)))
           (beginning-of-line)
           (setq fName (buffer-substring-no-properties (point) splitPos))
           (end-of-line)
    
           (setq restLine (string-trim (buffer-substring-no-properties splitPos (point) )))
    
           (setq firstSpace  (string-match " " restLine))
           (print firstSpace)
           (setq propName (substring restLine 0 firstSpace))
           (setq propVal  (substring restLine (+ firstSpace 1) (length restLine) ))
    
           ;; ;; create the file
           (find-file outputFile)
           (setq outString/property (concat ":" propName ": " propVal "\n"  ) )
           (insert outString/property)
    
           (save-buffer)
           (kill-buffer (current-buffer))
    
           (setq moreLines (= 0 (forward-line 1)))
           )
         )
    
    
      (defun replace-in-string (what with in)
        (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
    
      (defun level1-headlines-filter ()
        (let (headline props)
          (setq headline (org-entry-get nil "ITEM"))
          (setq props (org-get-entry))
          (setq string 
                (replace-in-string "\n" "" 
                (replace-in-string "* " "" 
                (replace-in-string "=" "" 
                (org-export-string-as 
                  (concat 
                          "* " headline "\n" props) 
                  'org t '(:with-toc nil))))))
         ))
    
      (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
      (print HEADLINES-PARSED)
    
      (macros2properties "./globalExtMacros.org" "./Output.org")
    
    ;; (setq aa "string")
    ;; (insert (concat ":" aa ":"))
    
    #+end_src


<a id="org69e3276"></a>

## Idea 7

    * Section about src_elisp{(org-entry-get nil "Composer")} from src_elisp{(org-entry-get nil "Town")} :this:
    :PROPERTIES:
    :Composer: value1
    :Town: value2
    :END:
    
    ** Subsection checking if properties included in the node above are still valid - The name of the composer: src_elisp{(org-entry-get nil "Composer")} <- should be here
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
      ; tests
    #+end_src


<a id="org1b28681"></a>

## Idea 8

org-mode exporting macros 

    
    #+MACRO: mymacro 12 cat 23
    
      * Section about src_elisp{(org-entry-get nil "Composer")} from src_elisp{(org-entry-get nil "Town")} :this:
      :PROPERTIES:
      :Composer: value1
      :Town: value2
      :END:
    
      ** Subsection checking if properties included in the node above are still valid - The name of the composer: src_elisp{(org-entry-get nil "Composer")} <- should be here
    
      * Code
      #+begin_src elisp :eval yes :results output :exports both
        ; tests
      #+end_src


<a id="org0e7484f"></a>

## Idea 9

Działa!!!!

    
    #+INCLUDE: ./mymacros.org
    
    * Section about src_elisp{(org-entry-get nil "Name")} from {{{town}}} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} and {{{mymacro}}} :this:
    :PROPERTIES:
    :Composer:     W.A. Mozart
    :END:
    
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
    
        (defun replace-in-string (what with in)
          (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
        (defun remove-text-up-to-asterisk (text)
          "Remove text from the beginning of the line to the first asterisk."
          (when (string-match "\\*" text)
            (setq text (substring text (match-end 0))))
          text)
    
        (defun level1-headlines-filter ()
          (let (headline props)
            (setq headline (org-entry-get nil "ITEM"))
            (setq props (org-get-entry))
            (setq string 
                  (string-trim ;replace-in-string "\n" "" 
                    ;(replace-in-string "* " "" 
                    (remove-text-up-to-asterisk
                    (replace-in-string "=" "" 
                    (org-export-string-as 
                      (concat "#+INCLUDE: mymacros.org" "\n" 
                              "* " headline "\n" props) 
                      'org t '(:with-toc nil)))))) ;)
             ))
    
          (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
          (print HEADLINES-PARSED)
    
    #+end_src


<a id="orgf4044fd"></a>

## Idea 10

Globalne wlasnosci

    
    #+INCLUDE: ./mymacros.org
    #+MACRO: AnotherComposer Vivaldi
    
    * Section about src_elisp{(org-entry-get nil "Name")} from {{{town}}} :this:
    :PROPERTIES:
    :Name:     J.S. Bach
    :END:
    
    * Section about src_elisp{(org-entry-get nil "Composer")} and {{{mymacro}}} :this:
    :PROPERTIES:
    :Composer:     W.A. Mozart
    :END:
    
    * Code
    #+begin_src elisp :eval yes :results output :exports both
    
       (defun replace-in-string (what with in)
            (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
    
       (defun remove-text-up-to-asterisk (text)
            "Remove text from the beginning of the line to the first asterisk."
            (when (string-match "\\*" text)
              (setq text (substring text (match-end 0))))
            text)
    
       (defun level1-headlines-filter ()
            (let (headline props)
              (setq headline (org-entry-get nil "ITEM"))
              (setq props (org-get-entry))
              (setq string 
                    (string-trim ;replace-in-string "\n" "" 
                      ;(replace-in-string "* " "" 
                      (remove-text-up-to-asterisk
                      (replace-in-string "=" "" 
                      (org-export-string-as 
                        (concat "#+INCLUDE: mymacros.org" "\n" 
                                "* " headline "\n" props) 
                        'org t '(:with-toc nil)))))) ;)
               ))
    
            (setq HEADLINES-PARSED (org-map-entries #'level1-headlines-filter "LEVEL=1+this") )
    
            (print HEADLINES-PARSED)
    
    
       (org-entry-get (org-element-at-point) "AnotherComposer")
    #+end_src
    
    * Example
    :PROPERTIES:
    :hellomessage: hello
    :END:
    
    #+NAME: get_property
    #+BEGIN_SRC elisp :var prop=""
            (org-entry-get nil prop t)
    #+END_SRC
    #+RESULTS: get_property
    
    #+BEGIN_SRC emacs-lisp :noweb yes
            (print "<<get_property("hellomessage")>>")
    #+END_SRC
    
    #+RESULTS:
    : hello
    
    #+BEGIN_SRC emacs-lisp :noweb yes
            (print "<<get_property("AnotherComposer")>>")
    #+END_SRC  
    
    #+RESULTS:
    : Vivaldi
    
    A tu przykład użycia inline:
    src_elisp[:noweb yes]{(print "<<get_property("AnotherComposer")>>")} 


<a id="org817505d"></a>

## Useful links:
