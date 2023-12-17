
# Table of Contents

1.  [Docker for non-root](#orgb6e7748)
    1.  [Docker for non-root](#orge077f97)
        1.  [Creating](#org17b5072)
        2.  [Deleting](#orgffab078)
    2.  [Useful links:](#org04f0b46)



<a id="orgb6e7748"></a>

# TODO Docker for non-root


<a id="orge077f97"></a>

## Docker for non-root


<a id="org17b5072"></a>

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


<a id="orgffab078"></a>

### Deleting

    username=jakmat
    userdel $username
    # or delete user and its home directory and mail directory
    userdel -r $username


<a id="org04f0b46"></a>

## Useful links:

-   <https://cloudyuga.guru/hands_on_lab/docker-as-non-root-user>

