---
author: cissic
date: 2023-10-22 Sun
tags: 'debian lenovo trackpoint scroll'
title: 'How to get Emacs keybindings system wide'
---


# {{{title}}

:PROPERTIES:
:PRJ-DIR: ./2023-10-22-emacs-keybindings/:


## Links

I came across this thread
<https://www.reddit.com/r/emacs/comments/dtkpj9/when_you_press_ctrly_in_your_browser_and_nothing/>
and found python package for enforcing emacs keybindings in the system.
<https://github.com/mooz/xkeysnail>

According to the last link to install it one should

    sudo apt install python3-pip
    sudo pip3 install xkeysnail
    
    # If you plan to compile from source
    # sudo apt install python3-dev

Then, you can download
[author's config file](https://github.com/mooz/xkeysnail/blob/master/example/config.py) which defines emacs keybindings.

    mkdir ~/.xkeysnail
    cd ~/xkeysnail
    curl https://raw.githubusercontent.com/mooz/xkeysnail/master/example/config.py > config.py

    sudo xkeysnail ~/.xkeysnail/config.py


## TODO How to run the command in the background?

Running `sudo xkeysnail ~/.xkeysnail/config.py` from `Alt-F2` command
window does not work. I need to open bash window and run it as foreground process
(`sudo xkeysnail ~/.xkeysnail/config.py &`) does not work.


## TODO Known issues

Unfortunately, the keybindings does not fully work.
The problems are with:

-   <M-w> (aka <Alt-W>)  in Vivaldi
-   <M-w> (aka <Alt-W>)  in Okular

