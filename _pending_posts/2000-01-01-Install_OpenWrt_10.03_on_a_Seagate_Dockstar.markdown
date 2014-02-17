---
categories:
 - OpenWrt
---
### Overview

So you want to put OpenWrt on a Pogoplug V2 (Pink)? Good Choice! It is
hard, but worth it. These instructions also work for the [Seagate
Dockstar](Seagate Dockstar "wikilink")

The Basic Procedure is this:

1.  Boot the Pogoplug into a basic debian rescue environment
2.  Format the rootfs mtd partition
3.  mkfs, mount, and untar the openwrt rootfs onto it
4.  Reboot to the bootloader, install the kernel uImage
5.  Save your Environment
6.  Boot it

For reference, your nand partitions look like this: dev: size erasesize
name mtd0: 00100000 00020000 "u-boot" mtd1: 00400000 00020000 "uImage"
mtd2: 07b00000 00020000 "rootfs"

### Tftp Prep Work

First on the server, Prep the tftp stuff: (Adjust the location of your
tftp root directory as needed)

    cd /var/lib/tftpboot/
    wget http://downloads.openwrt.org/backfire/10.03.1/kirkwood/openwrt-kirkwood-uImage
    wget http://download.xkyle.com/other/openwrt-kirkwood-uImage-ramroot

### Put the Root filesystem on the nand

First set the right environment variables in Uboot via the console:
(adjust your tftp server ip and ipaddr as needed)

    setenv mainlineLinux yes
    setenv arcNumber 2097
    setenv serverip 192.168.3.33
    setenv ipaddr 192.168.3.32
    setenv bootargs console=ttyS0,115200
    saveenv
    reset

Now we are going to tftp over the ram based openwrt stuff:

    tftp 0x2000000 openwrt-kirkwood-uImage-ramroot
    bootm 0x2000000

### In the Openwrt Ram Environment

Once you are at a shell on the pogoplug, you are free to lay the
groundwork for openwrt. The udhcpc in the beginning is to grab the
image, by default openwrt is set to a static ip.

    udhcpc -i br-lan 
    cat /proc/partitions
    mkdir /target
    mtd erase mtd2
    mount /dev/mtdblock2 /target -t jffs2
    cd /target
    wget http://downloads.openwrt.org/backfire/10.03.1/kirkwood/openwrt-kirkwood-rootfs.tar.gz
    tar xzvpf openwrt-kirkwood-rootfs.tar.gz
    rm openwrt-kirkwood-rootfs.tar.gz
    cd ..
    umount /target

Now you can restart the pogoplug gracefully, and get back to the uboot
prompt for more

### Installing the Openwrt Kernel

Now tftp the uImage over and flash:

    setenv serverip 192.168.3.33
    setenv ipaddr 192.168.3.32
    tftp 0x2000000 openwrt-kirkwood-uImage
    nand erase 0x100000 0x100000
    nand write 0x2000000 0x100000 0x100000
    setenv bootargs console=ttyS0,115200 root=/dev/mtdblock2 rootfstype=jffs2 panic=10
    setenv bootcmd 'nand read.e 0x2000000 0x100000 0x100000; bootm 0x2000000'
    setenv mainlineLinux yes
    setenv arcNumber 2097
    saveenv
    reset

### Post Install Stuff (Optional)

You have room to grow on your openwrt, I recommend these packages to
make you feel more comfortable:

    opkg update
    opkg install bash bash-completion e2fsprogs vim-full vim-runtime avahi-daemon openvpn kmod-leds-gpio kmod-usb2
    /etc/init.d/avahi-daemon enable
    sed -i 's/ash/bash/' /etc/inittab
    sed -i 's/ash/bash/' /etc/passwd
    opkg install procps --force-overwrite
    rm /bin/ps
    ln -s /usr/bin/ps /bin/ps

If you need some swap, this can get you started. Remember how swap
works, it can't really work on a jffs2 partition because it is
non-contiguous. (assuming a swap file). Dedicated partitions would work.

    dd if=/dev/zero of=/mnt/backups/swap.file bs=1024 count=100000
    mkswap /mnt/backups/swap.file
    opkg install block-hotplug block-mount

Your /etc/config/fstab needs this:

    config mount
            option target   /mnt/backups
            option device   /dev/sda1
            option fstype   ext3
            option options  rw,sync
            option enabled  1
            option enabled_fsck 0

    config swap
            option device   /mnt/backups/swap.file
            option enabled  1

Computers](Category:Plug Computers "wikilink")
