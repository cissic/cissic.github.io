
# Table of Contents

1.  [Dolphin opens .desktop files in kate instead of executing them](#2022-09-06-dolphin-opens-.desktop-files-in-kate)
    1.  [TL;DR tip:](#tldr-tip)
    2.  [Description:](#description)



<a id="2022-09-06-dolphin-opens-.desktop-files-in-kate"></a>

# Dolphin opens .desktop files in kate instead of executing them

A bug that appeared after migration from Buster to Bullseye (Bullseye/Plasma 5.20.5/Dolphin 20.12.2)
Dolphin stopped executing .desktop files and started to open them in default text editor.
How to prevent this.


<a id="tldr-tip"></a>

## TL;DR tip:

    kate ~/.config/kiorc

Change the line:

    [Executable scripts]
    behaviourOnLaunch=open

to

    [Executable scripts]
    behaviourOnLaunch=execute


<a id="description"></a>

## Description:

Workaround/Fix found
[here](https://askubuntu.com/questions/513459/desktop-files-opening-in-kate/894380#894380).

