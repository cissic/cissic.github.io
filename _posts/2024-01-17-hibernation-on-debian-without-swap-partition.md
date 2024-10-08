
# Table of Contents

1.  [Hibernation on Debian without swap partition](#orga4aaf3d)
    1.  [Enabling hibernation on Debian (bookworm-testing-trixie)](#org73dd61c)
        1.  [Create swapfile and configure it](#org879fc3c)
        2.  [Update grub and initramfs](#org7dcefda)
        3.  [Test hibernation straight away](#orgfc00f4f)
    2.  [Enabling `suspend-then-hibernate`](#org0e7cc2f)
        1.  [Create the file `/etc/systemd/system/suspend-sedation.service`](#orgf4b1995)
        2.  [Enable it with](#orgc72edf6)
    3.  [Customizing `suspend-then-hibernate`](#org04f1635)
        1.  [Tests for preparing version with hibernating only if battery is low and laptop is not on ac power](#orgca950ad)



<a id="orga4aaf3d"></a>

# TODO Hibernation on Debian without swap partition


<a id="org73dd61c"></a>

## Enabling hibernation on Debian (bookworm-testing-trixie)

I followed the instruction found here:
<https://wiki.debian.org/Hibernation/Hibernate_Without_Swap_Partition>


<a id="org879fc3c"></a>

### Create swapfile and configure it

    fallocate -l 64GiB /media/mb/arch/swapfile

    mkswap /media/mb/arch/swapfile
    chmod 600 /media/mb/arch/swapfile

    sudo chmod 600 /media/mb/arch/swapfile

Then I added:

    /media/mb/arch/swapfile   swap    swap    defaults        0       0 

to my `/etc/fstab`.

Then I stopped the kernel from using the swap file for swapping:

    sudo sysctl -w vm.swappiness=1 

Activated the swap file:

    sudo swapon /media/mb/arch/swapfile


<a id="org7dcefda"></a>

### Update grub and initramfs

1.  get UUID of the partition storing swapfile

        findmnt /media/mb/arch -o UUID -n

2.  ... and offset of the file

        sudo filefrag -v /media/mb/arch/swapfile|awk 'NR==4{gsub(/\./,"");print $4;}'

3.  now put those in `/etc/default/grub`

        GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=xxxx resume_offset=yyyyy"
    
    which in my case was:
    
        GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=b3dd82eb-4174-4ba5-a557-8972bafc04ba resume_offset=135047168"

4.  put UUID in `/etc/initramfs-tools/conf.d/resume`

    Append line
    
        RESUME=UUID=b3dd82eb-4174-4ba5-a557-8972bafc04ba

5.  regenerate both grub config and initramfs

        sudo update-grub
        sudo update-initramfs -k all -u


<a id="orgfc00f4f"></a>

### Test hibernation straight away

    systemctl hibernate

... it's working!


<a id="org0e7cc2f"></a>

## Enabling `suspend-then-hibernate`

I followed the instructions here:
<https://wiki.debian.org/SystemdSuspendSedation>


<a id="orgf4b1995"></a>

### Create the file `/etc/systemd/system/suspend-sedation.service`

with the following content (I did extended the suspend-time from 5 minutes (300) to
30 minutes (1800 in line `Environment="ALARM_SEC=1800"`):

3600 = 1h
7200 = 2h

    # ## MB note: 
    # ## file created in order to enable suspend-then-hibernate
    # ## according to https://wiki.debian.org/SystemdSuspendSedation
    
    # /etc/systemd/system/suspend-sedation.service
    [Unit]
    Description=Hibernate after suspend
    Documentation=https://bbs.archlinux.org/viewtopic.php?pid=1420279#p1420279
    Documentation=https://bbs.archlinux.org/viewtopic.php?pid=1574125#p1574125
    Documentation=https://wiki.archlinux.org/index.php/Power_management
    Documentation=http://forums.debian.net/viewtopic.php?f=5&t=129088
    Documentation=https://wiki.debian.org/SystemdSuspendSedation
    Conflicts=hibernate.target hybrid-sleep.target
    Before=sleep.target
    StopWhenUnneeded=true
    
    [Service]
    Type=oneshot
    RemainAfterExit=yes
    # 1800"
    Environment="ALARM_SEC=1800" 
    Environment="WAKEALARM=/sys/class/rtc/rtc0/wakealarm"
    
    ExecStart=/usr/sbin/rtcwake --seconds $ALARM_SEC --auto --mode no
    ExecStop=/bin/sh -c '\
    ALARM=$(cat $WAKEALARM); \
    NOW=$(date +%%s); \
    if [ -z "$ALARM" ] || [ "$NOW" -ge "$ALARM" ]; then \
    
      if [ $(cat /sys/class/power_supply/AC/online) == '0' ]; then
        echo 'On battery'
    
        if [ $(cat /sys/class/power_supply/BAT0/capacity) -lt 50 ]; then      
          echo 'Battery less than 50%'
          # perform hibernation
          echo "suspend-sedation: Woke up - no alarm set. Hibernating..."; \
          systemctl hibernate; \
        else
          # put it to sleep once again
          systemctl suspend; \      
        fi
    
      else
        echo 'On AC power'
        systemctl suspend; \
      fi   
    
    else \
      echo "suspend-sedation: Woke up before alarm - normal wakeup."; \
      /usr/sbin/rtcwake --auto --mode disable; \
    fi \
    '
    
    [Install]
    WantedBy=sleep.target

1.  New version that performs hibernation from suspension only if laptop is **not** on battery and has less than 50% of battery

    Basing on this:
    <https://askubuntu.com/questions/75886/how-do-i-set-the-computer-to-suspend-when-battery-is-critically-low>
    
        # ## MB note: 
        # ## file created in order to enable suspend-then-hibernate
        # ## according to https://wiki.debian.org/SystemdSuspendSedation
        
        # /etc/systemd/system/suspend-sedation.service
        [Unit]
        Description=Hibernate after suspend
        Documentation=https://bbs.archlinux.org/viewtopic.php?pid=1420279#p1420279
        Documentation=https://bbs.archlinux.org/viewtopic.php?pid=1574125#p1574125
        Documentation=https://wiki.archlinux.org/index.php/Power_management
        Documentation=http://forums.debian.net/viewtopic.php?f=5&t=129088
        Documentation=https://wiki.debian.org/SystemdSuspendSedation
        Conflicts=hibernate.target hybrid-sleep.target
        Before=sleep.target
        StopWhenUnneeded=true
        
        [Service]
        Type=oneshot
        RemainAfterExit=yes
        # 1800"
        Environment="ALARM_SEC=1800" 
        Environment="WAKEALARM=/sys/class/rtc/rtc0/wakealarm"
        
        ExecStart=/usr/sbin/rtcwake --seconds $ALARM_SEC --auto --mode no
        ExecStop=/bin/sh -c '\
        ALARM=$(cat $WAKEALARM); \
        NOW=$(date +%%s); \
        if [ -z "$ALARM" ] || [ "$NOW" -ge "$ALARM" ]; then \
        
          if [ $(cat /sys/class/power_supply/AC/online) == '0' ]; then
            echo 'On battery'
        
            if [ $(cat /sys/class/power_supply/BAT0/capacity) -lt 50 ]; then      
              echo 'Battery less than 50%'
              # perform hibernation
              echo "suspend-sedation: Woke up - no alarm set. Hibernating..."; \
              systemctl hibernate; \
            else
              # put it to sleep once again
              systemctl suspend; \
            fi
        
          else
            # echo 'On AC power'
            systemctl suspend; \
          fi   
        
        else \
          echo "suspend-sedation: Woke up before alarm - normal wakeup."; \
          /usr/sbin/rtcwake --auto --mode disable; \
        fi \
        '
        
        [Install]
        WantedBy=sleep.target
    
    Move the script to the proper directory:
    
        mv /tmp/suspend-sedation.service /etc/systemd/system/suspend-sedation.service

2.  DEPRECATED Original version

        # ## MB note: 
        # ## file created in order to enable suspend-then-hibernate
        # ## according to https://wiki.debian.org/SystemdSuspendSedation
        
        # /etc/systemd/system/suspend-sedation.service
        [Unit]
        Description=Hibernate after suspend
        Documentation=https://bbs.archlinux.org/viewtopic.php?pid=1420279#p1420279
        Documentation=https://bbs.archlinux.org/viewtopic.php?pid=1574125#p1574125
        Documentation=https://wiki.archlinux.org/index.php/Power_management
        Documentation=http://forums.debian.net/viewtopic.php?f=5&t=129088
        Documentation=https://wiki.debian.org/SystemdSuspendSedation
        Conflicts=hibernate.target hybrid-sleep.target
        Before=sleep.target
        StopWhenUnneeded=true
        
        [Service]
        Type=oneshot
        RemainAfterExit=yes
        Environment="ALARM_SEC=1800"
        Environment="WAKEALARM=/sys/class/rtc/rtc0/wakealarm"
        
        ExecStart=/usr/sbin/rtcwake --seconds $ALARM_SEC --auto --mode no
        ExecStop=/bin/sh -c '\
        ALARM=$(cat $WAKEALARM); \
        NOW=$(date +%%s); \
        if [ -z "$ALARM" ] || [ "$NOW" -ge "$ALARM" ]; then \
          echo "suspend-sedation: Woke up - no alarm set. Hibernating..."; \
          systemctl hibernate; \
        else \
          echo "suspend-sedation: Woke up before alarm - normal wakeup."; \
          /usr/sbin/rtcwake --auto --mode disable; \
        fi \
        '
        
        [Install]
        WantedBy=sleep.target


<a id="orgc72edf6"></a>

### Enable it with

    sudo systemctl enable suspend-sedation


<a id="org04f1635"></a>

## Customizing `suspend-then-hibernate`


<a id="orgca950ad"></a>

### Tests for preparing version with hibernating only if battery is low and laptop is not on ac power

      #!/bin/sh
      cat /sys/class/power_supply/AC/online
      cat /sys/class/power_supply/BAT0/capacity
    
    # if [ $(cat /sys/class/power_supply/AC/online) == '0' ]; then
    #     echo 'On battery'
    
    #     if [ $(cat /sys/class/power_supply/BAT0/capacity) -lt 50 ]; then      
    #       echo 'Battery less than 50%'
    #       # perform hibernation
    #     fi
    # else
    #     echo 'On AC power'
    # fi 

