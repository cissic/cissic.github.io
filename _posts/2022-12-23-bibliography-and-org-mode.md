---
author: cissic
date: 2022-12-23 Fri
tags: 'emacs org TODO'
title: 'Bibliography and org-mode'
---


# Bibliography and org-mode Some title Some title


## Problem

`Org-cite` -- a new way of handling citations appeared in Org 9.6.
This approach was to be built-in org it seems to be promising and future
technique for handling bibliography. I was encouraged to try it after
reading this links:

-   <https://orgmode.org/manual/Citations.html>
-   <https://kristofferbalintona.me/posts/202206141852/>
-   <https://github.com/jkitchin/org-ref>
-   <https://blog.tecosaur.com/tmio/2021-07-31-citations.html#fn.3>
-   <https://emacs.stackexchange.com/questions/71817/how-to-export-bibliographies-with-org-mode>
-   <https://www.reddit.com/r/orgmode/comments/vchefn/guide_to_citations_in_orgmode/>

So I decided to use is it instead of
spending my time on configuring venerable `org-ref`.

The problem appeared soon because it turned out in my Emacs distribution
(Debian Bullseye's Emacs 27.1) the built-in org version was 9.3.
First, I tried to install `oc` files downloaded from here:

<https://git.entf.net/dotemacs/files.html>
<https://git.entf.net/dotemacs/file/elpa/org-9.5/oc-natbib.el.html>
<https://git.entf.net/dotemacs/file/elpa/org-9.5/oc.el.html>

spent several hours on fighting with that and... didn't succeed.

Finally I was enlighted and decided not to struggle with org 0.3
but just upgrade it.
That went a bit easier, however not without problems.
(see the post "Problems with Emacs 27.1 and org 9.6").

Anyway I finally managed to have `org-cite` working with my Emacs.

The problem I have now is that for it's working only  with "basic" exporter,
but I hope I'll deal with that soon.


### How to use org-cite?

So now handling citations (with "basic" export method) is realy as easy
as it is described in manual.

The only thing to remember is that you may need to explicitely load
`oc` package in your init file (`(require 'oc)`).

Assuming we have a bib file like this: 

@article{a1,
  title = {Art 1},
  author = {Author, A.},
  year = {1997},
  month = jul,
  journal = {journal},
  volume = {20},
  number = {1},
  pages = {51--61},
}

 @article{a2,
  title = {Art 2},
  author = {Author, B.},
  year = {1997},
  month = jul,
  journal = {journal},
  volume = {20},
  number = {1},
  pages = {51--61},
 }
\#+end<sub>src</sub>
we can attach it to org-mode document like this:

    
    #+TITLE: Some title
    #+AUTHOR: Some author
    #+LATEX_CLASS: article
    #+CITE_EXPORT: basic
    #+BIBLIOGRAPHY: biblio.bib 
    
    * Chapter 1
    
    
    #+PRINT_BIBLIOGRAPHY:

Inserting items is done via `org-cite-insert` command, binded by default to
`C-c C-x @`.


## [DEPRECATED description] Problem

How to write in `org` and use bibliography files? 
New, simple and universal way of management of bibliography appeared quite recently in Emacs. It's described in the following links: 
[org-man](https://orgmode.org/manual/Citations.html),
[author's blog](https://blog.tecosaur.com/tmio/2021-07-31-citations.html),
[stackexchange post](https://emacs.stackexchange.com/questions/71817/how-to-export-bibliographies-with-org-mode).

There are some problems with it on my Debian Bullseye. Probably it's too new to work out of the box. It seems that it was introduced in `Org 9.6`, and `Org 9.6` it too new for Emacs from Bullseye repositories.

These problems were described in previous post and are mentioned 
[here](https://github.com/syl20bnr/spacemacs/issues/15360), 
[here](https://www.reddit.com/r/emacs/comments/zd3l7p/org_mode_elpa_intall_invalid_function/) and 
[here](https://list.orgmode.org/87bkonzisl.fsf@gnu.org/T/#u).

Since I don't have time to deal with all those troubles I decided to give up this apprach for now. I'm going to come back again when all those teething problems are solved in the next versions of org and emacs...


### Solution

For now I decided to use some simple workaround. Assuming we have a bib file like this: 

    
    @article{a1,
      title = {Art 1},
      author = {Author, A.},
      year = {1997},
      month = jul,
      journal = {journal},
      volume = {20},
      number = {1},
      pages = {51--61},
    }
    
    @article{a2,
     title = {Art 2},
     author = {Author, B.},
     year = {1997},
     month = jul,
     journal = {journal},
     volume = {20},
     number = {1},
     pages = {51--61},
    }

we can attach it to org-mode document like this:

    
    #+TITLE: Some title
    #+AUTHOR: Some author
    #+LATEX_CLASS: article      
    #+BIBLIOGRAPHY: biblio.bib 
    
    * Chapter 1
    This is the text. \cite{a1}, \cite{a2}
    
    \bibliography{biblio}
    \bibliographystyle{plain}
    
    
    # ## Local Variables:
    # ## eval: (require 'oc-bibtex)
    # ## End:

