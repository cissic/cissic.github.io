
# Table of Contents

1.  [Docker for non-root](#org025e9dc)
    1.  [Docker for non-root](#orgb144511)
        1.  [Creating](#org5df0212)
        2.  [Deleting](#org07cbd9a)
    2.  [Useful links:](#org7fd0048)



<a id="org025e9dc"></a>

# TODO Docker for non-root


<a id="orgb144511"></a>

## Docker for non-root


<a id="org5df0212"></a>

### Creating

Create user account with his/her home directory content copied
from `/etc/skel` (`-m`) and default shell (`-s /usr/bin/bash`):

    
    username=mikdat
    sudo useradd -m -s /usr/bin/bash $username
    
    # set password for username
    sudo passwd $username
    
    # add user to a docker group
    sudo usermod -a -G docker $username
    
    # check the groups that user is assigned to
    sudo groups $username
    
    # change context to username and check if everything is ok on his/her side
    su - $username


<a id="org07cbd9a"></a>

### Deleting

    username=jakmat
    userdel $username
    # or delete user and its home directory and mail directory
    userdel -r $username


<a id="org7fd0048"></a>

## Useful links:

-   <https://cloudyuga.guru/hands_on_lab/docker-as-non-root-user>

