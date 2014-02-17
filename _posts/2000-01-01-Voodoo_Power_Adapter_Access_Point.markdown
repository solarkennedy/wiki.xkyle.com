---
categories:

---
Access Keys
-----------

The <Voodoo> Envy laptop comes with this power brick + wireless bridge
adapter. Normally to connect to it you would download some silly 64 bit
windows 7 driver, but really all the driver does is add a wireless
connection profile.

The access point itself has the following connection settings:

-   Channel 6 (mine is)
-   WPA2 + AES Encryption
-   Essid: "Voodoo Power Adapter"
-   Password: "ABinkie!"
-   No quotes obviously

All information extracted from the "Wireless Network Connection-Voodoo
Power Adapter.xml" file contained in the driver.

Teardown
--------

This thing was the tightest piece of plastic I've ever disassembled.
There are no screws, just really tight plastic. You will break it if you
take it apart. ![](Voodoo Power Adapter Inside.jpg "image")

#### Openwrt

Connect to the serial port and there is a minimal Kamakazie <Openwrt>!


    BusyBox v1.2.1 (2008.08.06-08:54+0000) Built-in shell (ash)
    Enter 'help' for a list of built-in commands.

      _______                     ________        __
     |       |.-----.-----.-----.|  |  |  |.----.|  |_
     |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
     |_______||   __|_____|__|__||________||__|  |____|
              |__| W I R E L E S S   F R E E D O M
     KAMIKAZE (bleeding edge, r0) -------------------
      * 10 oz Vodka       Shake well with ice and strain
      * 10 oz Triple sec  mixture into 10 shot glasses.
      * 10 oz lime juice  Salute!
     ---------------------------------------------------
    root@LINUX-AP:/# 

