
# Table of Contents

1.  [How to setup different SSH identities for different github/gitlab accounts](#org7409093)
    1.  [Solution](#orge025963)
        1.  [Example](#orgfd5d7a5)



<a id="org7409093"></a>

# How to setup different SSH identities for different github/gitlab accounts


<a id="orge025963"></a>

## Solution

Solution can be found [here](https://gist.github.com/cissic/fc81bece710dded457d230837b2139e1).

After following the instructions from the link **remember** to clone the repository with the appropriate host name from `~/.ssh/config`!


<a id="orgfd5d7a5"></a>

### Example

Assuming that content of the ~/.ssh/config is:

    # First (default) github account
    Host github.com
        HostName github.com
        Preferredauthentications publickey
        IdentityFile ~/.ssh/identityA
    
    Host userB.github.com
        HostName github.com
        Preferredauthentications publickey
        IdentityFile ~/.ssh/identityB

if you want to clone repository as `userB` **do not** simply `git clone` the link copied with the use of GitHub interface i.e.:

    # (DON'T DO THAT unless you want to clone with your default identity): 
    # git clone git@github.com:userB/repository-name.git 

You need to edit host name which for this example means you need to add **userB.** to the hostname:

    git clone git@userB.github.com:userB/repository-name.git

Now when pushing to `repository-name` you will be identified with the proper credentials of userB.

