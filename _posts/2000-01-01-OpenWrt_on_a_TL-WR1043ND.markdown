---
categories:
 - OpenWrt
---
### Initial OpenWrt Install

Find a download for this profile with the word "factory" in it.
Something like openwrt-ar71xx-tl-wr1043nd-v1-squashfs-factory.bin

Use the factory gui to install it, it will work.

### Custom OpenWrt Image

Here is how I use the [OpenWrt
ImageBuilder](OpenWrt ImageBuilder "wikilink") to make a smaller image
than the stock download, which leaves more room for installable goodies
and drops the web gui.

`make image PROFILE=TLWR1043NDV1 PACKAGES="openvpn radvd kmod-b43 kmod-ipv6 kmod-sit ip -uhttpd -kmod-ppp " FILES="files/"`