### Bootup


    Ethernet eth0: MAC address 00:30:ab:29:27:dd
    IP: 192.168.1.1/255.255.255.0, Gateway: 0.0.0.0
    Default server: 192.168.1.12

    RedBoot(tm) bootstrap and debug environment [ROMRAM]
    Non-certified release, version UNKNOWN - built 09:45:22, Mar 31 2008

    Copyright (C) 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.

    Board: ap51 
    RAM: 0x80000000-0x81000000, [0x8003fd50-0x80fe1000] available
    FLASH: 0xbfc00000 - 0xbfff0000, 64 blocks of 0x00010000 bytes each.
    == Executing boot script in 1.000 seconds - enter ^C to abort

    == Executing boot script in 1.000 seconds - enter ^C to abort
    RedBoot> fis load -l vmlinux.lzma
    Image loaded from 0x80041c00-0x8017d000
    RedBoot> go
    CPU revision is: 00019064
    Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
    Primary data cache 16kB 4-way, linesize 16 bytes.
    Linux version 2.4.25 (ronger@dnisw1) (gcc version 3.3.3) #2 Wed Aug 6 16:57:25 CST 2008
    Determined physical RAM map:
     memory: 01000000 @ 00000000 (usable)
    On node 0 totalpages: 4096
    zone(0): 4096 pages.
    zone(1): 0 pages.
    zone(2): 0 pages.
    Kernel command line: root=/dev/mtdblock2 console=ttyS0,9600
    Using 92.000 MHz high precision timer.
    Calibrating delay loop... 183.50 BogoMIPS
    Memory: 14508k/16384k available (1100k kernel code, 1876k reserved, 76k data, 64k init, 0k highmem)
    Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
    Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
    Mount cache hash table entries: 512 (order: 0, 4096 bytes)
    Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
    Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
    Checking for 'wait' instruction...  unavailable.
    POSIX conformance testing by UNIFIX
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    Starting kswapd
    devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
    devfs: boot_options: 0x1
    squashfs: version 3.0 (2006/03/15) Phillip Lougher
    pty: 256 Unix98 ptys configured
    Serial driver version 5.05c (2001-07-08) with no serial options enabled

    ttyS00 at 0xb1100003 (irq = 37) is a 16550A
    MTD driver for SPI flash.
    spiflash: Probing for Serial flash ...
    spiflash: Found SPI serial Flash.
    4194304: size
    Creating 8 MTD partitions on "spiflash":
    0x00000000-0x00030000 : "RedBoot"
    0x00030000-0x000c0000 : "vmlinux.lzma"
    0x000c0000-0x002c0000 : "rootfs"
    0x002c0000-0x002d0000 : "config"
    0x002d0000-0x002e0000 : "mac_addr"
    0x002e0000-0x003e0000 : "unallocated space"
    0x003e0000-0x003ef000 : "FIS directory"
    mtd: partition "FIS directory" doesn't end on an erase block -- force read-only
    0x003ef000-0x003f0000 : "RedBoot config"
    mtd: partition "RedBoot config" doesn't start on an erase block boundary -- force read-only
    Initializing Cryptographic API
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP, IGMP
    IP: routing cache hash table of 512 buckets, 4Kbytes
    TCP: Hash tables configured (established 1024 bind 2048)
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    NET4: Ethernet Bridge 008 for NET4.0
    VFS: Mounted root (squashfs filesystem) readonly.
    Mounted devfs on /dev
    Freeing unused kernel memory: 64k freed
    init started:  BusyBox v1.2.1 (2008.08.06-08:54+0000) multi-call binary
    Algorithmics/MIPS FPU Emulator v1.5
    checksum = 0x00, len = 65536
    Valid user config found...
    1+0 records in
    1+0 records out
    reload successful! 
    Warning: loading ae531x will taint the kernel: no license
      See http://www.tux.org/lkml/#export-tainted for information about tainted modules
    wlan: 0.8.4.2 (Atheros/multi-bss)
    Warning: loading ath_hal will taint the kernel: ath_hal: 0.9.16.1 (non-GPL license AR5212- Proprietary
     , AR5312 See http://www., RF5111tux.org/lkml/#ex, RF5112port-tainted for, RF2413 information abo, RF5413ut tainted modul, RF2316es
    )
    Warning: loadingath_rate_atheros: Version 2.0.1
     ath_rate_atheroCopyright (c) 2001-2004 Atheros Communications, Inc, All Rights Reserved
    s will taint the kernel: non-GPL license - Proprwlan: mac acl policy registered
    ietary
      See http://www.tux.org/lkml/#export-tainted for information about tainted modules
    ath_ahb: 0.9.4.5 (Atheros/multi-bss)
    wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
    wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
    wifi0: mac 11.0 phy 4.8 radio 7.0
    wifi0: Use hw queue 1 for WME_AC_BE traffic
    wifi0: Use hw queue 0 for WME_AC_BK traffic
    wifi0: Use hw queue 2 for WME_AC_VI traffic
    wifi0: Use hw queue 3 for WME_AC_VO traffic
    wifi0: Use hw queue 8 for CAB traffic
    wifi0: Use hw queue 9 for beacons
    wifi0: Atheros 2315 WiSoC: mem=0xb0000000, irq=3
    Warning: loadinggpio_proc2: module loaded and /proc/gpio2/ created with 9 contiguous gpios detected
     proc_gpio2 will taint the kernel: no license
      See http://www.tux.org/lkml/#export-tainted for information about tainted modules
    device eth0 entered promiscuous mode
    br0: port 1(eth0) entering learning state
    route: SIOC[ADD|DEL]RT: Invalid argument
    ath0
    Configuration file: /tmp/hostapd/hostapd.conf
    Using interface ath0 with hwaddr 00:30:ab:29:27:dd and ssid 'Voodoo Power Adapter'
    GMK - hexdump(len=32): e5 5a c8 88 1e 64 3c 30 e9 50 51 96 e1 52 70 22 1d b0 39 00 0a 42 c1 e9 37 47 30 b4 f9 05 44 59
    GTK - hexdump(len=16): 5f 20 91 c0 79 4d 24 d6 c9 b5 25 be 67 30 8f 53
    device ath0 entered promiscuous mode
    Flushing old staath0: attempt to add interface with same source address.
    tion entries
    Debr0: port 2(ath0) entering learning state
    authenticate all stations
    open file /tmp/configs/acl_auth_flag failed

    Please press Enter to activate this console. br0: port 2(ath0) entering disabled state
    br0: port 1(eth0) entering forwarding state
    br0: topology change detected, propagating

### Specs

-   Flash: ?
-   Ram: 16M
-   CPU: Atheros AR5315
-   Stock Kernel: Linux version 2.4.25 (ronger@dnisw1) (gcc version
    3.3.3) \#2 Wed Aug 6 16:57:25 CST 2008
-   Firmware Version: 0.0.0.1rc26
-   MTD Layout:

<!-- -->

    root@LINUX-AP:/proc# cat mtd 
    dev:    size   erasesize  name
    mtd0: 00030000 00010000 "RedBoot"
    mtd1: 00090000 00010000 "vmlinux.lzma"
    mtd2: 00200000 00010000 "rootfs"
    mtd3: 00010000 00010000 "config"
    mtd4: 00010000 00010000 "mac_addr"
    mtd5: 00100000 00010000 "unallocated space"
    mtd6: 0000f000 00010000 "FIS directory"
    mtd7: 00001000 00010000 "RedBoot config"

-   Redboot Version:

<!-- -->

    RedBoot> version

    RedBoot(tm) bootstrap and debug environment [ROMRAM]
    Non-certified release, version UNKNOWN - built 09:45:22, Mar 31 2008

    Copyright (C) 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.

    Board: ap51 
    RAM: 0x80000000-0x81000000, [0x8003fd50-0x80fe1000] available
    FLASH: 0xbfc00000 - 0xbfff0000, 64 blocks of 0x00010000 bytes each.
