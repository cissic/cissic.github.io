
# Table of Contents

<<<<<<< HEAD
1.  [Properties in org-mode](#org1fd49b8)
    1.  [Properties in org-mode](#org1978a5c)
        1.  [Problem - the beggining](#orga494130)
        2.  [Problem extension](#orgca070c6)
    2.  [Solution](#org8be1422)
    3.  [Useful links:](#org4582762)



<a id="org1fd49b8"></a>
=======
1.  [Properties in org-mode](#orgd456098)
    1.  [Properties in org-mode](#orgfa35a3b)
        1.  [Problem - the beggining](#org1cffda4)
        2.  [Problem extension](#orgb0f9672)
    2.  [Solution](#orga1fe3f4)
    3.  [Useful links:](#org33ac5af)



<a id="orgd456098"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

# TODO Properties in org-mode


<<<<<<< HEAD
<a id="org1978a5c"></a>
=======
<a id="orgfa35a3b"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

## Properties in org-mode


<<<<<<< HEAD
<a id="orga494130"></a>
=======
<a id="org1cffda4"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

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


<<<<<<< HEAD
<a id="orgca070c6"></a>
=======
<a id="orgb0f9672"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

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

<<<<<<< HEAD
    <a id="org86a4b40"></a>
=======
    <a id="orga917f90"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a
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


<<<<<<< HEAD
<a id="org8be1422"></a>

## Solution

It seems that [1.1.2.1](#org7b19d5e) does not work because Subheadline has no content.
=======
<a id="orga1fe3f4"></a>

## Solution

It seems that [1.1.2.1](#orga5a26fc) does not work because Subheadline has no content.
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a
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


<<<<<<< HEAD
<a id="org4582762"></a>
=======
<a id="org33ac5af"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

## Useful links:

