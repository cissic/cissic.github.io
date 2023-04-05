---
author: cissic
date: 2023-02-25 Sat
tags: 'vagrant virtualbox debian bullseye'
title: 'Vagrant and Virtualbox (6.1?) and Debian Bullseye'
---


# Vagrant and Virtualbox (6.1?) and Debian Bullseye


## Problem description

There is a problem when using Vagrant and VirtualBox on Debian Bullseye:
<https://superuser.com/questions/1769582/vagrant-virtualbox-on-debian-bullseye>


## Prerequisites

You might need perform full uninstall of previous installations of `virtualbox`
(if you had it installed) before going on with installation process.
How to do it properly is described [here](https://askubuntu.com/a/957281) and it comes down to running:

    sudo apt update && sudo apt install -f
    sudo apt remove --purge *virtualbox*


## Solution

To circumvent it you need to install Vagrant and VirtualBox manually, not from
Debian's repository (BTW. installing from Debian's repository is impossible
since while installing `vagrant`
 package manager automatically removes `virtualbox` package and vice
versa!).

The script that is tested to install both programs and having them working
properly is given below:

    # Install requirements 
    sudo apt update && sudo apt install -y build-essential gcc make perl dkms
    
    # Install VirtualBox
    mkdir ~/tempInstallationDir/
    wget https://download.virtualbox.org/virtualbox/6.1.42/virtualbox-6.1_6.1.42-155177~Debian~bullseye_amd64.deb -O ~/tempInstallationDir/virtualbox-6.1_6.1.42-155177~Debian~bullseye_amd64.deb
    sudo dpkg -i ~/tempInstallationDir/virtualbox-6.1_6.1.42-155177~Debian~bullseye_amd64.deb
    sudo apt install -f -y
    sudo /sbin/vboxconfig
    rm -rf ~/tempInstallationDir/
    
    
    # Install Vagrant
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install -y vagrant
    
    # Setup Vagrant project
    mkdir -p ~/vagrant_getting_started
    cd ~/vagrant_getting_started
    
    # Create Vagrantfile and modify it
    vagrant init hashicorp/bionic64
    echo "Vagrant.configure(\"2\") do |config|" > ~/vagrant_getting_started/Vagrantfile
    echo "  config.vm.box = \"hashicorp/bionic64\"" >> ~/vagrant_getting_started/Vagrantfile
    echo "  config.vm.synced_folder \"~/data\", \"/vagrant_data\"" >> ~/vagrant_getting_started/Vagrantfile
    echo "end" >> ~/vagrant_getting_started/Vagrantfile
    
    # Add box and start vagrant 
    vagrant box add --provider=virtualbox hashicorp/bionic64
    mkdir -p ~/data
    vagrant up --provider=virtualbox
    
    echo 
    echo "To log into vm run:"
    echo
    echo "    cd ~/vagrant_getting_started && vagrant ssh"
    echo
    echo "To stop vagratn run:"
    echo
    echo "    cd ~/vagrant_getting_started && vagrant destroy"
    echo


## Links that can be useful

-   <https://developer.hashicorp.com/vagrant/docs/providers/virtualbox>
-   <https://www.virtualbox.org/wiki/Linux_Downloads>
-   <https://askubuntu.com/questions/900794/virtualbox-rtr3initex-failed-with-rc-1912-rc-1912>- <https://linuxopsys.com/topics/install-virtualbox-on-debian?utm_content=cmp-true>
-   <https://stackoverflow.com/questions/66630839/error-when-i-am-trying-to-install-virtualbox-6-1secure-boot-on>
-   <https://dev-pages.info/ubuntu-how-to-fix-virtual-box-vboxdrv-error/>

