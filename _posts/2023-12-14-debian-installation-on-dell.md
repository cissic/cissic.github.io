
# Table of Contents

1.  [Debian on Dell](#org13cd6d9)
    1.  [Preparation](#org96a927c)
        1.  [Debian live default login/password](#org9eff7df)
        2.  [Warnings](#orgd5f02d9)
        3.  [Disk partitioning](#org5564c44)
    2.  [Installation](#org55c3128)
        1.  [General notes](#org3dd4a9f)
        2.  [System configuration](#orgc9de001)
    3.  [Configuration](#orge0e663a)
        1.  [Battery drainage/Moderm Standby/Power management - sleep modes/hibernation](#org14b88ec)
        2.  [Okular and buttons](#orgd746edf)
        3.  [Dell Thunderbolt Dock WD22TB4](#org6a50772)
        4.  [Lenovo keyboard](#org2705ced)
        5.  [Controlling Intel Turbo Boost in Linux](#org4bd2d31)
        6.  [ZRAM - tool for optimizing RAM usage](#orgf22dcdd)
        7.  [Do I need SWAP?](#org976200a)
        8.  [Useful links:](#org99098dd)



<a id="org13cd6d9"></a>

# Debian on Dell


<a id="org96a927c"></a>

## Preparation


<a id="org9eff7df"></a>

### Debian live default login/password

user: user
pass: live


<a id="orgd5f02d9"></a>

### TODO Warnings

1.  ,,Keymap changes do not work in Plasma on Wayland. Please use systemsettings5 instead.'' ?


<a id="org5564c44"></a>

### Disk partitioning

<https://morfikov.github.io/post/jak-przygotowac-dysk-pod-instalacje-debian-linux-z-efi-uefi/>

1.  Binary multiples of kilo

2.  Partitioning

    <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
    
    
    <colgroup>
    <col  class="org-right" />
    
    <col  class="org-right" />
    </colgroup>
    <thead>
    <tr>
    <th scope="col" class="org-right">MB</th>
    <th scope="col" class="org-right">GB</th>
    </tr>
    </thead>
    
    <tbody>
    <tr>
    <td class="org-right">1024</td>
    <td class="org-right">&#xa0;</td>
    </tr>
    
    
    <tr>
    <td class="org-right">2048</td>
    <td class="org-right">&#xa0;</td>
    </tr>
    
    
    <tr>
    <td class="org-right">4096</td>
    <td class="org-right">&#xa0;</td>
    </tr>
    
    
    <tr>
    <td class="org-right">8192</td>
    <td class="org-right">&#xa0;</td>
    </tr>
    
    
    <tr>
    <td class="org-right">16384</td>
    <td class="org-right">&#xa0;</td>
    </tr>
    
    
    <tr>
    <td class="org-right">32768</td>
    <td class="org-right">32</td>
    </tr>
    
    
    <tr>
    <td class="org-right">65536</td>
    <td class="org-right">64</td>
    </tr>
    
    
    <tr>
    <td class="org-right">81920</td>
    <td class="org-right">80</td>
    </tr>
    
    
    <tr>
    <td class="org-right">131072</td>
    <td class="org-right">128</td>
    </tr>
    
    
    <tr>
    <td class="org-right">262144</td>
    <td class="org-right">256</td>
    </tr>
    
    
    <tr>
    <td class="org-right">524288</td>
    <td class="org-right">512</td>
    </tr>
    
    
    <tr>
    <td class="org-right">1048576</td>
    <td class="org-right">1024</td>
    </tr>
    </tbody>
    
    <tbody>
    <tr>
    <td class="org-right">81920</td>
    <td class="org-right">80=64+16</td>
    </tr>
    </tbody>
    
    <tbody>
    <tr>
    <td class="org-right">442368</td>
    <td class="org-right">432</td>
    </tr>
    
    
    <tr>
    <td class="org-right">1367056</td>
    <td class="org-right">1300</td>
    </tr>
    
    
    <tr>
    <td class="org-right">&#xa0;</td>
    <td class="org-right">&#xa0;</td>
    </tr>
    </tbody>
    </table>
    
    1.  / - 80 GB
    
    2.  /home - (512-80)= 432 GB
    
    3.  arch - 1383440-16384
    
    4.  NTFSTrash - 16 GB
    
    5.  no SWAP

3.  GPT / MBR

    After using gparted from live Debian (Bookworm) which created
    new partitions
    I ran the command
    
        sudo parted -l
    
    to check what was the type of partition table. The answer was: gpt.
    For GPT partition table there can exist as many as
    [128 primary partitions on the disk](https://www.google.com/search?q=how+many+primary+partitions+on+gpt&sca_esv=591149029&ei=Wxd8ZZrAJpSrxc8PxLCwYA&ved=0ahUKEwja2afbi5GDAxWUVfEDHUQYDAwQ4dUDCBA&uact=5&oq=how+many+primary+partitions+on+gpt&gs_lp=Egxnd3Mtd2l6LXNlcnAiImhvdyBtYW55IHByaW1hcnkgcGFydGl0aW9ucyBvbiBncHQyBhAAGBYYHjILEAAYgAQYigUYhgNIhEhQAFjmRnAEeAGQAQCYAZcBoAGmHaoBBTE2LjIwuAEDyAEA-AEBwgILEAAYgAQYigUYkQLCAgsQLhiABBjHARjRA8ICBRAAGIAEwgIOEC4YgAQYxwEY0QMY1ALCAgUQLhiABMICCBAuGIAEGNQCwgIKEAAYgAQYigUYQ8ICCxAuGIAEGIoFGJECwgImEC4YgAQYigUYkQIYlwUY3AQY3gQY4AQY9AMY8QMY9QMY9gPYAQHCAggQABgWGB4YCsICCBAAGBYYHhgPwgIFECEYoAHCAggQIRgWGB4YHcICBBAhGBXiAwQYACBBiAYBugYGCAEQARgU&sclient=gws-wiz-serp).

4.  POSTPONED Partitioning via parted and fdisk

    :FNAME: disk<sub>partitioning.el</sub>
    
    I abandoned this section because of the fact that partitions in
    `parted` didn't have the same size as the ones created by `gparted`
    although I calculated the numbers to correspond to each other.
    In the end I created the partitions in `gparted`. .
    
    According to <https://phoenixnap.com/kb/linux-create-partition>.
    
    List disks available for the system:
    
        sudo parted -l
    
    Select the disk you want to partition:
    
        sudo parted /dev/nvme0n1
    
    Now parted opens the disk for being partitioned.
    
    1.  In `(parted)` command line
    
        Inside `parted` command line create a partition table before partitioning the disk:
        
            mklabel gpt
        
        Now, you can check if the partition table was created:
        
            print
        
        Let's create partitions. The assigned disk start for the first partition **shall be 1MB**. We want to create disks of the following
        sizes:
        
        -   root: 81920 MB (80 GB)
        -   home: 442368 MB (432 GB)
        -   
        
        **WARNING!** The disk sizes given below in `parted` do not match the sizes given in graphical `gparted`. 
        
            mkpart primary ext4 1MB 81921MB
            mkpart primary ext4 81922MB 524290MB


<a id="org55c3128"></a>

## Installation

During the installation I obtained the error mentioned here:
<https://askubuntu.com/questions/502307/the-attempt-to-mount-a-file-system-with-type-vfat-in-ssi10-0-0-partition1sda>

How to circumvent it?

-   I disabled in BIOS:
    -   `SecureBoot`
    -   `Microsoft UEFI CA`
    -   `Secure Boot Mode` set to `Audit Mode`
    
    -   `Storage` -> `SATA/NVMe Operation` -> (RAID On) changed to `AHCI/NVMe`

I don't know whether the above steps were needed. I think the most
important was creating FAT32 EFI partition at the beginning of the
disk. I didn't have it after cleaning all partitions from the disk.

The easiest approach to the problem was to use Calamares installator
launched from inside Debian Live.
It suggested proper partitioning of the disk:

-   300 MB for FAT32 (EFI partition) flagged as boot and mount point /boot/efi
-   68,74 GB for swap
-   and the rest for ext4.

Following this clue and basing on the following threads (550 MB per efi partition):

-   <https://askubuntu.com/questions/1313154/how-to-know-the-proper-amount-of-needed-disk-space-for-efi-partition>
-   <https://askubuntu.com/questions/1011821/what-is-the-correct-and-reliable-way-to-freshly-install-ubuntu-gnome-in-an-nvme?newreg=52d1fba44a84418fbb0e15cc74e25b30>

I have created the following partitions:

-   2MB unallocated     (this is probably needed by all this new uefi stuff)
-   550 MB fat32 flagged as boot, esp   (this is for /boot/efi)
-   80 GB ext4 (root)
-   432 GB ext4 (home)
-   1,30 TB ext4 (arch)

-   rest: 15,46 GB ntfs (NTFSTrash)


<a id="org3dd4a9f"></a>

### General notes

Moving to testing branch was problematic. In the end, after several
attempt I succeded. However I stumbled upon some problems: 

-   problems with installing NVIDIA drivers
-   problems with login to KDE session after upgrade to testing
-   cannot run Vivaldi (and chromium neither) after upgrade to
    testing (some problems with `kwallet`)

After all, it seems to me that crucial steps of the installation
process are:

1.  Install debian `bookworm` from `net-inst` image! When installing
    from `live-cd` I had a problems with login to KDE session after
    system upgrade. It wasn't impossible after `net-inst` installation
    (still I cannot login to Wayland session, only X11 is available).
    This needs some more investigation.

2.  Add `contrib` and `non-free` (`non-free-firmware` already is) to
    appropriate lines in `sources.list`.
    `non-free` is necessary for easy installation of NVIDIA drivers.
    (`update` and `upgrade` system then)

3.  Now you are able to install NVIDIA drivers from debian repositories.

4.  In the end you can edit `sources.list` and change `bookworm` to
    testing to perform `apt full-upgrade`.

Keeping this order of steps I had no problems with `kwallet` and `vivaldi`.


<a id="orgc9de001"></a>

### System configuration

1.  Moving to `testing` branch

    After `bookworm` installation the content of `/etc/apt/sources.list` was:
    
        # See https://wiki.debian.org/SourcesList for more information.
        deb http://deb.debian.org/debian bookworm main non-free-firmware
        deb-src http://deb.debian.org/debian bookworm main non-free-firmware
        
        deb http://deb.debian.org/debian bookworm-updates main non-free-firmware
        deb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware
        
        deb http://security.debian.org/debian-security/ bookworm-security main non-free-firmware
        deb-src http://security.debian.org/debian-security/ bookworm-security main non-free-firmware
        
        # Backports allow you to install newer versions of software made available for this release
        deb http://deb.debian.org/debian bookworm-backports main non-free-firmware
        deb-src http://deb.debian.org/debian bookworm-backports main non-free-firmware
    
    This is what I did according to this page:
    <https://linuxiac.com/how-to-switch-from-debian-stable-to-testing/>
    
    1.  Update Debian Stable
    
            sudo apt update 
            sudo apt upgrade
    
    2.  Edit `sources.list` file
    
        Make a `sources.list` backup
        
            sudo cp /etc/apt/sources.list /etc/apt/sources.list.BKP
        
        and replace the strings found in lines starting with “deb” or “deb-src,” 
        referencing the distribution’s codename with the word “testing.”
        
        Comment out or remove all the lines containing `-backports`.
        
        `contrib` also needs to be added (for example `matlab-support` package
        resides there), and do not forget about `non-free` (!), where
        `nvidia-detect` is located!
        
        Now my `sources.list` looks like:
        
            #deb cdrom:[Debian GNU/Linux 12.4.0 _Bookworm_ - Official amd64 NETINST with firmware 20231210-17:56]/ bookworm main non-free-firmware
            
            deb http://ftp.pl.debian.org/debian/ testing main non-free-firmware contrib non-free
            deb-src http://ftp.pl.debian.org/debian/ testing main non-free-firmware contrib non-free
            
            deb http://security.debian.org/debian-security testing-security main non-free-firmware contrib non-free
            deb-src http://security.debian.org/debian-security testing-security main non-free-firmware contrib non-free
            
            # bookworm-updates, to get updates before a point release is made;
            # see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
            deb http://ftp.pl.debian.org/debian/ testing-updates main non-free-firmware contrib non-free
            deb-src http://ftp.pl.debian.org/debian/ testing-updates main non-free-firmware contrib non-free
            
            # This system was installed using small removable media
            # (e.g. netinst, live or single CD). The matching "deb cdrom"
            # entries were disabled at the end of the installation process.
            # For information about how to configure apt package sources,
            # see the sources.list(5) manual.
        
        Now again update and upgrade system:
        
            sudo apt update
            sudo apt upgrade
        
        Here, I stumbled upon an error.
        In my case the above commands triggered an error with unmet dependencies:
        
            gnustep-base-runtime : Wymaga: gnustep-base-common (= 1.29.0-7) ale 1.28.1+really1.28.0-5 ma zostać zainstalowany
            libgnustep-base1.29 : Wymaga: gnustep-base-common (= 1.29.0-7) ale 1.28.1+really1.28.0-5 ma zostać zainstalowany
    
    3.  Performing full upgrade
    
        Basing on [this](https://unix.stackexchange.com/questions/594257/debian-bullseye-no-upgrade-due-to-gnustep-base-runtime-unmet-dependencies) thread I decided on doing full-upgrade:
        
            sudo apt full-upgrade
        
        which resulted in doing upgrade without any problems but
        
            /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.UTF-8)
            W: Possible missing firmware /lib/firmware/i915/mtl_huc_gsc.bin for module i915
            W: Possible missing firmware /lib/firmware/i915/mtl_guc_70.bin for module i915
            W: Possible missing firmware /lib/firmware/nvidia/ga107/acr/ucode_ahesasc.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/acr/ucode_ahesasc.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/acr/ucode_ahesasc.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/acr/ucode_ahesasc.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga107/acr/ucode_asb.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/acr/ucode_asb.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/acr/ucode_asb.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/acr/ucode_asb.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga107/acr/ucode_unload.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/acr/ucode_unload.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/acr/ucode_unload.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/acr/ucode_unload.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga107/nvdec/scrubber.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/nvdec/scrubber.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/nvdec/scrubber.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/nvdec/scrubber.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga107/sec2/hs_bl_sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga107/sec2/sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga107/sec2/image.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga107/sec2/desc.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/sec2/hs_bl_sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/sec2/sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/sec2/image.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga106/sec2/desc.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/sec2/hs_bl_sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/sec2/sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/sec2/image.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga104/sec2/desc.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/sec2/hs_bl_sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/sec2/sig.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/sec2/image.bin for module nouveau
            W: Possible missing firmware /lib/firmware/nvidia/ga103/sec2/desc.bin for module nouveau
        
        1.  Problems
        
            1.  Generating locale
            
                My `~/.bashrc` is set to British English and during installation
                I set my locale to my native language which was the only available
                on my system.
                In order to get rid of the warning
                `/bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.UTF-8)`
                you need to (according to [this thread](https://serverfault.com/questions/54591/how-to-install-change-locale-on-debian)):
                
                -   open `/etc/locale.gen`
                -   uncomment the line with `en_GB.UTF-8`
                -   run `sudo locale-gen`
                
                Then the warning about locale disappears.
            
            2.  PROBLEM: Native language as default language of bash
            
                In order to change for a session the output language of bash
                one may change the `LANGUAGE` variable:
                
                Check the current `locale` settings with `locale`.
                Run the command `LANGUAGE=en_GB` (provided you generated `en_GB`
                locale earlier). This should change the language in the session.
                
                [Thread worth reading about locale](https://askubuntu.com/questions/264283/switch-command-output-language-from-native-language-to-english).
            
            3.  POSTPONED Cannot login via Wayland session to KDE
            
                After `full-upgrade` of the system to `testing`
                I couldn't log in into KDE.
                My first installation was via Debian Live and I thought
                that maybe saomething was wrong with this image, so I reinstalled
                `/` partition with the use of `net-inst` image.
                It occured that again I was not able to log in to KDE session
                after doing the procedure of full-upgrading.
                Then I was illuminated and decided to change 
    
    4.  Edit `fstab` so it can mount other disks not indicated during installation
    
    5.  Other useful links:
    
        -   <https://itsfoss.com/switch-debian-stable-testing/>
        -   <https://wiki.debian.org/DebianTesting>

2.  Installing firmware, software and other ware

    1.  Firmware NVIDIA
    
        Information: This step was performed on `bookworm`, before moving
        to `testing`.
        
        When trying to install drivers for nvidia I stumbled upon information
        on `nvidia-detect` package. The problem was I couldn't find it via
        `apt`. The solution was that `nvidia-detect` is located in
        `non-free` repository! (From `bookworm` on new repository
        `non-free-firmware` is introduced, but `nvidia-detect` is not there).
        So the solution was to update my `sources.list` to have `non-free`
        in every appropriate line (and then `sudo apt update` of course...).
        
        In fact some internet sources do contain the above information
        (<https://phoenixnap.com/kb/nvidia-drivers-debian>)
        but I ignored them being sure that `non-free` was just renamed
        to `non-free-firmware`.
        
            sudo apt install nvidia-detect
        
        Detect the drivers
        
            sudo nvidia-detect
        
        and according to the message above install `nvidia-driver`
        
            sudo apt install nvidia-driver -y
        
        and reboot
        
            sudo systemctl reboot
        
        1.  Notes:
        
            -   It seems that nvidia packages are available only for xorg
                not for wayland ( x11 in 
                <https://packages.debian.org/search?keywords=nvidia-detect>
        
        2.  DEPRECATED OLD APPROACH
        
            The link I was following:
            <https://phoenixnap.com/kb/nvidia-drivers-debian>
            
                sudo apt install software-properties-common -y
            
            You need to check your system. It is 64 bit of course
            
                lscpu | grep CPU
            
            So now install apropriate headers
            
                sudo apt install linux-headers-amd64
                sudo apt -y install linux-headers-$(uname -r) build-essential libglvnd-dev pkg-config
                nano /etc/modprobe.d/blacklist-nouveau.conf
            
            edit the file by adding the lines:
            
                blacklist nouveau
                options nouveau modeset=0
            
            Install Nvidia Drivers via Debian’s Default Repository
            
                wget https://us.download.nvidia.com/XFree86/Linux-x86_64/470.129.06/NVIDIA-Linux-x86_64-470.129.06.run
            
            Change the permission to run the file and do
            
                sudo ./NVIDIA-Linux-x86_64-470.129.06.run
            
            This was the output:
            
                One or more modprobe configuration files to disable Nouveau have been written.  For some distributions, this may be sufficient to disable Nouveau; other distributions may require modification  
                of the initial ramdisk.  Please reboot your system and attempt NVIDIA driver installation again.  Note if you later wish to re-enable Nouveau, you will need to delete these files:
                /usr/lib/modprobe.d/nvidia-installer-disable-nouveau.conf, /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
        
        3.  Useful links
        
            <https://www.linuxcapable.com/install-nvidia-drivers-on-debian/>
    
    2.  Emacs
    
            sudo apt install bash-completion auto-complete-el -y
            sudo apt install emacs -y
    
    3.  Vivaldi
    
        In the newer debian releases (from `bullseye` on)
        you can do the following (taken from
        [here](https://itsfoss.com/install-vivaldi-ubuntu-linux/))
        (probably you also need the first line from the old method i.e.:
        `sudo apt install software-properties-common apt-transport-https wget ca-certificates gnupg2 -y`):
        
            wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
            echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
            sudo apt update
            sudo apt install vivaldi-stable -y
        
        1.  DEPRECATED Problem:
        
            After moving my home files from the on machine I got an error
            with a message saying about
            blocking Vivaldi profile to prevent its damage.
            Something like:
            
                [21991:21991:1217/184949.211853:ERROR:process_singleton_posix.cc(353)] The profile appears to be in use by another Vivaldi process (2153709) on another computer (debi). Vivaldi has locked the profile so that it doesn't get corrupted. If you are sure no other processes are using this profile, you can unlock the profile and relaunch Vivaldi.
                [21991:21991:1217/184949.211893:ERROR:message_box_dialog.cc(146)] Unable to show a dialog outside the UI thread message loop: Vivaldi - The profile appears to be in use by another Vivaldi process (2153709) on another computer (debi). Vivaldi has locked the profile so that it doesn't get corrupted. If you are sure no other processes are using this profile, you can unlock the profile and relaunch Vivaldi.
            
            I found sth similar
            [here](https://forum.vivaldi.net/topic/61741/unlock-profile-and-relaunch/4) and tried to use the same remedy:
            
            Deleted ~/.config/vivaldi
            
            The same happens with chromium.
            
            Deleted ./config/chromium.
            
            No success.
            
            **SOLUTION**:
            
            At some point a deleted `~/.cache` and moved `~/.config/vivaldi` to 
            `~/.config/vivaldiBKP`, ran `vivaldi-stable` which worked creating
            new `~/.config/vivaldi` with new profile, deleted `~/.config/vivaldi`,
            and moved back `~/.config/vivaldiBKP` to `~/.config/vivaldi`.
            Now my profiles are back!
        
        2.  DEPRECATED Old method of dealing with vivaldi repositories
        
            This method was good until `bullseye`.
            Explanation why this does not work is
            [here](https://mauriziosiagri.wordpress.com/tag/gpg-dearmor/) (probably because I didn't care to read it carefully).
            
                # vivaldi 
                sudo apt install software-properties-common apt-transport-https wget ca-certificates gnupg2 -y
                sudo wget -O- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/vivaldi.gpg
                sudo echo deb [arch=amd64 signed-by=/usr/share/keyrings/vivaldi.gpg] https://repo.vivaldi.com/archive/deb/ stable main | sudo tee /etc/apt/sources.list.d/vivaldi.list
                sudo apt update
                sudo apt install vivaldi-stable -y
    
    4.  Others
    
            sudo apt install thunderbird octave pandoc texstudio -y
            sudo apt install wine winetricks winbind -y
            # for launching 32bit application
            sudo dpkg --add-architecture i386 && sudo apt update && sudo apt install wine32 
            sudo apt install default-jdk docker.io gitk -y
            
            sudo apt install audacity chromium okular okular-extra-backends -y
            
            sudo apt install ffmpeg filezilla gparted imagemagick kdiff3 keepassxc ktorrent -y
            
            sudo apt install torbrowser-launcher vlc xournal ncdu -y
            
            # 
            sudo apt install goldendict clementine -y
            
            sudo apt install net-tools curl wget -y   # ifconfig
            
            # packages needed by useful  ~/binmb scripts
            sudo apt install xdotool xcalib -y
            
            # gcal used in my conky 
            sudo apt install gcal conky -y # TODO? automatic launch after booting....
            
            # configuring Python for Emacs
            sudo apt install python3-pip
            # pip3 install jedi autopep8 flake8 ipython importmagic yapf
            sudo apt install python3-jedi python3-autopep8 python3-flake8 python3-ipython python3-importmagic python3-yapf -y
            
            
            
            
            # Old (not needed now?)
            # sudo apt install python3-pip spyder -y
            # sudo apt install autokey-gtk proftpd gadmin-proftpd kazam khotkeys
            # sudo apt install gmsh tetgen dolfin julia lsb-release ncal
    
    5.  Cups (already installed)
    
            # cups
            sudo apt install cups cups-browsed
            sudo systemctl start cups-browsed
    
    6.  SOLVED Problem with conky disappearing
    
        `gcal` was missing. After installing everything worked fine.
    
    7.  Matlab
    
        Install matlab and **then** `matlab-support` package(when installing
        `matlab-support` you need to pass matlab path as a parameter to the
        installator of the package.
        
            sudo apt install matlab-support
    
    8.  Miktex
    
        According to
        [official Miktex page](https://miktex.org/download) you need to:
        
        -   Register GPG key
        
            curl -fsSL https://miktex.org/download/key | sudo tee /usr/share/keyrings/miktex-keyring.asc > /dev/null
        
        -   Register installation source
        
            echo "deb [signed-by=/usr/share/keyrings/miktex-keyring.asc] https://miktex.org/download/debian bookworm universe" | sudo tee /etc/apt/sources.list.d/miktex.list
        
        There is not available neither `trixie` nor `testing` branch so all you
        can do is to add `bookworm` branch.
        
        -   Install MikTeX
        
            sudo apt-get update
            sudo apt-get install miktex
        
        -   Finish the setup
        
            miktexsetup finish
        
        and set automatic package installation
        
            initexmf --set-config-value [MPM]AutoInstall=1


<a id="orge0e663a"></a>

## Configuration


<a id="org14b88ec"></a>

### TODO Battery drainage/Moderm Standby/Power management - sleep modes/hibernation

The problem is as follows:
Once upon a time there were sleeping modes which worked perfectly.
S3 mode was a deep sleep. 

<https://askubuntu.com/questions/1398674/battery-drain-during-suspend-mode-when-lid-is-closed-20-in-8-hours>

-   Hacks for Windows registry to enable S3 sleep mode.

<https://www.dell.com/community/en/conversations/xps/dell-s3-sleep-mode-again/647f865bf4ccf8a8de560264>

-   Quite a long thread:

<https://www.dell.com/community/en/conversations/xps/xps-13-9310-ubuntu-deep-sleep-missing/647f8daff4ccf8a8dee4f308?page=5>

-   Another forum thread:
    <https://discussion.fedoraproject.org/t/please-improve-the-s0ix-experience-under-linux/79113/37>

1.  TODO How to properly configure hibernation/sleep in Linux? ?

    Useful pages:
    <https://news.ycombinator.com/item?id=30166802>
    <https://wiki.archlinux.org/title/Power_management#Suspend_and_hibernate>
    <https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate>
    <https://www.howtogeek.com/885752/is-hibernating-your-pc-bad-for-your-ssd/>
    
    1.  First, you need to have swap partition or swap file!
        -> <https://superuser.com/questions/21020/can-i-hibernate-linux-without-a-swap-partition>
        How to create swapfile?
        <https://ubuntuforums.org/showthread.php?t=1042946> (example for ubuntu)

2.  POSTPONED Configuring s0ix - Approach 1

    I used this script
    <https://github.com/intel/S0ixSelftestTool>
    to check S0ix feature of my laptop.
    First, you need to install
    
        sudo apt install acpica-tools
    
    Now, get the script from github
    
        wget https://github.com/intel/S0ixSelftestTool/blob/main/s0ix-selftest-tool.sh
    
    and run it (as root):
    
        sudo bash s0ix-selftest-tool.sh
    
        Intel ACPI Component Architecture
        ASL+ Optimizing Compiler/Disassembler version 20230628
        Copyright (c) 2000 - 2023 Intel Corporation
        
        File appears to be binary: found 424 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file apic.dat, Length 0x1DC (476) bytes
        ACPI: APIC 0x0000000000000000 0001DC (v05 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [APIC] decoded
        Formatted output:  apic.dsl - 25542 bytes
        File appears to be binary: found 30 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file bgrt.dat, Length 0x38 (56) bytes
        ACPI: BGRT 0x0000000000000000 000038 (v01 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [BGRT] decoded
        Formatted output:  bgrt.dsl - 1615 bytes
        File appears to be binary: found 17 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file boot.dat, Length 0x28 (40) bytes
        ACPI: BOOT 0x0000000000000000 000028 (v01 DELL   CBX3     00000002      01000013)
        Acpi Data Table [BOOT] decoded
        Formatted output:  boot.dsl - 1207 bytes
        File appears to be binary: found 54 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file dbg2.dat, Length 0x54 (84) bytes
        ACPI: DBG2 0x0000000000000000 000054 (v00 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [DBG2] decoded
        Formatted output:  dbg2.dsl - 2608 bytes
        File appears to be binary: found 29 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file dbgp.dat, Length 0x34 (52) bytes
        ACPI: DBGP 0x0000000000000000 000034 (v01 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [DBGP] decoded
        Formatted output:  dbgp.dsl - 1648 bytes
        File appears to be binary: found 108 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file dmar.dat, Length 0x88 (136) bytes
        ACPI: DMAR 0x0000000000000000 000088 (v02 INTEL  Dell Inc 00000002      01000013)
        Acpi Data Table [DMAR] decoded
        Formatted output:  dmar.dsl - 4136 bytes
        File appears to be binary: found 202909 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file dsdt.dat, Length 0x93AA6 (604838) bytes
        ACPI: DSDT 0x0000000000000000 093AA6 (v02 DELL   Dell Inc 00000002      01000013)
        Pass 1 parse of [DSDT]
        Pass 2 parse of [DSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    dsdt.dsl - 4294749 bytes
        File appears to be binary: found 235 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file facp.dat, Length 0x114 (276) bytes
        ACPI: FACP 0x0000000000000000 000114 (v06 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [FACP] decoded
        Formatted output:  facp.dsl - 10167 bytes
        File appears to be binary: found 59 non-ASCII characters, disassembling
        ACPI Warning: Table header for [FACS] has invalid ASCII character(s) (20230628/acfileio-600)
        Binary file appears to be a valid ACPI table, disassembling
        Input file facs.dat, Length 0x40 (64) bytes
        ACPI Warning: Table header for [FACS] has invalid ASCII character(s) (20230628/acfileio-600)
        ACPI: FACS 0x0000000000000000 000040
        ACPI Warning: Table header for [FACS] has invalid ASCII character(s) (20230628/acfileio-600)
        Acpi Data Table [FACS] decoded
        Formatted output:  facs.dsl - 1377 bytes
        File appears to be binary: found 26 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file fpdt.dat, Length 0x34 (52) bytes
        ACPI: FPDT 0x0000000000000000 000034 (v01 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [FPDT] decoded
        Formatted output:  fpdt.dsl - 1461 bytes
        File appears to be binary: found 32 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file hpet.dat, Length 0x38 (56) bytes
        ACPI: HPET 0x0000000000000000 000038 (v01 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [HPET] decoded
        Formatted output:  hpet.dsl - 1874 bytes
        File appears to be binary: found 160 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file lpit.dat, Length 0xCC (204) bytes
        ACPI: LPIT 0x0000000000000000 0000CC (v01 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [LPIT] decoded
        Formatted output:  lpit.dsl - 5899 bytes
        File appears to be binary: found 36 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file mcfg.dat, Length 0x3C (60) bytes
        ACPI: MCFG 0x0000000000000000 00003C (v01 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [MCFG] decoded
        Formatted output:  mcfg.dsl - 1535 bytes
        File appears to be binary: found 32 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file msdm.dat, Length 0x55 (85) bytes
        ACPI: MSDM 0x0000000000000000 000055 (v03 DELL   CBX3     06222004 AMI  00010013)
        Acpi Data Table [MSDM] decoded
        Formatted output:  msdm.dsl - 1808 bytes
        File appears to be binary: found 691 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file nhlt.dat, Length 0x2F1 (753) bytes
        ACPI: NHLT 0x0000000000000000 0002F1 (v00 DELL   Dell Inc 00000002      01000013)
        Acpi Data Table [NHLT] decoded
        Formatted output:  nhlt.dsl - 13925 bytes
        File appears to be binary: found 781 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file phat.dat, Length 0x506 (1286) bytes
        ACPI: PHAT 0x0000000000000000 000506 (v01 DELL   Dell Inc 00000005 MSFT 0100000D)
        Acpi Data Table [PHAT] decoded
        Formatted output:  phat.dsl - 17365 bytes
        File appears to be binary: found 9383 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt10.dat, Length 0x8885 (34949) bytes
        ACPI: SSDT 0x0000000000000000 008885 (v02 DELL   NvdTable 00001000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt10.dsl - 206968 bytes
        File appears to be binary: found 1132 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt11.dat, Length 0xF7D (3965) bytes
        ACPI: SSDT 0x0000000000000000 000F7D (v02 DELL   xh_Dell_ 00000000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Firmware Error (ACPI): Failure creating named object [\_SB.PC00.XHCI.RHUB.HS10.SADX], AE_ALREADY_EXISTS (20230628/dswload-387)
        ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20230628/psobject-264)
        Could not parse ACPI tables, AE_ALREADY_EXISTS
        File appears to be binary: found 2496 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt12.dat, Length 0x3AEA (15082) bytes
        ACPI: SSDT 0x0000000000000000 003AEA (v02 SocGpe SocGpe   00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt12.dsl - 50421 bytes
        File appears to be binary: found 3114 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt13.dat, Length 0x39DA (14810) bytes
        ACPI: SSDT 0x0000000000000000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt13.dsl - 46426 bytes
        File appears to be binary: found 72 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt14.dat, Length 0x144 (324) bytes
        ACPI: SSDT 0x0000000000000000 000144 (v02 Intel  ADebTabl 00001000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt14.dsl - 2349 bytes
        File appears to be binary: found 172 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt15.dat, Length 0x1AB (427) bytes
        ACPI: SSDT 0x0000000000000000 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt15.dsl - 2775 bytes
        File appears to be binary: found 437 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt16.dat, Length 0x540 (1344) bytes
        ACPI: SSDT 0x0000000000000000 000540 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt16.dsl - 7427 bytes
        File appears to be binary: found 1035 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt17.dat, Length 0x668 (1640) bytes
        ACPI: SSDT 0x0000000000000000 000668 (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt17.dsl - 11965 bytes
        File appears to be binary: found 726 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt18.dat, Length 0x4CF (1231) bytes
        ACPI: SSDT 0x0000000000000000 0004CF (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt18.dsl - 13907 bytes
        File appears to be binary: found 1541 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt19.dat, Length 0x1BAF (7087) bytes
        ACPI: SSDT 0x0000000000000000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt19.dsl - 37700 bytes
        File appears to be binary: found 490 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt1.dat, Length 0x38C (908) bytes
        ACPI: SSDT 0x0000000000000000 00038C (v02 PmaxDv Pmax_Dev 00000001 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt1.dsl - 9989 bytes
        File appears to be binary: found 801 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt20.dat, Length 0x1038 (4152) bytes
        ACPI: SSDT 0x0000000000000000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt20.dsl - 18744 bytes
        File appears to be binary: found 1000 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt21.dat, Length 0x1349 (4937) bytes
        ACPI: SSDT 0x0000000000000000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt21.dsl - 20861 bytes
        File appears to be binary: found 777 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt22.dat, Length 0xFBB (4027) bytes
        ACPI: SSDT 0x0000000000000000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt22.dsl - 18476 bytes
        File appears to be binary: found 4991 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt2.dat, Length 0x5C55 (23637) bytes
        ACPI: SSDT 0x0000000000000000 005C55 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt2.dsl - 116040 bytes
        File appears to be binary: found 7813 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt3.dat, Length 0x554F (21839) bytes
        ACPI: SSDT 0x0000000000000000 00554F (v02 DptfTb DptfTabl 00001000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt3.dsl - 146467 bytes
        File appears to be binary: found 1213 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt4.dat, Length 0x1697 (5783) bytes
        ACPI: SSDT 0x0000000000000000 001697 (v02 DELL   DellRtd3 00001000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt4.dsl - 15929 bytes
        File appears to be binary: found 1330 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt5.dat, Length 0x1343 (4931) bytes
        ACPI: SSDT 0x0000000000000000 001343 (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt5.dsl - 31084 bytes
        File appears to be binary: found 13315 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt6.dat, Length 0xD487 (54407) bytes
        ACPI: SSDT 0x0000000000000000 00D487 (v02 INTEL  TcssSsdt 00001000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        
        Found 2 external control methods, reparsing with new information
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt6.dsl - 345674 bytes
        File appears to be binary: found 1129 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt7.dat, Length 0x107C (4220) bytes
        ACPI: SSDT 0x0000000000000000 00107C (v02 DELL   UsbCTabl 00001000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt7.dsl - 26241 bytes
        File appears to be binary: found 605 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt8.dat, Length 0xB44 (2884) bytes
        ACPI: SSDT 0x0000000000000000 000B44 (v02 DELL   PtidDevc 00001000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt8.dsl - 12282 bytes
        File appears to be binary: found 3135 non-ASCII characters, disassembling
        Binary file appears to be a valid ACPI table, disassembling
        Input file ssdt9.dat, Length 0x2357 (9047) bytes
        ACPI: SSDT 0x0000000000000000 002357 (v02 DELL   TbtTypeC 00000000 INTL 20200717)
        Pass 1 parse of [SSDT]
        Pass 2 parse of [SSDT]
        Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
        
        Parsing completed
        Disassembly completed
        ASL Output:    ssdt9.dsl - 86922 bytes
        Low Power S0 Idle is 1
        The system supports S0ix!
    
    1.  NVidia support for S0ix
    
        <https://download.nvidia.com/XFree86/Linux-x86_64/460.32.03/README/powermanagement.html>


<a id="orgd746edf"></a>

### Okular and buttons

-   Invert colours, turn to black and white


<a id="org6a50772"></a>

### Dell Thunderbolt Dock WD22TB4

Software (ubuntu) for firmware update 
<https://www.dell.com/support/home/pl-pl/product-support/product/wd22tb4-dock/drivers>

1.  Configuring LAN through docking station.

    All you need to do is to
    use MAC address of your laptop for MAC address of the connection
    destined for DockingStation connection. Taken from here:
    <https://www.dell.com/community/en/conversations/networking-internet-bluetooth/ethernet-does-not-work-when-connected-to-docking-station-e-port/647f58e8f4ccf8a8de3327ab>
    
    In KDE you need to go to:
    
    System Settings -> Connections -> Cable -> Cloned MAC address
    
    write down you laptop MAC and you are good to go! :)


<a id="org2705ced"></a>

### Lenovo keyboard

Swapping between FN and Ctrl can be impossible. Info on that topic
can be found here:
<https://superuser.com/questions/65/remap-fn-to-another-key>
<https://askubuntu.com/questions/1403447/mapping-left-ctrl-and-fn-keys-in-ubuntu-20-04-4-lts>
<https://superuser.com/questions/1643156/state-of-fn-key-under-linux>
<https://askubuntu.com/questions/193529/how-to-swap-between-fn-and-ctrl-keys>
<https://bbs.archlinux.org/viewtopic.php?id=125932>
<https://bbs.archlinux.org/viewtopic.php?id=235995>
<https://forums.opensuse.org/t/is-it-possible-in-kde-to-switch-the-fn-and-left-ctrl-keys/120000>


<a id="org4bd2d31"></a>

### TODO Controlling Intel Turbo Boost in Linux

<https://forums.linuxmint.com/viewtopic.php?t=399482>
<https://github.com/AdnanHodzic/auto-cpufreq>


<a id="orgf22dcdd"></a>

### ZRAM - tool for optimizing RAM usage

<https://www.reddit.com/r/openSUSE/comments/qco74z/64_gb_ram_any_need_for_swap/>
<https://youtube.com/watch?v=RGVt16xiERc>


<a id="org976200a"></a>

### Do I need SWAP?

<https://www.reddit.com/r/openSUSE/comments/qco74z/64_gb_ram_any_need_for_swap/>

1.  TODO 2D

    -   register MAC adresses of laptop and docking station
    
    -   rest: 15,46 GB ntfs


<a id="org99098dd"></a>

### Useful links:

