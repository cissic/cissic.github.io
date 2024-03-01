
# Table of Contents

1.  [How to make Dolphin read settings in `~/.bashrc`](#org4ad2c44)
    1.  [TL;DR tip:](#org6fd4c53)
    2.  [Description](#orgbb98939)



<a id="org4ad2c44"></a>

# How to make Dolphin read settings in `~/.bashrc`

A bug found in Debian Bullseye/Plasma 5.20.5/Dolphin 20.12.2


<a id="org6fd4c53"></a>

## TL;DR tip:

    Dolphin Settings -> Configure Dolphin -> Startup 
    
    untick 'Folders, tabs, and ...'
    tick   'Show on startup /home/username'


<a id="orgbb98939"></a>

## Description

Workaround/Fix found [here](https://bugs.kde.org/show_bug.cgi?id=279614#c41).

> > KDE 5.23.1
> Dolphin 21.08.2
> If in dolphin enabled conf Startup->Show on startup: Folder, tabs, and window state from last time, then dolphin shell panel don't read .bashrc.

