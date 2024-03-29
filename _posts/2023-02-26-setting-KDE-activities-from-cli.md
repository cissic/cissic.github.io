---
author: cissic
date: 2023-02-26 Sun
tags: 'kde kde-activity windows-manager'
title: 'Smart way of changing window KDE-activity property'
---


# TODO Smart way of changing window KDE-activity property


## Problem: KDE: set window belonging to a certain KDE-activity

It's really annoying when you have a bunch of windows opened in Plasma
and you want to move them to another activity in GUI.

In the current verion of Plasma (year 2023) you can do this in a more
convenient way by dragging application icon
from task manager to the desired activity from the activity pane
(<https://unix.stackexchange.com/a/691194/152439>).

[This post](https://unix.stackexchange.com/a/703987/152439) however gives hint how it can be accomplished from the command line.
With the use of KDE shortcuts things can be made far more convenient.

Here's my approach:

    #!/bin/bash
    
    actName=$1
    # actName=priv
    
    # get id of the activity given by name 
    actID=$(kactivities-cli --list-activities|grep $actName|cut -d" " -f2)
    
    # get id of the window with the focus
    windowID=$(xdotool getwindowfocus)
    
    echo $actID
    echo $windowID
    
    xprop -f _KDE_NET_WM_ACTIVITIES 8s -id $windowID -set _KDE_NET_WM_ACTIVITIES $actID
    
    # one-line version:
    # xprop -f _KDE_NET_WM_ACTIVITIES 8s -id $(xdotool getwindowfocus) -set _KDE_NET_WM_ACTIVITIES $(kactivities-cli --list-activities|grep $actName|cut -d" " -f2)

It is based on oneliner:
`xprop -f _KDE_NET_WM_ACTIVITIES 8s -id $(xdotool search --onlyvisible --name Kate) -set _KDE_NET_WM_ACTIVITIES $(kactivities-cli --list-activities|grep priv|cut -d" " -f2)`

Now, provided we move the above script to system path directory we can
use KDE-Plasma shortcuts and bind the with the command, for example:
`bash ~/bin/changeWindowActivityTo.sh priv`


## Links that can be useful

-   <https://forum.kde.org/viewtopic.php?f=111&t=174102>

-   <https://www.reddit.com/r/kde/comments/q4166w/shortcut_to_move_a_window_to_another_activity/>
-   <https://unix.stackexchange.com/questions/6623/how-do-i-move-applications-between-kde-activities>

