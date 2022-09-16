Dolphin opens .desktop files in kate instead of executing them {#2022-09-06-dolphin-opens-.desktop-files-in-kate}
--------------------------------------------------------------

A bug that appeared after migration from Buster to Bullseye
(Bullseye/Plasma 5.20.5/Dolphin 20.12.2) Dolphin stopped executing
.desktop files and started to open them in default text editor. How to
prevent this.

### TL;DR tip:

``` {.example}
kate ~/.config/kiorc
```

Change the line:

``` {.example}
[Executable scripts]
behaviourOnLaunch=open
```

to

``` {.example}
[Executable scripts]
behaviourOnLaunch=execute
```

### Description:

Workaround/Fix found
[here](https://askubuntu.com/questions/513459/desktop-files-opening-in-kate/894380#894380).
