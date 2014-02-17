---
categories:
 - OpenWrt
---
### Get it

This download will probably change and is architecture specific: wget
<http://downloads.openwrt.org/backfire/10.03/brcm47xx/OpenWrt-ImageBuilder-brcm47xx-for-Linux-i686.tar.bz2>
tar xjf OpenWrt-ImageBuilder-brcm47xx-for-Linux-i686.tar.bz2 cd
OpenWrt-ImageBuilder-brcm47xx-for-Linux-i686

### Make a Custom Image

Now you can make a custom image with the packages you want, plus some
extra files. You can preload the image with your own config, and
automate it.

Here is what I run (preload with openvpn and ipv6 capability): make
image PACKAGES="openvpn radvd kmod-b43 kmod-ipv6 kmod-sit ip -uhttpd"
FILES="files/"

The files in the "files/" directory are the files that will be
incorporated into the final image. Here are some [example
files](OpenWrt Example Files "wikilink").

### Burn It

Your take your file and scp to it: scp
bin/brcm47xx/openwrt-brcm47xx-squashfs.trx root@192.168.1.1:/tmp/

Now Burn it (on your router): mtd -r write
/tmp/openwrt-brcm47xx-squashfs.trx linux

### See Also

-   [Comcast IPv6 on OpenWrt](Comcast IPv6 on OpenWrt "wikilink")
-   [OpenWrt Example Files](OpenWrt Example Files "wikilink")

### References

<http://wiki.openwrt.org/doc/howto/obtain.firmware.generate>

