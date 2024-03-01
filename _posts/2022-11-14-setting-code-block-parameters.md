

# How to set the shortcut for source code settings

According to: <https://emacs.stackexchange.com/questions/40571/how-to-set-a-short-cut-for-begin-src-end-src>
we can add to `init.el` for example:

    (add-to-list 'org-structure-template-alist '("m" . "src python :session :exports results :results output latex replace "))

to add an item in the menu appearing after `C-c C-,`.


# Side note

The information given [here](https://kitchingroup.cheme.cmu.edu/blog/2014/01/26/Language-specific-default-headers-for-code-blocks-in-org-mode/) must be outdated becasue emacs spits out some error/warnings when I add lines from this link in my `init.el`.

