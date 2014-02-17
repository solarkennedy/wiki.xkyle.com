---
categories:
 - OpenWrt
---
Inside of the files directory, make a directory structure as it will
appear on the router. Like this:

`kyle@server:~/OpenWrt-ImageBuilder-brcm47xx-for-Linux-i686/files$ find`

    .
    ./etc
    ./etc/dropbear
    ./etc/dropbear/dropbear_rsa_host_key
    ./etc/dropbear/dropbear_dss_host_key
    ./etc/dropbear/authorized_keys
    ./etc/banner
    ./etc/init.d
    ./etc/init.d/comcast-6rd
    ./etc/config
    ./etc/config/wireless
    ./etc/config/openvpn
    ./etc/config/network
    ./etc/config/radvd
    ./etc/config/system
    ./etc/passwd
    ./etc/openvpn
    ./etc/openvpn/home.xkyle.com.key
    ./etc/openvpn/ca.crt
    ./etc/openvpn/openvpn.conf
    ./etc/openvpn/home.xkyle.com.crt
    ./etc/rc.d
    ./etc/rc.d/K88comcast-6rd
    ./etc/rc.d/S42comcast-6rd

See Also:

-   [OpenWrt ImageBuilder](OpenWrt ImageBuilder "wikilink")
-   [Comcast IPv6 on OpenWrt](Comcast IPv6 on OpenWrt "wikilink")

