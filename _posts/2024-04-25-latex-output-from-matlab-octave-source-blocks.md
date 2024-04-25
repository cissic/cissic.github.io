
# Table of Contents

1.  [Obtaining latex output from Matlab blocks - the easiest way (at least for me)](#orga9d896d)
    1.  [Source code blocks](#orga56bc72)
    2.  [Inline source blocks](#orgf481b2f)
    3.  [Making matlab code blocks be easily converted to octave code blocks](#org970366c)
        1.  [Matlab](#org9d38226)
        2.  [Octave](#orgd04d081)
    4.  [Summary](#orgc140ccf)



<a id="orga9d896d"></a>

# Obtaining latex output from Matlab blocks - the easiest way (at least for me)

Here are my loose thoughts on the topic started
[here](https://sourceforge.net/p/matlab-emacs/mailman/matlab-emacs-discuss/thread/871q6wp5j0.fsf_-_%40mat.ucm.es/#msg58763751).


<a id="orga56bc72"></a>

## Source code blocks

If you have Symbolic Matlab Toolbox and some newer version of Matlab
you can always use its `latex` function to deal with the problem.
For example 

    #+begin_src matlab :session *MatOct* :exports none :eval no-export
      A = [1 2; 2.5 pi] ;
      C = {1 2; "string", { 3.987987933 \pi}} ;
      a = 1 ;
      v = [1 2 3] ;
    #+end_src
    
    #+begin_src matlab :session *MatOct* :results output latex :exports results :wrap latex :eval no-export
      disp(['$' latex(sym(A)) '$'])
      disp(['$' latex(sym(C)) '$'])
    #+end_src

Returns the following results:

<div class="latex" id="orgbd40e5e">
<p>
\(\left(\begin{array}{cc} 1 & 2\\ \frac{5}{2} & \pi  \end{array}\right)\)
\(\left(\begin{array}{cc} 1 & 2\\ \mathrm{string} & \frac{886943224362615}{1125899906842624} \end{array}\right)\)
</p>

</div>


<a id="orgf481b2f"></a>

## Inline source blocks

For inline blocks you need to however use `raw` modifier like below: 

`src_matlab[:session *MatOct* :results raw]{disp(['$' latex(sym(A)) '$'])}`

which results in:

$\left(\begin{array}{cc} 1 & 2\\ \frac{5}{2} & \pi  \end{array}\right)$.

One of the pros of  `latex(sym(....` approach is that we can easily
deal not only with matrices but also with cell arrays.
The con is that it converts floats to decimal fractions, which
is not always desirable.
However... 


<a id="org970366c"></a>

## Making matlab code blocks be easily converted to octave code blocks

... from my point of view, it would be very convenient to have
the ability to convert matlab source blocks easily into octave source
blocks and vice versa (when you don't use sophisticated functions
from Matlab toolboxes it's better to evoke octave).
For such use-cases it'd be good to have consistent way of
working with source blocks. Unfortunately I cannot not find it.

First, we cannot use `latex` function from Matlab's Symbolic
Toolbox anymore.

OK. We can deal with that by tailoring useful
`matrix2latex` function from Mathworks FileExchange.
The original version can be found here: [matrix2latex](https://www.mathworks.com/matlabcentral/fileexchange/4894-matrix2latex).
It's drawback is that it stores results in a file which name is
given as a function second parameter.

I have edited it a bit to make it return latex code as a string.
I have no patience to do it properly, so I only commented out
the parts of the original file that refer to saving to the file
on the disk.
My version can be found [here](https://gist.github.com/cissic/970f4bf5ee5d1ebd434ff39d9206feff).

Now, with the use of this function we can generate latex
matrix code for the given matlab/octave matrix.
However, as the examples below indicate, there are still
inconsistencies between matlab and octave source block modifiers.
The same modifier value that work well with matlab, return
unwanted output in octave and vice versa....


<a id="org9d38226"></a>

### Matlab

1.  Source blocks

    For:
    
        #+begin_src matlab :session *MatOct* :exports none
          A = [1 2; 2.5 pi] ;
          C = {1 2; "string", { 3.987987933 \pi}} ;
          a = 1 ;
          v = [1 2 3] ;
        #+end_src
        
        #+begin_src matlab :session *MatOct* :results output :exports results :eval never-export :wrap latex
          str = matrix2latexS(A, 'THIS_STRING_IS_NOT_USED', 'alignment', 'c', 'format', '%-4.4f', 'size', 'tiny') ;
          disp(str)
        #+end_src
    
    We obtain:
    
    <div class="latex" id="org34ef875">
    \begin{tiny}\begin{tabular}{|c|c|}\hline1.0000 & 2.0000\\ \hline2.5000 & 3.1416\\ \hline\end{tabular}\end{tiny}
    
    </div>

2.  Inline blocks

    `src_matlab[:session *MatOct* :results raw]{disp(['$' str '$'])}`
    
    returns:
    
    $\begin{tiny}\begin{tabular}{|c|c|}\hline1.0000 & 2.0000\\ \hline2.5000 & 3.1416\\ \hline\end{tabular}\end{tiny}$
    
    Of course the form of latex matrices can be tailored to your
    needs by adjusting `matrix2latexS` function.


<a id="orgd04d081"></a>

### Octave

... and this is where I fall...
As I said, it is important to me to have easily convertible
matlab code blocks to octave code blocks.
However I am not able to find any common, consistent way of accessing
results of code blocks of these two languages. Have a look at
the examples below:

1.  Source blocks

        #+begin_src octave :session *OctMat* 
          A = [1 2; 2.5 pi] ;
          C = {1 2; "string", { 3.987987933 \pi}} ;
          a = 1 ;
          v = [1 2 3] ;
        #+end_src
        
        #+begin_src octave :session *OctMat* :results output :exports results :eval never-export :wrap latex
          str = matrix2latexS(A, 'THIS_STRING_IS_NOT_USED', 'alignment', 'c', 'format', '%-4.4f', 'size', 'tiny') ;
          ans = str
        #+end_src
    
        A = [1 2; 2.5 pi] ;
        C = {1 2; "string", { 3.987987933 \pi}} ;
        a = 1 ;
        v = [1 2 3] ;
    
    Results in:
    
        #+RESULTS:
        #+begin_latex
        | octave> octave> ans = \begin{tiny}\begin{tabular}{ | c | c | }\hline1.0000 & 2.0000\\ \hline2.5000 & 3.1416\\ \hline\end{tabular}\end{tiny} |
        #+end_latex
    
    which renders as:
    
    <div class="latex" id="org4734b2c">
    <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
    
    
    <colgroup>
    <col  class="org-left" />
    
    <col  class="org-left" />
    
    <col  class="org-left" />
    
    <col  class="org-left" />
    </colgroup>
    <tbody>
    <tr>
    <td class="org-left">octave&gt; octave&gt; ans = \begin{tiny}\begin{tabular}{</td>
    <td class="org-left">c</td>
    <td class="org-left">c</td>
    <td class="org-left">}\hline1.0000 &amp; 2.0000\\ \hline2.5000 &amp; 3.1416\\ \hline\end{tabular}\end{tiny}</td>
    </tr>
    </tbody>
    </table>
    
    </div>

2.  Inline blocks:

    On the other hand this piece of code:
    
    `src_octave[:session *OctMat* :results raw]{disp(['$' 'string' '$'])}`
    
    results in:
    
    org<sub>babel</sub><sub>eoe</sub>


<a id="orgc140ccf"></a>

## Summary

Org-babel with octave/matlab is a tricky machinery to me.

I'm not sure if it is possible to get both
matlab and octave code blocks (and inline blocks)
working in the same manner.

If it was, I could adjust `matrix2latex` function to have
common way of working with both languages.

