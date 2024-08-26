
# Table of Contents

1.  [Colored ansi blocks in org-babel results](#org0040464)
    1.  [Problem description](#org1589668)
    2.  [Solution](#org8de3258)



<a id="org0040464"></a>

# TODO Colored ansi blocks in org-babel results


<a id="org1589668"></a>

## Problem description

Sometimes linux bash returns colored output, which is not
interpreted properly without additional intervention. This leads
to error while exporting to pdf.


<a id="org8de3258"></a>

## Solution

According to this thread:
<https://emacs.stackexchange.com/questions/44664/apply-ansi-color-escape-sequences-for-org-babel-results>
everything works fine with the use of the code below: 

    (defun ek/babel-ansi ()
      (when-let ((beg (org-babel-where-is-src-block-result nil nil)))
        (save-excursion
          (goto-char beg)
          (when (looking-at org-babel-result-regexp)
            (let ((end (org-babel-result-end))
                  (ansi-color-context-region nil))
              (ansi-color-apply-on-region beg end))))))
    (add-hook 'org-babel-after-execute-hook 'ek/babel-ansi)
    (buffer-file-name)

