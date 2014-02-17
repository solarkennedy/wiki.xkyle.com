### Example File

    text
    install 
    url --url http://.../CentOS/5.2/os/x86_64

    lang en_US.UTF-8
    langsupport --default=en_US.UTF-8
    keyboard us

    rootpw --iscrypted $1$......    # change this
    firewall --enabled --port=22:tcp
    authconfig --enableshadow --enablemd5
    selinux --disabled
    timezone --utc America/Denver
    bootloader --location=mbr --driveorder=sda

    reboot

    %packages
    -@ X Window System
    -@ GNOME Desktop Environment
    -@ Graphical Internet
    -@ Sound and Video
    -@dialup
    -@editors
    -@text-internet
    -avahi
    -cups
    -bluez-gnome
    -bluez-utils
    -wpa-supplicant
    -gtk2
    -NetworkManager

    #%post
    # Post install script here, gets run inside the target chrot

    %post
    /usr/bin/yum -y update >> /root/post_install.log 2>&1
    /sbin/chkconfig --del bluetooth
    /sbin/chkconfig --del cups

### Additional PXE Glue

To get this netbooted, put this in your pxe line: LABEL centos KERNEL
centos/vmlinuz APPEND initrd=centos/initrd.img text
ks=<http://wherethiskickstartis.cfg>

References
----------

-   [<http://wiki.centos.org/TipsAndTricks/KickStart>](http://wiki.centos.org/TipsAndTricks/KickStart)
-   [<http://www.centos.org/docs/5/html/5.2/Installation_Guide/s1-kickstart2-howuse.html>](http://www.centos.org/docs/5/html/5.2/Installation_Guide/s1-kickstart2-howuse.html)

<Category:Linux> <Category:Kickstart> <Category:PXE>
