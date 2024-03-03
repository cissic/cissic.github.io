
# Table of Contents

1.  [If statement in elisp](#orgff44abc)
    1.  [To remember](#orgb0f3887)
        1.  [Consider the following examples:](#org516cab9)



<a id="orgff44abc"></a>

# TODO If statement in elisp


<a id="orgb0f3887"></a>

## To remember

According to [emacs manual](https://www.gnu.org/software/emacs/manual/html_node/elisp/Conditionals.html) `if` statement has the following form:

    (if nil
        (print 'true)
      'very-false)
    ⇒ very-false

It is important to remember that this statement has the form:
`if condition then-form else-forms ...` i.e.
if condition is fulfilled `then-form` is evaluated,
otherwise the rest of the lines inside external parenthesis.

This means that:

-   if you have more than one commands to evaluate in case

condition is fulfilled they need to be embraced by parenthesis and
add a special keyword `progn` (see [Sequencing in emacs manual](https://www.gnu.org/software/emacs/manual/html_node/elisp/Sequencing.html))!!!

-   if you have more more than one commands to evaluate in case

condition is **not** fulfilled they **shouldn't be embraced** by parenthesis,
because otherwise they are treated as a function!
According to [emacs manual](https://www.gnu.org/software/emacs/manual/html_node/elisp/Conditionals.html):
''The else part of if is an example of an implicit progn. See Sequencing.''


<a id="org516cab9"></a>

### Consider the following examples:

1.  Working as intended

        (if t
            (progn
             (print "TRUE: The condition ...")
             (print "... is fulfilled")
            )
             (print "FALSE: The condition ...")
             (print "... is not fulfilled")      
        )
    
        (if nil
            (progn
             (print "TRUE: The condition ...")
             (print "... is fulfilled")
            )
             (print "FALSE: The condition ...")
             (print "... is not fulfilled")      
        )

2.  Unexpected behaviour

        (if nil
             (print "TRUE: The condition ...")
             (print "... is fulfilled")
             (print "FALSE: The condition ...")
             (print "... is not fulfilled")      
        )
    
        (if t
             (print "TRUE: The condition ...")
             (print "... is fulfilled")
             (print "FALSE: The condition ...")
             (print "... is not fulfilled")      
        )

