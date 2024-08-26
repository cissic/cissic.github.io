
# Table of Contents

1.  [Installing python package without answering questions](#org1a78f40)
    1.  [Problem description (and solution)](#orgeadd810)
    2.  [Solution](#orgcf13e63)



<a id="org1a78f40"></a>

# TODO Installing python package without answering questions


<a id="orgeadd810"></a>

## Problem description (and solution)

<https://askubuntu.com/questions/1274445/how-to-install-python-opencv-without-answering-the-quesitons>

<https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai>


<a id="orgcf13e63"></a>

## Solution

Add `ARG DEBIAN_FRONTEND=noninteractive` in Dockerfile 

    ARG DEBIAN_FRONTEND=noninteractive 
    RUN apt-get install --yes python3-matplotlib

