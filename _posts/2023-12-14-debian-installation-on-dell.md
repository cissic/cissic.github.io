
# Table of Contents

1.  [Debian on Dell](#org6553c93)
    1.  [Preparation](#org9085ae4)
        1.  [Debian live](#org625d987)
        2.  [Warnings](#org2dcdc35)
        3.  [Disk partitioning](#orgfd33e0a)
    2.  [Installation](#org9c038f1)
        1.  [Useful links:](#org7a51b7c)



<a id="org6553c93"></a>

# Debian on Dell


<a id="org9085ae4"></a>

## Preparation


<a id="org625d987"></a>

### Debian live

user: user
pass: live


<a id="org2dcdc35"></a>

### TODO Warnings

1.  ,,Keymap changes do not work in Plasma on Wayland. Please use systemsettings5 instead.'' ?


<a id="orgfd33e0a"></a>

### Disk partitioning

1.  Partitioning

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

2.  GPT / MBR

    After using gparted from live Debian (Bookworm) which created
    new partitions
    I ran the command
    
        sudo parted -l
    
    to check what was the type of partition table. The answer was: gpt.
    For GPT partition table there can exist as many as
    [128 primary partitions on the disk](https://www.google.com/search?q=how+many+primary+partitions+on+gpt&sca_esv=591149029&ei=Wxd8ZZrAJpSrxc8PxLCwYA&ved=0ahUKEwja2afbi5GDAxWUVfEDHUQYDAwQ4dUDCBA&uact=5&oq=how+many+primary+partitions+on+gpt&gs_lp=Egxnd3Mtd2l6LXNlcnAiImhvdyBtYW55IHByaW1hcnkgcGFydGl0aW9ucyBvbiBncHQyBhAAGBYYHjILEAAYgAQYigUYhgNIhEhQAFjmRnAEeAGQAQCYAZcBoAGmHaoBBTE2LjIwuAEDyAEA-AEBwgILEAAYgAQYigUYkQLCAgsQLhiABBjHARjRA8ICBRAAGIAEwgIOEC4YgAQYxwEY0QMY1ALCAgUQLhiABMICCBAuGIAEGNQCwgIKEAAYgAQYigUYQ8ICCxAuGIAEGIoFGJECwgImEC4YgAQYigUYkQIYlwUY3AQY3gQY4AQY9AMY8QMY9QMY9gPYAQHCAggQABgWGB4YCsICCBAAGBYYHhgPwgIFECEYoAHCAggQIRgWGB4YHcICBBAhGBXiAwQYACBBiAYBugYGCAEQARgU&sclient=gws-wiz-serp).

3.  POSTPONED Partitioning via parted and fdisk

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


<a id="org9c038f1"></a>

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

I have created the following partition:

-   2MB unallocated     (this is probably needed by all this new uefi stuff)
-   550 MB fat32 flagged as boot, esp   (this is for /boot/efi)
-   80 GB ext4 (root)
-   432 GB ext4 (home)
-   1,30 TB ext4 (arch)
-   rest: 15,46 GB ntfs


<a id="org7a51b7c"></a>

### Useful links:

