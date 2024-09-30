
# Table of Contents

1.  [Octave and org-babel](#org5f75199)
    1.  [How to get the functionality of showing octave figures like in GUI](#org12c595f)



<a id="org5f75199"></a>

# Octave and org-babel


<a id="org12c595f"></a>

## How to get the functionality of showing octave figures like in GUI

Running plot command without starting session, ends up in
closing figure window before anything is shown - Octave closess
immediately.

    close all
    h = figure,
    plot([0 1], [0 1])

On the other hand, when the block is run in the context of some
session like below

    h = figure,
    plot([0 1], [0 1])

it is impossible to close the figure window with 'X' button, 

The circumvent for this bug can be 

    close all
    h = figure,
    plot([0 1], [0 1])

but, this way or another, the last figure will last until
`close` command is not run from octave command line.
If the session is killed the figure still remains opened.

