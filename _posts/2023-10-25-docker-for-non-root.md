
# Table of Contents

1.  [Docker for non-root](#org9832651)
    1.  [Docker for non-root](#org98c8bef)
        1.  [Creating](#org49c55c3)
        2.  [Deleting](#org7c0883c)
    2.  [Useful links:](#org0e88fcc)



<a id="org9832651"></a>

# TODO Docker for non-root


<a id="org98c8bef"></a>

## Docker for non-root


<a id="org49c55c3"></a>

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


<a id="org7c0883c"></a>

### Deleting

    username=jakmat
    userdel $username
    # or delete user and its home directory and mail directory
    userdel -r $username


<a id="org0e88fcc"></a>

## Useful links:

-   <https://cloudyuga.guru/hands_on_lab/docker-as-non-root-user>

