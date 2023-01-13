---
author: cissic
date: 2022-12-20 Tue
tags: 'pdf cups debian printer'
title: 'Installing pdf printer in cups'
---
---
author: cissic
date: 2022-12-20 Tue
tags: 'pdf cups debian printer'
title: 'Installing pdf printer in cups'
---


# Installing pdf printer in cups


## Problem and solution

How to install pdf printer in cups in Debian Bullseye.

Based on: <https://gist.github.com/aweijnitz/c9ac7a18880225f12bf0>

    
    sudo apt install cups -y
    sudo apt install printer-driver-cups-pdf -y
    
    sudo lpadmin -p cups-pdf -v cups-pdf:/ -E -P /usr/share/ppd/cups-pdf/CUPS-PDF_opt.ppd

