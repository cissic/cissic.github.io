How to make Dolphin read settings in `~/.bashrc` {#how-to-make-dolphin-read-settings-in-.bashrc-1}
------------------------------------------------

A bug found in Debian Bullseye/Plasma 5.20.5/Dolphin 20.12.2

### TL;DR tip:

\#+BEGIN~EXAMPLE~ bash Dolphin Settings -\> Configure Dolphin -\>
Startup

untick \'Folders, tabs, and ...\' tick \'Show on startup
/home/username\'

\#+END~EXAMPLE~ bash

### Description

Workaround/Fix found
[here](https://bugs.kde.org/show_bug.cgi?id=279614#c41).

\> KDE 5.23.1 Dolphin 21.08.2 If in dolphin enabled conf Startup-\>Show
on startup: Folder, tabs, and window state from last time, then dolphin
shell panel don\'t read .bashrc.
