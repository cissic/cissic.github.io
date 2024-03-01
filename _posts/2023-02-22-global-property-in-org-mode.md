

# Global and local properties in org-mode


## Example of using local (per section) org property

    #+TITLE: Post
    
    * Section 1
    :PROPERTIES:
    :PRJ-DIR: ./src1/
    :END:
    
    #+begin_src py :tangle (concat (org-entry-get nil "PRJ-DIR" t) "MWE1.py") :mkdirp yes :results verbatim :wrap resultsminted :eval no :export no
    s = " This is string"
    #+end_src


## Example of using global org property

    #+TITLE: Post
    #+PROPERTY: PRJ-DIR ./src2/
    
    * Section 1
    
    #+begin_src py :tangle (concat (org-entry-get nil "PRJ-DIR" t) "MWE2.py") :mkdirp yes :results verbatim :wrap resultsminted :eval no :export no
    s = " This is string 2"
    #+end_src


## IMPORTANT! Reloading (refreshing) properties

I don't know the why but after editing changing the properties declared as
local the change is automatically taken into account during tangling.
However this is not true when the change is made in global propeties!
In order to make Emacs aware of the new value of the global property you need to
evaluate the code in preamble. This can be achieved by `C-c C-c` when the cursor
is in the preamble part of the code.

