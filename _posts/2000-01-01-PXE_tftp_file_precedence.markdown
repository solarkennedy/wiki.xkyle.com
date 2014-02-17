---
categories:
 - PXE
---
### Order

Next, it will search for the config file using its own IP address in
upper case hexadecimal, e.g. 192.0.2.91 -\> C000025B (you can use the
included progam gethostip to compute the hexadecimal IP address for any
host). If that file is not found, it will remove one hex digit and try
again. Ultimately, it will try looking for a file named default (in
lower case). As an example, if the boot file name is
/mybootdir/pxelinux.0, the Ethernet MAC address is \`88:99:AA:BB:CC:DD\`
and the IP address 192.0.2.91, it will try following files (in that
order):

           /mybootdir/pxelinux.cfg/01-88-99-aa-bb-cc-dd
           /mybootdir/pxelinux.cfg/C000025B
           /mybootdir/pxelinux.cfg/C000025
           /mybootdir/pxelinux.cfg/C00002
           /mybootdir/pxelinux.cfg/C0000
           /mybootdir/pxelinux.cfg/C000
           /mybootdir/pxelinux.cfg/C00
           /mybootdir/pxelinux.cfg/C0
           /mybootdir/pxelinux.cfg/C
           /mybootdir/pxelinux.cfg/default

### HEX Converter

`printf '%02X' ${IP_ADDR//./ }`

#### References

-   <http://www.syslinux.org/wiki/index.php/PXELINUX>

