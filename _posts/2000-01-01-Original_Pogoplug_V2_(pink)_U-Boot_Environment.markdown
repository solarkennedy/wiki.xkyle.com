Original Version: U-Boot 1.1.4 (Sep 28 2009 - 11:55:23) Cloud Engines
v2.0 (3.4.16)

     
    baudrate=115200
    loads_echo=0
    ipaddr=169.254.254.253
    serverip=169.254.254.254
    rootpath=/mnt/ARM_FS/
    netmask=255.255.0.0
    run_diag=yes
    stdin=serial
    stdout=serial
    stderr=serial
    console=console=ttyS0,115200
    mainlineLinux=no
    CASset=min
    enaMonExt=no
    enaCpuStream=no
    enaWrAllo=no
    pexMode=RC
    disL2Cache=no
    setL2CacheWT=yes
    disL2Prefetch=yes
    enaICPref=yes
    enaDCPref=yes
    sata_dma_mode=yes
    MALLOC_len=1
    ethprime=egiga0
    netbsd_en=no
    vxworks_en=no
    bootargs_root=root=/dev/mtdblock2 ro
    bootcmd=nand read.e 0x800000 0x100000 0x200000; setenv bootargs $(console) $(bootargs_root); bootm 0x800000
    ceboardver=PP_V2
    bootdelay=3
    disaMvPnp=no
    ethaddr=00:50:43:00:02:02
    ethmtu=1500
    usb0Mode=host
    nandEcc=1bit
    ethact=egiga0

    Environment size: 700/131068 bytes

New version: U-Boot 1.1.4 (Oct 9 2009 - 16:55:51) Cloud Engines v2.0
(3.4.p22)

    baudrate=115200
    loads_echo=0
    ipaddr=169.254.254.253
    serverip=169.254.254.254
    rootpath=/mnt/ARM_FS/
    netmask=255.255.0.0
    run_diag=yes
    stdin=serial
    stdout=serial
    stderr=serial
    console=console=ttyS0,115200
    nandEnvBase=a0000
    mainlineLinux=no
    CASset=min
    enaMonExt=no
    enaCpuStream=no
    enaWrAllo=no
    pexMode=RC
    disL2Cache=no
    setL2CacheWT=yes
    disL2Prefetch=yes
    enaICPref=yes
    enaDCPref=yes
    sata_dma_mode=yes
    MALLOC_len=1
    ethprime=egiga0
    netbsd_en=no
    vxworks_en=no
    bootargs_root=root=/dev/mtdblock2 ro
    bootcmd=nand read.e 0x800000 0x100000 0x200000; setenv bootargs $(console) $(bootargs_root); bootm 0x800000
    ceboardver=PP_V2
    bootdelay=3
    disaMvPnp=no
    ethaddr=00:50:43:00:02:02
    ethmtu=1500
    usb0Mode=host
    nandEcc=1bit
    pcieTune=no
    ethact=egiga0

    Environment size: 730/131068 bytes

[Category:Plug Computers](Category:Plug Computers "wikilink")
<Category:U-Boot> <Category:Pogoplug>
