---
categories:
 - PXE
 - OpenWrt
---
### Prerequisites

-   Should only need <OpenWrt> stock packages. (dnsmasq)
-   Highly recommend [OpenWrt Root
    Overlay](OpenWrt Root Overlay "wikilink") for space to put your
    netboot stuff

### DHCP Part

`uci set dhcp.@dnsmasq[0].dhcp_boot=pxelinux.0,,192.168.0.254`\
`uci commit`\
`#Then restart it:`\
`/etc/init.d/dnsmasq restart`
[`dnsmasq`](dnsmasq "wikilink")` also does this weird thing that throws off pxe clients. I had to put this into /etc/init.d/dnsmasq to get it to stop:`\
`echo 'dhcp-no-override' >> $CONFIGFILE`

### TFTP Part

`uci set dhcp.@dnsmasq[0].enable_tftp=1`\
`uci set dhcp.@dnsmasq[0].tftp_root=/mnt/tftpboot`\
`uci commit`\
`#Then restart it:`\
`/etc/init.d/dnsmasq restart`

### pxelinux.0

`cd /mnt/tftpboot`\
`wget `[`http://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-5.00.tar.gz`](http://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-5.00.tar.gz)\
`tar xzf syslinux-5.00.tar.gz syslinux-5.00/core/pxelinux.0`\
`mv syslinux-5.00/core/pxelinux.0 .`\
`rm -rf syslinux-5*`

### See Also

[Building A PXE Server](Building A PXE Server "wikilink")

### References

-   <http://wiki.openwrt.org/doc/uci/dhcp>

