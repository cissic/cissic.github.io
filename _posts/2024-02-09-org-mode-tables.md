
# Table of Contents

1.  [org-mode tables](#org3662e9f)
    1.  [Problem description](#org217db1c)



<a id="org3662e9f"></a>

# TODO org-mode tables


<a id="org217db1c"></a>

## Problem description

-   Elisp list can be intepreted as a one-row table:

    '("aaaaa ad" 
     " aaa  " 
     "bbb  ")

-   List of strings with newline character can be interpreted as one-column table:

      '("aaaaa ad
      "
       " aaa
      "
       "bbb
    ")

-   new line character inserted here and there instructs org to start new
    row of the table. If there is not enough elements in the current row
    than the number of elements in a row with maximum number of elements
    then org creates blank cells.
    -   example 1

    '("a11 " "a12" "\n"
     " a21"        "\n"    "a31"
     "a32  " )

-   example 2

    '("a11 " " "  "a12" "\n"
     " a21"        "\n"    "a31"
     "a32  " )

-   you can also insert next column by adding `|` in a string

    '("a11 |    a12 " "a13"  "\n"
     " a21" "a22 | a23"  "\n"
     "a32  " )

-   ways of adding horizontal lines

    '("a11 |  a12 " "a13"  "\n"
      "--|--|--" "\n"
     " a21" "a22 | a23"  "\n"
      "--|" "--|" "--" "\n"
     "a32  " "\n"
     "----+-------------+----" "\n"
     "a41" "\n"
     "-+-+-" "\n"
     "a51" "\n"
     " + + " "\n"
     )

