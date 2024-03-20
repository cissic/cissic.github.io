---
author: cissic
date: 2023-09-30 Sat
tags: 'debian lenovo trackpoint scroll'
title: 'How to make Lenovo's trackpoint work for scrolling'
---


# How to make Lenovo's trackpoint work for scrolling


## Description

It is said that Lenovo's trackpoint should enable user scrolling
when mouse (touchpad) middle button is pressed (first: press middle
button, then use trackpoint!). 
<https://www.youtube.com/watch?v=7H8o_-7bKIU>
<https://www.youtube.com/watch?v=H9ya4dUZfTQ>

There are some issues with this feature when working on Debian's
machine: [1](https://www.reddit.com/r/thinkpad/comments/1te3y1/t440s_middle_click_works_only_for_scrolling/), [2](https://askubuntu.com/questions/380825/trackpoint-and-clickpad-enable-buttons-and-scroll-lenovo-t440s), [3](http://tillenius.me/blog/2014/08/19/ubuntu-clickpad-middle-scroll/), [4](https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-evdev/+bug/1246683?comments=all), [5](https://www.thinkwiki.org/wiki/Installing_Debian_on_an_X230#UltraNav_scrolling), [6](https://www.reddit.com/r/thinkpad/comments/36o8w9/t440s_linux_trackpoint_scrolling/), [7](https://www.reddit.com/r/thinkpad/comments/2nh6a7/t440s_x1c_clickpad_trackpoint_config_files_linux/)

Namely, I couldn't scroll on my system with the use of trackpoint.

[This comment](https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-evdev/+bug/1246683/comments/98) from [this thread](https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-evdev/+bug/1246683?comments=all) (4) indicates that you can obtain
scrolling abilities of the touchpad by uninstalling
`xserver-xorg-input-synaptics` package. And indeed it does!.

Well, you also need to have `xserver-xorg-input-libinput` package
as it written in [another thread](https://unix.stackexchange.com/questions/337008/activate-tap-to-click-on-touchpad). 

However, the drawback is that in the same moment I lost the ability
to emulate mouse clicks by tapping the touchpad.

The last mentioned link gives hints what files should be edited to
restore aproppriate behaviour, but in `debian bullseye` it is not
needed. You can bring back this feature by tweaking
system settings:
`System settings` -> ... -> `Touchpad` -> "Tapping" (Tap to click)
and "Scrolling" -> (Two fingers).


## TODO Post scriptum

This problem is still unsolved because it looks like uninstalling
`xserver-org-input-synaptics` disables the possibility to
manage the behaviour of the touchpad from `System settings`.
Namely, after setting "Tapping" for clicking like it was described
hgghabove, the functionality does not last between system booting.
"SynPS/2 Synaptics Touchpad" is greyed out.

