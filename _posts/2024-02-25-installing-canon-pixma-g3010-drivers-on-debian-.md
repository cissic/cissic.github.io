
# Table of Contents

1.  [installing canon pixma g3010 drivers on debian](#orgd1e0f27)
    1.  [Problem description](#orgdf12437)
        1.  [Wireless connection configuration](#orgfe49676)
        2.  [Installing USB Printer](#org8610fdd)
    2.  [Accessing Canon pixma G3010 via Android:](#org6db36fa)
        1.  [Canon Print App or (just) ...](#orge62af3f)
        2.  [... Canon Print Service](#orgf65eaa6)



<a id="orgd1e0f27"></a>

# TODO installing canon pixma g3010 drivers on debian


<a id="orgdf12437"></a>

## Problem description

Canon G3010 as Wifi LAN printer used to work on
my earlier Debian however I was not able to configure it
in Debian trixie/testing.

In the end I installed local drivers with the use of
archives downloaded from here:

-   <https://ijsetupcanon.com/canon-pixma-g3000-driver-download/>

(5.30)
or here 

-   <https://canon-print.com/canon-pixma-g3010-series-drivers-windows-linux/> (5.60)

I keep them in <file:///home/mb/SEarch/Linux/Debian Drivers/Canon G3010 Pixma/>.


<a id="orgfe49676"></a>

### Wireless connection configuration

According to this page
<https://www.cups.org/doc/network.html>
I used the following command to obtain printer's URI with  so-called
`Bonjour` protocol.

    sudo lpinfo --include-schemes dnssd -v

I copied string 
`dnssd://Canon%20G3010%20series._ipp._tcp.local/?uuid=00000000-0000-1000-8000-00183b1605c2`
and pasted it as printers address choosing as a driver `Canon G3010 series, driverless, cups-filters 1.28.17`.

Wireless printer started responding...


<a id="org8610fdd"></a>

### Installing USB Printer

To configure printer to work as usb printer I needed to:

-   install canon proprietary drivers

    sudo apt install cups-backend-bjnp 

-   Make: then I was able to find Canon in manufacturers list in cups
    "Add printer" menu (it was impossible earlier)

-   Model: I chose `Canon PIZMA G3010 - CUPS+Gutenprint v.5.3.4 (en)`


<a id="org6db36fa"></a>

## Accessing Canon pixma G3010 via Android:

<https://www.youtube.com/watch?v=eYj6Z1cLP8A>


<a id="orge62af3f"></a>

### Canon Print App or (just) ...


<a id="orgf65eaa6"></a>

### ... Canon Print Service

Settings -> Connections/Connected devices
-> Connection preferences -> Printing
-> Add Service -> Canon Print Service (Download from the store...)

