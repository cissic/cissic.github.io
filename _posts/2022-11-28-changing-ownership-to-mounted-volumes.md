---
author: cissic
date: 2022-11-27 Sun
tags: 'org-babel session'
title: 'Ownership to mounted volumes (ntfs)'
---


# Ownership to mounted volumes (ntfs)


## Problem and solution

After some Windows crashdown on dual-boot system all of the volumes mounted 
in Debian Bullseye in `/media/user/` changed ownership from `user` to `root`. 
In order to solve the problem I followed [Saurabh Barjatiya's post](https://serverfault.com/a/39308).
His approach didn't succeed at first -- while trying to run proposed commands
system responded with:

    Metadata kept in Windows cache, refused to mount.
    Falling back to read-only mount because the NTFS partition is in an
    unsafe state. Please resume and shutdown Windows fully (no hibernation
    or fast restarting.)
    Could not mount read-write, trying read-only
    The disk contains an unclean file system (0, 0).
    Metadata kept in Windows cache, refused to mount.
    Falling back to read-only mount because the NTFS partition is in an
    unsafe state. Please resume and shutdown Windows fully (no hibernation
    or fast restarting.)

I bypassed this error with 
[Muddassir Nazir's solution](https://askubuntu.com/a/566381), which was said to be risky for Windows system,
but at the time of writing this I didn't care about it -- I hadn't booted 
Windows for a very long time anyway.

