---
author:
- cissic
date: '\<2022-09-08 Thu\>'
tags: linux git bash
title: 'How to make Dolphin read settings in `~/.bashrc`'
---

How to make Dolphin read settings in `~/.bashrc` {#how-to-make-dolphin-read-settings-in-.bashrc-1}
------------------------------------------------

A bug found in Debian Bullseye/Plasma 5.20.5/Dolphin 20.12.2

### TL;DR tip:

``` {.example}
Dolphin Settings -> Configure Dolphin -> Startup 

untick 'Folders, tabs, and ...'
tick   'Show on startup /home/username'
```

### Description

Workaround/Fix found
[here](https://bugs.kde.org/show_bug.cgi?id=279614#c41).

> \> KDE 5.23.1 Dolphin 21.08.2 If in dolphin enabled conf
> Startup-\>Show on startup: Folder, tabs, and window state from last
> time, then dolphin shell panel don\'t read .bashrc.
