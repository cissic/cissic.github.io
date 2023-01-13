---
author: cissic
date: 2023-01-13 Fri
tags: 'remote mount umount cifs volume'
title: 'Automatic access to remote storage'
---
---
author: cissic
date: 2023-01-13 Fri
tags: 'remote mount umount cifs volume'
title: 'Automatic access to remote storage'
---


# Automatic access to remote storage


## Problem description

I've got a remote resource with data that can be accessed with `sshfs`.
So I can write a simple script for automatic mounting of this volume.

**Caution!**: The approach presented below is not very safe and shouldn't be
recommended as a proper way of handling logging due to storing password in
a text file! If you have
the possibility of logging with the use of GPG keys you should apply it.


### Mounting

**Remark**:

Instead of running this script it may be useful to `source` it and
to make changes made inside script stay in your current shell
([link 1](https://stackoverflow.com/questions/255414/why-doesnt-cd-work-in-a-shell-script), [link 2](http://superuser.com/questions/176783/what-is-the-difference-between-executing-a-bash-script-and-sourcing-a-bash-scrip#176788)). Sourcing can be perfomed with the command `source mountCloud.sh`
or simple with the use of dot:
**Remark 2**:
`allow_other` option lets docker container
bind remote volumes mounted by `sshfs`
([Link](https://serverfault.com/questions/947182/mount-a-sshfs-volume-into-a-docker-instance))


### Umounting

`/dev/null` is a system's [black hole](https://en.wikipedia.org/wiki/Null_device)  and redirecting the stream to it makes 
the output of the command that would normally appear in the command line...
not appear on the screen.

The above script works as follows:

-   if the volume is unmounted it does nothing
-   if the volume is mounted it:
    -   tries to unmount it gently
        -   if that fails it tries to umount with `-f` flag
            -   if that fails then we've got a problem -- there is a big chance
                that after restarting the computer after sleep/hibernation 
                the system hangs

In order have unmounting process going automatically we need to put the following
script in `/usr/lib/systemd/system-sleep/` (true for Debian Bullseye, this path
may be different in various Debian versions and various Linux distribution)
and (**don't forget about this point!**) perform:

`chmod +x /lib/systemd/system-sleep/umountCloud_usr_lib_systemd_system-sleep`

Have in mind that the number at the beginning of the filename is file's priority
(order of the execution when sleep action is invoked).

After tangling remeber to put the files in the appropriate folders and give them appropriate
properties. You do this by tangling the following script and executing it with:
`. fileDispatching.sh` from the context of its parent directory.

    #!/bin/bash
    
    absPath=/home/mb/
    userScripts="$absPath"binmb/pionierScripts/
    localPath=
    
    # mv "$userScripts"mountCloud.sh "$userScripts"mountCloud.shBKP
    mv "$userScripts"umountCloud.sh "$userScripts"umountCloud.shBKP  
    mv "$userScripts"55umountCloud_usr_lib_systemd_system-sleep "$userScripts"55umountCloud_usr_lib_systemd_system-sleepBKP
    
    # cp ./2023-01-13-auto-mount-umount/mountCloud.sh "$userScripts"mountCloud.sh
    cp umountCloud.sh "$userScripts"umountCloud.sh  
    cp 55umountCloud_usr_lib_systemd_system-sleep "$userScripts"55umountCloud_usr_lib_systemd_system-sleep
    
    sudo mv /usr/lib/systemd/system-sleep/55umountCloud_usr_lib_systemd_system-sleep /usr/lib/systemd/system-sleep/55umountCloud_usr_lib_systemd_system-sleepBKP
    sudo cp "$userScripts"55umountCloud_usr_lib_systemd_system-sleep /usr/lib/systemd/system-sleep/55umountCloud_usr_lib_systemd_system-sleep
    sudo chmod +x /usr/lib/systemd/system-sleep/55umountCloud_usr_lib_systemd_system-sleep

