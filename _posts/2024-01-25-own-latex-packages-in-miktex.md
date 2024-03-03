
# Table of Contents

1.  [own-latex-packages-in-miktex](#org13d8009)
    1.  [Problem description](#org84dc0ea)
    2.  [Links:](#org9a96987)



<a id="org13d8009"></a>

# TODO own-latex-packages-in-miktex


<a id="org84dc0ea"></a>

## Problem description

There is a directory `~/texmf` which contains tex directory tree
structure. In order to have it usable withing `miktex` distribution
you need to

-   run `miktex-console`,
-   choose `Settings` -> `Directories`
-   add the path to the directory to `TEXMF root directories`.
-   Then it may be necessary to run
    `Tasks -> Refresh file name database`

and voila!
Now your style files and other packages should be accesible by
`miktex`.


<a id="org9a96987"></a>

## Links:

-   <https://tex.stackexchange.com/questions/73016/how-do-i-install-an-individual-package-on-a-linux-system>
-   <https://tex.stackexchange.com/questions/2063/how-can-i-manually-install-a-package-on-miktex-windows>
-   <https://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te>

