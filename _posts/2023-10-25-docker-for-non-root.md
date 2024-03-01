
# Table of Contents

<<<<<<< HEAD
1.  [Docker for non-root](#org9da4d90)
    1.  [Docker for non-root](#orgb9e11ba)
        1.  [Creating](#org5aae265)
        2.  [Deleting](#orgbaa3a04)
    2.  [Useful links:](#org882f329)



<a id="org9da4d90"></a>
=======
1.  [Docker for non-root](#orgb6e7748)
    1.  [Docker for non-root](#orge077f97)
        1.  [Creating](#org17b5072)
        2.  [Deleting](#orgffab078)
    2.  [Useful links:](#org04f0b46)



<a id="orgb6e7748"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

# TODO Docker for non-root


<<<<<<< HEAD
<a id="orgb9e11ba"></a>
=======
<a id="orge077f97"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

## Docker for non-root


<<<<<<< HEAD
<a id="org5aae265"></a>
=======
<a id="org17b5072"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

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


<<<<<<< HEAD
<a id="orgbaa3a04"></a>
=======
<a id="orgffab078"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

### Deleting

    username=jakmat
    userdel $username
    # or delete user and its home directory and mail directory
    userdel -r $username


<<<<<<< HEAD
<a id="org882f329"></a>
=======
<a id="org04f0b46"></a>
>>>>>>> 515ffa2caf73a47afcb4c46b239bfea6e4090e3a

## Useful links:

-   <https://cloudyuga.guru/hands_on_lab/docker-as-non-root-user>

