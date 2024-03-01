
# Table of Contents

1.  [How to set the language of org-mode timestamps](#orge0b164a)



<a id="orge0b164a"></a>

# How to set the language of org-mode timestamps

<https://stackoverflow.com/questions/28913294/emacs-org-mode-language-of-time-stamps>

    ;; System locale to use for formatting time values.
    (setq system-time-locale "C")         ; Make sure that the weekdays in the
                                          ; time stamps of your Org mode files and
                                          ; in the agenda appear in English.

