
# Table of Contents

1.  [High CPU usage by KactivityManagerd and plasmashell](#org34f1746)
    1.  [Problem description](#orgd0134ce)



<a id="org34f1746"></a>

# High CPU usage by KactivityManagerd and plasmashell


<a id="orgd0134ce"></a>

## Problem description

I had a high CPU usage by Kactivitymanagerd and plasmashell.

After performing the actions described here:
<https://forum.manjaro.org/t/high-cpu-usage-from-plasmashell-kactivitymanagerd/114305>

which came down to :

    cp ~/.local/share/kactivitymanagerd/resources/ ~/.local/share/kactivitymanagerd/resourcesBKP
    rm -rf /home/.local/share/kactivitymanagerd/resources/

the problem stopped.

After some time you may of course delete backupped directory:

    rm -rf /home/.local/share/kactivitymanagerd/resourcesBKP/

