
# Table of Contents

1.  [How to remove braces when printing elisp list of strings](#org40eacac)
    1.  [Problem description](#orgbe9e377)



<a id="org40eacac"></a>

# TODO How to remove braces when printing elisp list of strings


<a id="orgbe9e377"></a>

## Problem description

<https://stackoverflow.com/questions/18979300/how-to-convert-list-to-string-in-emacs-lisp>
or more specifically:
<https://stackoverflow.com/a/32580403/4649238>

    `(format)` will embed parentheses in the string, e.g.:
    
        ELISP> (format "%s" '("foo" "bar"))
        "(foo bar)"
    
    Thus if you need an analogue to Ruby/JavaScript-like `join()`, there is `(mapconcat)`:
    
        ELISP> (mapconcat 'identity '("foo" "bar") " ")
        "foo bar"

