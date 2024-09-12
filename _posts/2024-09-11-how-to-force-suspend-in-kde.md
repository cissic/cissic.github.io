
# Table of Contents

1.  [How to force suspend in KDE](#org57067c6)
    1.  [Problem description](#orgb11c36b)



<a id="org57067c6"></a>

# How to force suspend in KDE


<a id="orgb11c36b"></a>

## Problem description

Sometimes, after some crash in KDE enviroment there may appear
a problem with suspending the system.
In this case, with the help of `myaskpass.sh` script from

post
you can create the following script and bind it to some keyboard shorcut.

    #!/bin/bash
    
    # do use full/path/to/directory, ~/bin/myaskpass.sh may not work!
    export SUDO_ASKPASS="/home/mb/binmb/myaskpass.sh"
    sudo -A systemctl suspend

