
# Table of Contents

1.  [Docker installation on debian bookworm](#org9379e5c)
    1.  [Problem description](#org4f363f6)
    2.  [Solution](#org0b6852e)
    3.  [First approach (still errors)](#orgbba0e78)
    4.  [(???) Now](#org59f4083)



<a id="org9379e5c"></a>

# TODO Docker installation on debian bookworm


<a id="org4f363f6"></a>

## Problem description

On debian bookworm, when running the command:

    docker compose

I obtain:

    docker: 'compose' is not a docker command.

It seems that it's the middle of transition between docker compose version 1
and docker compose version 2.

<https://itslinuxfoss.com/fix-docker-compose-command-not-found-error/>


<a id="org0b6852e"></a>

## Solution

    sudo apt install docker-compose

Note that now you need to run docker with `sudo` to have it working
properly.

    sudo docker compose up

Without `sudo` you'll obtain an error.


<a id="orgbba0e78"></a>

## DEPRECATED First approach (still errors)

    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    mkdir -p $DOCKER_CONFIG/cli-plugins

    curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
    chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

Now running the command 

    docker compose version

returns the output

    Docker Compose version v2.6.1


<a id="org59f4083"></a>

## TODO (???) Now

-   add `$DOCKER_CONFIG` to .bashrc ?? to make it working always for a user?

