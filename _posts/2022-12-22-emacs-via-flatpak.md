

# Installing the newest emacs via flatpak


## Problem and solution

I wanted to use a new bibliography management system in emacs which seems to be working fine in Org 9.6 (there is no `org-assert-version` defined in my Org 9.3 in Emacs 27.1 installed from debian repo).

Instead of upgrading Org within Emacs I decided to give a try to a standalone Linux apps, and start working with it in anticipation of new debian release with proper version of Emacs/Org.

At the time of writing there is no AppImage for Emacs >= 28
([<https://github.com/probonopd/Emacs.AppImage/issues/19>]), so I decided to use other package system.

Basing on [<https://phoenixnap.com/kb/flatpak-vs-snap-vs-appimage#:~:text=Snaps%20and%20Flatpaks%20use%20the,to%20install%20and%20update%20applications>.] I decided to use snap since it's repositories are said to be 
bigger than flatpak repository. 

Another interesting discussion (including snap's emacs package author) can be found [here](https://www.reddit.com/r/emacs/comments/brzo17/emacs_in_a_snap/).

Information on span packages can be found [here](https://phoenixnap.com/kb/snap-packages#:~:text=Run%20Snaps%20via%20Terminal,snap%20and%20the%20hosts%20fontconfig.).

So following [<https://snapcraft.io/install/emacs/debian>] I installed 

    sudo apt update
    sudo apt install snapd -y
    sudo snap install core  # already installed
    sudo snap install emacs --classic  

In order to run application form the command line you need to write:

    snap run emacs

However, there still is the same error when launching the newest Emacs!
So I tried with `flatpak`.

    sudo apt install flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub org.gnu.emacs
    flatpak run org.gnu.emacs

None of this installations solved the problem with  `org-assert-version`.
So I uninstalled both of them and reinstalled my system Emacs once again.
(I also uninstalled `flatpak` and `snap`, previously uninstalling all packages installed by them).

Then I turned to this thread: 
<https://www.reddit.com/r/emacs/comments/zd3l7p/org_mode_elpa_intall_invalid_function/>
which is described in another post.

