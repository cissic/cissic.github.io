---
author: cissic
date: 2023-02-25 Sat
tags: 'shell ftp linux'
title: 'Using command line `lftp` for FTP connections'
---


# Using command line `lftp` for FTP connections


## How to use `lftp` for uploading a file or a directory to your ftp account?

Below is a script based on [this post](https://stackoverflow.com/questions/27635292/transfer-files-using-lftp-in-bash-script).

[How to upload directory with a content to your ftp server](https://serverfault.com/questions/220988/how-to-upload-a-directory-recursively-to-an-ftp-server-by-just-using-ftp-or-lftp)? Attention `-R` flag
denotes that remote directory will be synchronized with the local directory
(upload from local to remote). Without `-R` flag the direction should be the
other way round (mirroring remote to local = download from remote to local)

    #!/bin/bash
    
    pwd # you're in your local bash now, to be sure where exactly, check it
    
    lftp -u USERNAME,PASSWORD FTPSERVER-IP-OR-NAME << EOF
    set ftp:ssl-force true         # this is done in order to prevent some errors
    set ssl:verify-certificate no  # and warnings if your server is moody
    # hash is a comment mark even in lftp connection :-)
    # # pwd   # do this only when you're alone at the keyboard!!!!
    	  # it will show your password in the command line!!!!    
    ls 
    cd to/the/directory/you/wan
    put ../some/local_file  # to your current directory on ftp    # if you want to copy a file
    mirror -R local/dir path/to/some/ftp/dir              # if you want to copy a directory
    bye
    EOF


## Links that can be useful

-   <https://linuxconfig.org/lftp-tutorial-on-linux-with-examples>
-   <https://rcpedia.stanford.edu/faqs/LFTPFileTransfer.html>
-   <https://forums.oracle.com/ords/apexds/post/how-to-pass-password-to-an-lftp-connection-using-shell-scri-3032>

-   <https://stackoverflow.com/questions/42761829/lftp-save-username-password-for-specific-server>

-   

