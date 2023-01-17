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

    #!/bin/bash
    
    ## Caution: Sourcing this script like this:
    ## . mountCloud.sh
    ## can be useful when running the script in the command line!
    
    absPath=/home/mb/
    mountingDir="$absPath"pcloud ; # it could be worth to have here an absolute path 
    
    ## allow_other option to let docker container bind remote volumes mounted by sshfs
    ## https://serverfault.com/questions/947182/mount-a-sshfs-volume-into-a-docker-instance
    
    echo 'password' | sshfs -p 12345 user@address.something.org:/ $mountingDir -o password_stdin
    
    ## if necessary:
    # cd "$mountingDir"/specific/path

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

    #!/bin/bash
    
    ## Caution: Sourcing this script like this:
    ## . umountCloud.sh
    ## can be useful when running the script in the command line!
    # ____________________________________________________________________________78
    
    absPath=/home/mb/
    mountingDir="$absPath"pcloud ; # it could be worth to have here an absolute path 
    
    ## Auxiliary variables for logging purposes:
    ## Get current date ##
    _now=$(date +"%Y_%m_%d_%H_%M_%S")
    
    _logfileStub="$absPath"temp/UmountCloud
    
    # if the resource is mounted
    if mount | grep $mountingDir > /dev/null; then 
        echo "Volume is mounted."
    
        # if non-sudo unmounting fails
        if ! umount $mountingDir; then
    	xmessage -center "$mountingDir could not be unmounted! Free resources and try again." -timeout 3
    	echo "$mountingDir could not be unmounted! Free resources and try again."
    	touch "$_logfileStub"-"$_now"-umount-fail.log
    
    	# try sudo and forced unmounting
    	if ! sudo umount -f $mountingDir; then
    	    # if it fails 
    	    # volume remains mounted - there will be problems after
    	    # hibernation or going to sleep
    	    xmessage -center "pcloud could not be unmounted FORCEfully! This is a real problem." -timeout 3
    	    echo "Unmounted after unmounting WITH force"
    	    touch "$_logfileStub"-"$_now"-umount-With-Force-fail.log
    	else
    	    # If it succeeds
    	    # volume is unmounted - however $mountingDir
    	    # probably becomes corrupted in such case.
    	    echo "Volume unmounted forcefully".
    	    touch "$_logfileStub"-"$_now"-umount-With-Force-Success.log
    
    	    # umount one more time, now without a force to 
    	    # to free resources and to make 
    	    # a mounting directory which is corrupted after 
    	    # force umounting be uncorrupted.
    	    # This may fail if $mountingDir is still opened in the command line
    	    # or in window manager (for instance: Dolphin)
    	    # It may be needed to run the command below after
    	    # closing all windows with opened with $mountingDir directory
    	    sudo umount $mountingDir
    	fi
        else
    	echo "Volume unmounting succeded."
    	touch "$_logfileStub"-"$_now"-umount-Success.log
        fi
    
    else
        echo "Volume is NOT mounted."
        touch "$_logfileStub"-"$_now"-not-Mounted-At-all.log
    fi

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

    #!/bin/bash
    
    # put it in  
    # /usr/lib/systemd/system-sleep/
    # and DON'T FORGET TO!:
    # chmod +x /lib/systemd/system-sleep/55umountPionierCloud_etc_pm_sleepd 
    
    absPath=/home/mb/
    mountingDir="$absPath"pcloud ; # an absolute path is required since this
    			   # script is run from root context!
    
    ## Auxiliary variables for logging purposes:
    ## Get current date ##
    _now=$(date +"%Y_%m_%d_%H_%M_%S")
    ## information just for specific user
    _logfileStub="$absPath"temp/sys-sleep
    
    case "$1" in
        pre)
    	# Place your pre suspend commands here, or `exit 0` if no pre suspend action required
    	echo "Going to $2..."
    	touch "$_logfileStub"-"$_now"-going_to_sleep.log
    	. "$absPath"binmb/pionierScripts/umountCloud.sh
    	#_file="/home/mb/sleep$_now"
    	#    touch $_file   
    	# if [ -d "$FOLDER" ]; then
    	#     # echo "$FOLDER exist - can be unmounted"
    	#     sudo umount /home/mb/pcloud
    	#     touch /home/mb/sleepd-umounted.txt
    	# else
    	#     echo "~/pcloud/home does not exist"
    	# fi    
    	;; # semi-colons are important!
        post)
    	# Place your post suspend (resume) commands here, or `exit 0` if no post suspend action required
    	echo "Waking up from $2..."
    	touch "$_logfileStub"-"$_now"-resuming-system.log
    	# umount resource in case something went wrong during putting to sleep
    	. "$absPath"binmb/pionierScripts/umountCloud.sh
    	;; # semi-colons are important!
    esac

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

