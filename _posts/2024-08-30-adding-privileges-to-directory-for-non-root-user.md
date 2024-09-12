
# Table of Contents

1.  [Adding privileges to directory for non-root user](#org4cfada4)
    1.  [Problem description](#org82a02bf)
        1.  [Install `acl` package](#orgc5f6c9d)
        2.  [Add privileges to `/var/lib/docker/`](#orge90f1e4)
        3.  [Add <span class="underline">recursively</span> privileges to `/var/lib/docker/volumes`](#orgd23358f)
        4.  [Inspect directory access control list](#org25a993a)
    2.  [Links](#org7ea0b41)



<a id="org4cfada4"></a>

# Adding privileges to directory for non-root user


<a id="org82a02bf"></a>

## Problem description

Let's imagine we want to give non-root user access to root directory.
Let it be `/var/lib/docker/volumes/`.

The easiest approach is as follows:


<a id="orgc5f6c9d"></a>

### Install `acl` package

    sudo apt install acl

With the commands from this package we may easily view and edit
privileges to files/directories


<a id="orge90f1e4"></a>

### Add privileges to `/var/lib/docker/`

By adding privileges only to `/var/lib/docker/volumes` we wouldn't
have access to it anyway because we would be blocked at
`/var/lib/docker/` level, so we need to give access to this directory.
Note that we do not use `-R` modifier because:

1.  we don't want user has access to all that is inside `docker/`
2.  with `-R` evaluating this command may take very looooong

    cd /var/lib/
    sudo setfacl -m u:USERNAME:rwx docker/


<a id="orgd23358f"></a>

### Add <span class="underline">recursively</span> privileges to `/var/lib/docker/volumes`

Now we do use  `-R` modifier:

    sudo setfacl -R -m u:USERNAME:rwx volumes/

Now we can...


<a id="org25a993a"></a>

### Inspect directory access control list

    getfacl /var/lib/docker/volumes/


<a id="org7ea0b41"></a>

## Links

<https://delinea.com/blog/linux-privilege-escalation>

