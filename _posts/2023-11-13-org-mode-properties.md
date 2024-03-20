
# Table of Contents

1.  [Properties in org-mode](#org73d19c7)
    1.  [Properties in org-mode](#org1f004bc)
        1.  [Problem - the beggining](#orgc0363df)
        2.  [Problem extension](#orga28e0c7)
    2.  [Solution](#org3da50e8)
    3.  [Useful links:](#org91c0a72)



<a id="org73d19c7"></a>

# TODO Properties in org-mode


<a id="org1f004bc"></a>

## Properties in org-mode


<a id="orgc0363df"></a>

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


<a id="orga28e0c7"></a>

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

    <a id="org63f4454"></a>
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


<a id="org3da50e8"></a>

## Solution

It seems that [1.1.2.1](#org9999e5e) does not work because Subheadline has no content.
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


<a id="org91c0a72"></a>

## Useful links:

