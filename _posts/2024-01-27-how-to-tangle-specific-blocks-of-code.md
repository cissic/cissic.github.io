
# Table of Contents

1.  [How to tangle specific blocks of code](#orgf90f3f7)
    1.  [Problem description](#orgfff3ff2)
    2.  [Hints:](#orgca7650c)
    3.  [Solution](#org20621a3)



<a id="orgf90f3f7"></a>

# TODO How to tangle specific blocks of code


<a id="orgfff3ff2"></a>

## Problem description

Let's say we have the following org file:
Now, I want to tangle only those source blocks that are
meant to be tangled to `target1.py` and filter out those ones that are meant
to be tangled to the other files.

According to [this](https://stackoverflow.com/questions/72270142/how-to-tangle-source-code-blocks-that-belong-to-a-specific-target-file) answer one should use:

    (org-babel-tangle-file "myfile.org" "target1.py")

The problem is that this command does not work as required.
It tangles **all** the source blocks and creates all three files,
not just `target1.py`.

I'm using `emacs 29.1` and `org-mode 9.6.1`.


<a id="orgca7650c"></a>

## Hints:

Basing on these threads:

-   <https://stackoverflow.com/a/28729080/4649238> and

-   <https://stackoverflow.com/questions/6156286/emacs-lisp-call-function-with-prefix-argument-programmatically>

I came up with a partial solution, which utilized the fact that
`org-babel-tangle` with two prefix arguments (meaning `C-u C-u` before
`C-c C-v t`) tangles all the blocks that has the target file the same
as the current block of code.

    (defun org-babel-tangle-with-2-prefix-args ()
      (interactive)
      (setq current-prefix-arg '(16)) ; 4 for C-u, 16 for C-u C-u
      (call-interactively 'org-babel-tangle))

But how to do it by giving the <span class="underline">name</span> of the target file?


<a id="org20621a3"></a>

## Solution

    a=11

    a=21

    b=12

    a=31

      (defun my/tangle-exclusively (source-file target-file)
        (let* ((visited (find-buffer-visiting file))
           (buffer (or visited (find-file-noselect file))))
    
    
          )
    
        )
    
    
    (my/tangle-exclusively "2024-01-27-how-to-tangle-specific-blocks-of-code.org" "target

