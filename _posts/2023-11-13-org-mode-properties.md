
# Table of Contents

1.  [Properties in org-mode](#org4f16311)
    1.  [Properties in org-mode](#org5549f06)
        1.  [Problem - the beggining](#org777f029)
        2.  [Problem extension](#org76109e7)
    2.  [Solution](#orge6cf673)
    3.  [Useful links:](#org53d3ea9)



<a id="org4f16311"></a>

# TODO Properties in org-mode


<a id="org5549f06"></a>

## Properties in org-mode


<a id="org777f029"></a>

### Problem - the beggining

Let's say we've got the following org file

    * Headline 1 with name taken from properties - src_elisp{(org-entry-get nil "Name")}
    :PROPERTIES:
    :Title:     Goldberg Variations
    :Name:  J.S. Bach
    :END:
    
    ** SubHeadline 

Since properties are not inherited by default
we cannot add `src_elisp{(org-entry-get nil "Name")}` in the subheadline,
because it ends with an error.

But we can turn the properties inheritance on like below (Do observe
the usage of `'selective` flag - without it the example wouldn't work!):

    # -*- mode: Org; org-use-property-inheritance: t -*- 
    * Headline 1 with name taken from properties - src_elisp{(org-entry-get nil "Name")}
    :PROPERTIES:
    :Title:     Goldberg Variations
    :Name:  J.S. Bach
    :END:
    
    ** SubHeadline  - src_elisp{(org-entry-get nil "Name" 'selective)}

1.  How to selectively inherit properties?

    -   See here: <https://emacs.stackexchange.com/questions/62423/forcing-inheritance-of-specific-properties-in-orgmode>


<a id="org76109e7"></a>

### Problem extension

Now we would like to keep properties in a different files and
treat it as some kind of database

    :PROPERTIES:
    :Title: Some New Title
    :Name:  Newman
    :END:

    :PROPERTIES:
    :Title: Title22222
    :Name:  Name22222
    :END:

1.  Approach 1

    <a id="org20ee726"></a>
    This won't work:
    
        # -*- mode: Org; org-use-property-inheritance: t -*- 
        * Headline 1 with name taken from properties - src_elisp{(org-entry-get nil "Name")}
        #+INCLUDE: ./properties.txt
        
        ** SubHeadline  - src_elisp{(org-entry-get nil "Name" 'selective)}

2.  Approach 2

    This does work but it's less convenient:
    
        # -*- mode: Org; org-use-property-inheritance: t -*- 
        * Headline 1 with name taken from properties - src_elisp{(org-entry-get nil "Name")}
        #+INCLUDE: ./properties.txt
        
        ** SubHeadline  - src_elisp{(org-entry-get nil "Name" 'selective)}
        #+INCLUDE: ./properties.txt


<a id="orge6cf673"></a>

## Solution

It seems that [1.1.2.1](#org7fd7b9b) does not work because Subheadline has no content.
If we add any latex white space or subsubheadline inside subheadline
everything works ok.

1.  Approach 4

    This does work but it's less convenient:
    
        ,# -*- mode: Org; org-use-property-inheritance: t -*- 
        * Headline 1 with name taken from properties - src_elisp{(org-entry-get nil "Name")}
        #+INCLUDE: ./properties.txt
        
        ** SubHeadline  - src_elisp{(org-entry-get nil "Name" 'selective)}
        \nbsp{}
        
        # # The lines below wouldn't work
        #** SubHeadline  - src_elisp{(org-entry-get nil "Name" 'selective)}
        #** SubHeadline  


<a id="org53d3ea9"></a>

## Useful links:

