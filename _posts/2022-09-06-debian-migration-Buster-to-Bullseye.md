---
author:
- cissic
date: '\<2022-09-08 Thu\>'
description: Description of the upgrading process.
tags: linux git bash
title: Debian migration from Buster to Bullseye
---

Debian migration from Buster to Bullseye {#debian-migration-from-buster-to-bullseye-1}
----------------------------------------

### My (first successful :-) !!!) debian upgrade. From Buster (10.12) to Bullseye. {#2022-09-06-debian-upgrade}

Upgrading Debian from one version to the new one was possible since I
started using it (around jessie), however it was always a problem for
me. My attempts always ended up in reinstalling system. I suppose I
wasn\'t experienced enough to do it properly in those times. When
Bullseye appeared I decided to give one more try. In the end, it mainly
all came down to following strictly debian
[manual](https://www.debian.org/releases/stable/amd64/release-notes/ch-upgrading.html)
(but I guess this time I did right). I also made some use of [this
link](https://linuxize.com/post/how-to-upgrade-debian-10-to-debian-11/).

The following text is a collection of bash commands ran in my upgrading
process with some comments of mine.

### Initial preparations...

``` {.bash}
# preparation 
sudo apt-mark showhold   # Packages marked as held back cannot be automatically installed
                         # , upgraded or removed. This may cause issues during the upgrade process. 
sudo apt update
sudo apt upgrade
sudo apt full-upgrade 
sudo apt autoremove 

cat /etc/apt/sources.list
cat /etc/debian_version  # make sure your Debian version is really the one you think it is
```

### Uninstalling troublesome packages

We need to find packages, that was installed from non-Debian
repositories, since they can be a cause of problems during the upgrade.
There are two methods of doing it (two commands). Neither of them is
100% reliable. And this was my case.

1.  Command 1: aptitude search

    ; \#+begin~src~ bash :results replace list

    ``` {.bash results="org replace"}
    aptitude search '?narrow(?installed, ?not(?origin(Debian)))'
    ```

    resulted in

    ``` {.org}
    i  adobereader-enu:i386 - Adobe Reader allows you to view navigate and print PDF files. This version adds advanced forms support (save), better integration with Adobe Acrobat workflows, customizable toolbars and better overall performance.
    i  brscan3 - Brother Scanner Driver
    i  cnijfilter2 - IJ Printer Driver for Linux.
    i  digimend-dkms - Collection of graphics tablet drivers by DIGImend project
    i  guitar - Git GUI Client
    i  nomachine - Fast and secure remote access system
    i  scratux - A free programming language where you can create your own interactive stories, games, and animations
    i  virtualbox-6.1 - Oracle VM VirtualBox
    i  vivaldi-stable - Experience the web in a whole new way with Vivaldi.
    ```

    So I removed the packages:

    ``` {.bash}
    apt remove adobereader-enu brscan3 cnijfilter2 digimend-dkms guitar nomachine scratux virtualbox-6.1 vivaldi-stable
    ```

2.  Command 2: apt-forktracer

    ``` {.bash results="org replace"}
    apt-forktracer | sort
    ```

    resulted in

    ``` {.org}
    musescore3 (3.2.3+dfsg2-11~bpo10+1) [Debian Backports: 3.2.3+dfsg2-11~bpo10+1]
    musescore3-common (3.2.3+dfsg2-11~bpo10+1) [Debian Backports: 3.2.3+dfsg2-11~bpo10+1 3.2.3+dfsg2-11~bpo10+1]
    tor (0.4.5.10-1~bpo10+1) [Debian Backports: 0.4.5.10-1~bpo10+1] [Debian: 0.3.5.16-1 0.3.5.16-1]
    torbrowser-launcher (0.3.3-6~bpo10+1) [Debian Backports: 0.3.3-6~bpo10+1]
    tor-geoipdb (0.4.5.10-1~bpo10+1) [Debian Backports: 0.4.5.10-1~bpo10+1 0.4.5.10-1~bpo10+1] [Debian: 0.3.5.16-1 0.3.5.16-1 0.3.5.16-1 0.3.5.16-1]
    ```

    So I also removed them

    ``` {.bash results="org replace"}
    sudo apt remove musescore3 musescore3-common tor torbrowser-launcher tor-geoipdb
    ```

### One more check

``` {.bash}
sudo apt autoremove 
```

Removal of deprecated packages -- those which are not available in new
version of the system:

``` {.bash}
aptitude search '~o'
# aptitude purge '~o'
```

This command printed no answer so I moved forward.

(4.2.6) Removal of leftover configuration files.

``` {.bash results="org replace"}
find /etc -name '*.dpkg-*' -o -name '*.ucf-*' -o -name '*.merge-error'
```

``` {.bash results="org replace"}
rm -rf /etc/cupsBKP2021_03_26/cups-pdf.conf.dpkg-old /etc/proftpd/proftpd.conf.ucf-dist /etc/cups/cups-pdf.conf.dpkg-old /etc/ca-certificates.conf.dpkg-old
```

### (4.2.7 4.2.8) /etc/apt/sources.list - links to security and updates repositories

Not done.

### (4.2.9) Unofficial sources

Links in files from directory `/etc/apt/sources/list.d` were commented
out -\> (uncomment after upgrade)

1.  ad. (4.2.11) Check package status

    > Regardless of the method used for upgrading, it is recommended
    > that you check the status of all packages first, and verify that
    > all packages are in an upgradable state. The following command
    > will show any packages which have a status of Half-Installed or
    > Failed-Config, and those with any error status.

    Command

    ``` {.bash}
    dpkg --audit
    ```

    printed out long table that I was unable to comprehend, so I decided
    to do just:

    ``` {.bash}
    aptitude search "~ahold"
    ```

    and

    ``` {.bash}
    dpkg --get-selections | grep 'hold$'
    ```

    which printed out nothing... so I did nothing.

### Update of sources.list -\> bullseye

### (4.4.1) Recording the session

( After you have completed the upgrade, you can stop script by typing
exit at the prompt. )

### Minimal system update

``` {.bash}
apt upgrade --without-new-pkgs
```

For safety precautions it\'s better to do minimal system upgrade as a
first step, before doing...

### Full upgrade

``` {.bash}
apt full-upgrade
```

### Problems

-   There are some icons missing in Dolphin. (Solution: go to =System
    Settings -\> Icons -\> = and select on of the Icon Themes. It seems
    like update process deselected it.)

-   There was a problem with proftpd package. (proftpd in Bullseye\'u is
    transitional dummy package). Every attempt of upgrading resulted in
    showing info that `proftpd package is not fully configured` and this
    stopped `apt upgrade` from working. The solution was found
    [here](https://forums.debian.net/viewtopic.php?p=741264) (dylofpoke
    comment from 2022-07-25 10:55).

    I changed the name of configuration file `proftpd.conf`:

```{=html}
<!-- -->
```
    mv /etc/proftpd/proftpd.conf proftpd.confBULLSEYE

and then I installed `proftpd-core` (**without** deinstallation):

    apt install proftpd-core

-   Emacs have problems with diacritics (solution is to explicitly force
    emacs font style in `init.el`)

-   LAN through DisplayLink stopped working, but this problem deserves
    seperate note.
