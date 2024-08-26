---
author: cissic
date: 2022-12-20 Tue
tags: 'pdf cups debian printer'
title: 'Installing pdf printer in cups'
---


# (UPDATE: 2024-08-21) Installing pdf printer in cups


## Problem and solution


### Debian Bullseye

How to install pdf printer in cups in Debian Bullseye.

Based on: <https://gist.github.com/aweijnitz/c9ac7a18880225f12bf0>

    
    sudo apt install cups -y
    sudo apt install printer-driver-cups-pdf -y
    
    sudo lpadmin -p cups-pdf -v cups-pdf:/ -E -P /usr/share/ppd/cups-pdf/CUPS-PDF_opt.ppd


### Debian Trixie/Testing

<https://unix.stackexchange.com/questions/303860/cups-usr-lib-cups-backend-usb-no-such-file-or-directory-missing-deleted>

    sudo apt remove cups
    sudo apt install cups  
    sudo apt install printer-driver-gutenprint

