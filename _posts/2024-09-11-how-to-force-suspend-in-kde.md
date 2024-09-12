
# Table of Contents

1.  [How to force suspend in KDE](#org15e17b0)
    1.  [Problem description](#org03f0d0a)



<a id="org15e17b0"></a>

# How to force suspend in KDE


<a id="org03f0d0a"></a>

## Problem description

Sometimes, after some crash in KDE enviroment there may appear
a problem with suspending the system.
In this case, with the help of `myaskpass.sh` script from

[this post](https://cissic.github.io/posts/sudo-password-input-in-kde-for-the-script-run-in-bash/)

you can create the following script and bind it to some keyboard shorcut.

    #!/bin/bash
    
    # do use full/path/to/directory, ~/bin/myaskpass.sh may not work!
    export SUDO_ASKPASS="/home/mb/binmb/myaskpass.sh"
    sudo -A systemctl suspend

