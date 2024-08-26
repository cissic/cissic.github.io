
# Table of Contents

1.  [How to empty trash from command line](#orgc40a357)
    1.  [Problem description](#org72f318d)
    2.  [Solution](#org7d914cd)



<a id="orgc40a357"></a>

# TODO How to empty trash from command line


<a id="org72f318d"></a>

## Problem description

Sometimes windows manager doesn't let me delete all of the files
from the trash bin saying that some file/directory is already
deleted.


<a id="org7d914cd"></a>

## Solution

<https://askubuntu.com/questions/468721/how-can-i-empty-the-trash-using-terminal>

    rm -rf ~/.local/share/Trash/*

