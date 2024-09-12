
# Table of Contents

1.  [How to force suspend in KDE](#org714763a)
    1.  [Problem description](#org1a224be)



<a id="org714763a"></a>

# TODO How to force suspend in KDE


<a id="org1a224be"></a>

## Problem description

Sometimes, after some crash in KDE enviroment there may appear
a problem with suspending the system.
In this case, with the help of `myaskpass.sh` script from 
`sudo password input in KDE for the script run in bash` post
you can create the following script and bind it to some keyboard shorcut.

    #!/bin/bash
    
    # do use full/path/to/directory, ~/bin/myaskpass.sh may not work!
    export SUDO_ASKPASS="/home/mb/binmb/myaskpass.sh"
    sudo -A systemctl suspend

