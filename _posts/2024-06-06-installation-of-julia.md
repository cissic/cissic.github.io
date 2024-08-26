
# Table of Contents

1.  [installation of julia](#org43a7f17)
    1.  [How to uninstall?](#orgf44552f)



<a id="org43a7f17"></a>

# TODO installation of julia

According to <https://julialang.org/downloads/>
the preffered way of installing `julia` is **not** via the system
package managers but by downloading the official binaries.
All you need to do is:

    curl -fsSL https://install.julialang.org | sh

which results in:

    info: downloading installer
    Welcome to Julia!
    
    This will download and install the official Julia Language distribution
    and its version manager Juliaup.
    
    Juliaup will be installed into the Juliaup home directory, located at:
    
      /home/mb/.juliaup
    
    The julia, juliaup and other commands will be added to
    Juliaup's bin directory, located at:
    
      /home/mb/.juliaup/bin
    
    This path will then be added to your PATH environment variable by
    modifying the profile files located at:
    
      /home/mb/.bashrc
      /home/mb/.profile
    
    Julia will look for a new version of Juliaup itself every 1440 minutes when you start julia.
    
    You can uninstall at any time with juliaup self uninstall and these
    changes will be reverted.
    
    ✔ Do you want to install with these default configuration choices? · Proceed with installation
    
    Now installing Juliaup
    Installing Julia 1.10.4+0.x64.linux.gnu
    Configured the default Julia version to be 'release'.
    Julia was successfully installed on your system.
    
    Depending on which shell you are using, run one of the following
    commands to reload the PATH environment variable:
    
      . /home/mb/.bashrc
      . /home/mb/.profile

Once installed `julia` will be available via the command line interface.


<a id="orgf44552f"></a>

## TODO How to uninstall?

I haven't checked it yet...

