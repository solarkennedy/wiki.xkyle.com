### Installing Debian to the USB drive

#### Configure Uboot

`setenv mainlineLinux yes`\
`setenv arcNumber 2097`\
`saveenv`\
`reset`

#### Grab the images and put it on your tftp server:

`cd /srv/tftp/`\
`wget `[`http://people.debian.org/~tbm/lenny/marvell/sheevaplug/uImage`](http://people.debian.org/~tbm/lenny/marvell/sheevaplug/uImage)\
`wget `[`http://people.debian.org/~tbm/lenny/marvell/sheevaplug/uInitrd`](http://people.debian.org/~tbm/lenny/marvell/sheevaplug/uInitrd)

#### Grab the init and kernel from the tftp server:

`setenv serverip 192.168.3.33`\
`setenv ipaddr 192.168.3.32`\
`tftpboot 0x01100000 uInitrd`\
`tftpboot 0x00800000 uImage`

#### Boot it!

`setenv bootargs console=ttyS0,115200 base-installer/initramfs-tools/driver-policy=most mirror/suite=stable apt-setup/local0/repository="`[`http://people.debian.org/~tbm/orion`](http://people.debian.org/~tbm/orion)` lenny main" apt-setup/local0/key=`[`http://people.debian.org/~tbm/orion/68FD549F`](http://people.debian.org/~tbm/orion/68FD549F)\
`bootm 0x00800000 0x01100000`

### Create your PPC/boot images

First after following the install, grab your kernel and initrd off of
your usb stick and stick them back on your tftp server. You will need
the uboot-mkimage tool. (sudo apt-get install uboot-mkimage)

    mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n "Debian Kernel" -d vmlinuz-2.6.32-2-kirkwood lenny-kernel-ppc 
    mkimage -A arm -O linux -T ramdisk -C gzip -a 0x0000000 -e 0x0000000 -n "Debian Ramdisk" -d initrd.img-2.6.32-2-kirkwood lenny-initrd-ppc

### Boot it for the first time to test

    setenv bootargs console=ttyS0,115200
    tftp 0x2000000 lenny-kernel-ppc
    tftp 0x2200000 lenny-initrd-ppc
    bootm 0x2000000 0x2200000

### Making the Install Permenant

If that all worked well, go ahead and reboot, then lets write that
permantly to flash:

    tftp 0x2000000 lenny-kernel-ppc
    nand erase 0x100000 0x200000
    nand write 0x2000000 0x100000 0x200000

    tftp 0x2200000 lenny-initrd-ppc
    nand erase 0x300000 0x500000
    nand write 0x2200000 0x300000 0x500000

    setenv bootargs console=ttyS0,115200
    setenv bootcmd 'nand read.e 0x2000000 0x100000 0x200000; nand read.e 0x2200000 0x300000 0x500000 ; bootm 0x2000000 0x2200000'
    saveenv
    reset

After that it should boot automatically to your usb stick

[Category:Plug Computers](Category:Plug Computers "wikilink")
