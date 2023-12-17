
# Table of Contents

1.  [Properties in org-mode](#orgd456098)
    1.  [Properties in org-mode](#orgfa35a3b)
        1.  [Problem - the beggining](#org1cffda4)
        2.  [Problem extension](#orgb0f9672)
    2.  [Solution](#orga1fe3f4)
    3.  [Useful links:](#org33ac5af)



<a id="orgd456098"></a>

# TODO Properties in org-mode


<a id="orgfa35a3b"></a>

## Properties in org-mode


<a id="org1cffda4"></a>

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


<a id="orgb0f9672"></a>

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

    <a id="orga917f90"></a>
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


<a id="orga1fe3f4"></a>

## Solution

It seems that [1.1.2.1](#orga5a26fc) does not work because Subheadline has no content.
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


<a id="org33ac5af"></a>

## Useful links:

