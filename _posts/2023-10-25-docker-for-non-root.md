
# Table of Contents

1.  [Docker for non-root](#org9da4d90)
    1.  [Docker for non-root](#orgb9e11ba)
        1.  [Creating](#org5aae265)
        2.  [Deleting](#orgbaa3a04)
    2.  [Useful links:](#org882f329)



<a id="org9da4d90"></a>

# TODO Docker for non-root


<a id="orgb9e11ba"></a>

## Docker for non-root


<a id="org5aae265"></a>

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


<a id="orgbaa3a04"></a>

### Deleting

    username=jakmat
    userdel $username
    # or delete user and its home directory and mail directory
    userdel -r $username


<a id="org882f329"></a>

## Useful links:

-   <https://cloudyuga.guru/hands_on_lab/docker-as-non-root-user>

