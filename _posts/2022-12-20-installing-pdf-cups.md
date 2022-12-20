

# Installing pdf printer in cups


## Problem and solution

How to install pdf printer in cups in Debian Bullseye.

Based on: <https://gist.github.com/aweijnitz/c9ac7a18880225f12bf0>

    
    sudo apt install cups -y
    sudo apt install printer-driver-cups-pdf -y
    
    sudo lpadmin -p cups-pdf -v cups-pdf:/ -E -P /usr/share/ppd/cups-pdf/CUPS-PDF_opt.ppd

