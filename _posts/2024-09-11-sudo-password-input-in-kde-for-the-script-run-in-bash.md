
# Table of Contents

1.  [sudo password input in KDE for the script run in bash](#org29e822d)
    1.  [Problem description](#org16a1520)



<a id="org29e822d"></a>

# sudo password input in KDE for the script run in bash


<a id="org16a1520"></a>

## Problem description

Sometimes you may want to trigger bash script with sudo command
from GUI (for example bash script triggered by some keybinding).
In this situation there appears a problem with passing sudo password.

You can always include the password in the bash script 
ausing `-S` switch 

    echo <password> | sudo -S <command>

or try to use some other methods mentioned
[here](https://superuser.com/questions/67765/sudo-with-password-in-one-command-line).
Of course the safety reasons require some more secure approach.

[This thread](https://askubuntu.com/questions/314395/proper-way-to-let-user-enter-password-for-a-bash-script-using-only-the-gui-with) may come in handy. With the use of `zenity`
or some other password asking program (`zenity` was already installed
in my debian distribution) simply create a file:

    #!/bin/bash
    zenity --password --title=Authentication

Then insert this line at the beginning of your script:

    export SUDO_ASKPASS="/path/to/myaskpass.sh"

(NOTE: do use full path to the script, `~` for `/home/user/` directory
may not work)
and replace all occurences of sudo <command> with:

    sudo -A <command>

