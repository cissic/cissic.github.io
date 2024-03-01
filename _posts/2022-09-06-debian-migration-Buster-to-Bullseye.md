
# Table of Contents

1.  [Debian migration from Buster to Bullseye](#org2571aff)
    1.  [My (first successful :-) !!!) debian upgrade. From Buster (10.12) to Bullseye.](#org3f8e98a)
    2.  [Initial preparations&#x2026;](#org1b74cf5)
    3.  [Uninstalling troublesome packages](#org4b80d69)
        1.  [Command 1: aptitude search](#org6f324c0)
        2.  [Command 2: apt-forktracer](#org8dc2873)
    4.  [One more check](#orgd4afd3b)
    5.  [(4.2.7 4.2.8)  /etc/apt/sources.list - links to security and updates repositories](#org6348b52)
    6.  [(4.2.9) Unofficial sources](#orga321f5e)
        1.  [ad. (4.2.11) Check package status](#orge2642c9)
    7.  [Update of sources.list -> bullseye](#org001c927)
    8.  [(4.4.1) Recording the session](#org4a3d3b6)
    9.  [Minimal system update](#orgbadaa90)
    10. [Full upgrade](#org1af680c)
    11. [Problems](#org1e3f936)



<a id="org2571aff"></a>

# Debian migration from Buster to Bullseye


<a id="org3f8e98a"></a>

## My (first successful :-) !!!) debian upgrade. From Buster (10.12) to Bullseye.

Upgrading Debian from one version to the new one was possible since I started using it (around jessie), however it was always a problem for me. My attempts always ended up in reinstalling system. I suppose I wasn't experienced enough to do it properly in those times. 
When Bullseye appeared I decided to give one more try. 
In the end, it mainly all came down to following strictly debian [manual](https://www.debian.org/releases/stable/amd64/release-notes/ch-upgrading.html) (but I guess this time I did right). I also made some use of [this link](https://linuxize.com/post/how-to-upgrade-debian-10-to-debian-11/).

The following text is a collection of bash commands ran in my upgrading process with some comments of mine.


<a id="org1b74cf5"></a>

## Initial preparations&#x2026;

    # preparation 
    sudo apt-mark showhold   # Packages marked as held back cannot be automatically installed
                             # , upgraded or removed. This may cause issues during the upgrade process. 
    sudo apt update
    sudo apt upgrade
    sudo apt full-upgrade 
    sudo apt autoremove 
    
    cat /etc/apt/sources.list
    cat /etc/debian_version  # make sure your Debian version is really the one you think it is


<a id="org4b80d69"></a>

## Uninstalling troublesome packages

We need to find packages, that was installed from non-Debian repositories, since they can be a cause of problems during the upgrade. There are two methods of doing it (two commands). Neither of them is 100% reliable. And this was my case.


<a id="org6f324c0"></a>

### Command 1: aptitude search

    aptitude search '?narrow(?installed, ?not(?origin(Debian)))'

resulted in

    i  adobereader-enu:i386 - Adobe Reader allows you to view navigate and print PDF files. This version adds advanced forms support (save), better integration with Adobe Acrobat workflows, customizable toolbars and better overall performance.
    i  brscan3 - Brother Scanner Driver
    i  cnijfilter2 - IJ Printer Driver for Linux.
    i  digimend-dkms - Collection of graphics tablet drivers by DIGImend project
    i  guitar - Git GUI Client
    i  nomachine - Fast and secure remote access system
    i  scratux - A free programming language where you can create your own interactive stories, games, and animations
    i  virtualbox-6.1 - Oracle VM VirtualBox
    i  vivaldi-stable - Experience the web in a whole new way with Vivaldi.

So I removed the packages:

    apt remove adobereader-enu brscan3 cnijfilter2 digimend-dkms guitar nomachine scratux virtualbox-6.1 vivaldi-stable


<a id="org8dc2873"></a>

### Command 2: apt-forktracer

    apt-forktracer | sort

resulted in

    musescore3 (3.2.3+dfsg2-11~bpo10+1) [Debian Backports: 3.2.3+dfsg2-11~bpo10+1]
    musescore3-common (3.2.3+dfsg2-11~bpo10+1) [Debian Backports: 3.2.3+dfsg2-11~bpo10+1 3.2.3+dfsg2-11~bpo10+1]
    tor (0.4.5.10-1~bpo10+1) [Debian Backports: 0.4.5.10-1~bpo10+1] [Debian: 0.3.5.16-1 0.3.5.16-1]
    torbrowser-launcher (0.3.3-6~bpo10+1) [Debian Backports: 0.3.3-6~bpo10+1]
    tor-geoipdb (0.4.5.10-1~bpo10+1) [Debian Backports: 0.4.5.10-1~bpo10+1 0.4.5.10-1~bpo10+1] [Debian: 0.3.5.16-1 0.3.5.16-1 0.3.5.16-1 0.3.5.16-1]

So I also removed them

    sudo apt remove musescore3 musescore3-common tor torbrowser-launcher tor-geoipdb


<a id="orgd4afd3b"></a>

## One more check

    sudo apt autoremove 

Removal of deprecated packages &#x2013; those which are not available in new version of the system:

    aptitude search '~o'
    # aptitude purge '~o'

This command printed no answer so I moved forward.

(4.2.6) Removal of leftover configuration files. 

    find /etc -name '*.dpkg-*' -o -name '*.ucf-*' -o -name '*.merge-error'

    rm -rf /etc/cupsBKP2021_03_26/cups-pdf.conf.dpkg-old /etc/proftpd/proftpd.conf.ucf-dist /etc/cups/cups-pdf.conf.dpkg-old /etc/ca-certificates.conf.dpkg-old


<a id="org6348b52"></a>

## (4.2.7 4.2.8)  /etc/apt/sources.list - links to security and updates repositories

Not done.


<a id="orga321f5e"></a>

## (4.2.9) Unofficial sources

Links in files from directory
`/etc/apt/sources/list.d` were commented out -> (uncomment after upgrade)


<a id="orge2642c9"></a>

### ad. (4.2.11) Check package status

> Regardless of the method used for upgrading, it is recommended that you check the status of all packages first, and verify that all packages are in an upgradable state. The following command will show any packages which have a status of Half-Installed or Failed-Config, and those with any error status.

Command

    dpkg --audit

printed out long table that I was unable to comprehend, so I decided to do just:

    aptitude search "~ahold"

and

    dpkg --get-selections | grep 'hold$'

which printed out nothing&#x2026; so I did nothing.


<a id="org001c927"></a>

## Update of sources.list -> bullseye


<a id="org4a3d3b6"></a>

## (4.4.1) Recording the session

( After you have completed the upgrade, you can stop script by typing exit at the prompt. )


<a id="orgbadaa90"></a>

## Minimal system update

    apt upgrade --without-new-pkgs

For safety precautions it's better to do minimal system upgrade as a first step, before doing&#x2026;


<a id="org1af680c"></a>

## Full upgrade

    apt full-upgrade


<a id="org1e3f936"></a>

## Problems

-   There are some icons missing in Dolphin. 
    (Solution: go to =System Settings -> Icons -> = and select on of the Icon Themes. 
     It seems like update process deselected it.)
-   There was a problem with proftpd package. (proftpd in Bullseye'u is transitional dummy package).
    Every attempt of upgrading resulted in showing info that
    `proftpd package is not fully configured` 
    and this stopped `apt upgrade` from working. The solution was found [here](https://forums.debian.net/viewtopic.php?p=741264) (dylofpoke comment 
    from  2022-07-25 10:55).
    
    I changed the name of configuration file `proftpd.conf`:

    mv /etc/proftpd/proftpd.conf proftpd.confBULLSEYE

and then I installed `proftpd-core` (**without** deinstallation):

    apt install proftpd-core

-   Emacs have problems with diacritics (solution is to explicitly force emacs font style in `init.el`)

-   LAN through DisplayLink stopped working, but this problem deserves seperate note.

