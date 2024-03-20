
# Table of Contents

1.  [Using LaTeX in org-mode](#org829c16c)
    1.  [Different ways to include LaTeX in org documents](#orgd2e8120)
        1.  [Example 1](#orgd5277eb)
        2.  [Example 2](#orge39f9d0)
        3.  [Example 3](#org6102cb0)
    2.  [Hard space, non-breaking space in org-mode](#orgab7170a)

---
author: cissic
date: 2023-04-13 Thu
tags: 'kde kde-activity windows-manager'
title: 'Using LaTeX in org-mode'
---


<a id="org829c16c"></a>

# TODO Using LaTeX in org-mode


<a id="orgd2e8120"></a>

## Different ways to include LaTeX in org documents

How embed LaTeX math in org document in described [here](https://orgmode.org/manual/LaTeX-fragments.html).

Be careful when nesting math environments between $ $ or
`$$` `$$`!
You might get unexpected behaviour when starting a line with
`\begin`
inside dollar delimiters!

In such cases it is safe to use `\begin{equation}` enviroment.

To see the baddness of the examples below they need to be
exported to pdf format (When exporting to html there are other
issues.)


<a id="orgd5277eb"></a>

### Example 1

1.  Improper

    `\begin` at the beginning of the line inside `=$$ $$=` or `$ $`.
    
        $$A =
        \left[
        \begin{array}{cc}
        a & v \\
        c & d
        \end{array}
        \right]$$
    
    $$A =
    \left[
    
    \begin{array}{cc}
    a & v \\
    c & d
    \end{array}
    
    \right]$$

2.  Proper

        $$A =
        \left[\begin{array}{cc}
        a & v \\
        c & d
        \end{array}
        \right]$$
    
    $$A =
    \left[\begin{array}{cc}
    a & v \\
    c & d
    \end{array}
    \right]$$


<a id="orge39f9d0"></a>

### Example 2

1.  Improper

    Whitespaces after begginning dollar sign or before ending dollar sign
    (space, tab or newline)
    
        $
        A =
        \left[
        \begin{array}{cc}
        a & v \\
        c & d
        \end{array}
        \right] $
    
    $
    A =
    \left[\begin{array}{cc}
    a & v   
    c & d
    \end{array}
    \right] $

2.  Proper

    Do note that in this example `$begin{array}` at the beginning of
    the line is ok!
    
        $A =
        \left[
        \begin{array}{cc}
        a & v \\
        c & d
        \end{array}
        \right]$
    
    $A =
    \left[\begin{array}{cc}
    a & v \\
    c & d
    \end{array}
    \right]$


<a id="org6102cb0"></a>

### Example 3

1.  Improper

    `\begin` at the beginning of the line inside `=$$ $$=` or `$ $`.
    
        $$A =
        \left[
        \begin{array}{cc}
        a & v \\
        c & d
        \end{array}
        \right]$$
    
    $$A =
    \left[
    
    \begin{array}{cc}
    a & v \\
    c & d
    \end{array}
    
    \right]$$

2.  Proper

    When using `equation` environement you can start nested
    environemnts from the beginning of the line.
    
        \begin{equation}
        A =
        \left[
        \begin{array}{cc}
        a & v \\
        c & d
        \end{array}
        \right]
        \end{equation}
    
    \begin{equation}
    A =
    \left[
    \begin{array}{cc}
    a & v \\
    c & d
    \end{array}
    \right]
    \end{equation}


<a id="orgab7170a"></a>

## Hard space, non-breaking space in org-mode

A way to include non-breaking space (nbsp) in org document to
have it properly exported to latex document is
presented here
<https://emacs.stackexchange.com/questions/45083/non-breaking-space-in-org-mode>
or
<https://stackoverflow.com/questions/9311538/how-to-make-non-breaking-spaces-ties-in-org-mode-that-exports-properly-to-late>

Instead of `~` you should use: `\nbsp{}`.

