---
categories:
 - OpenWrt
---
This took a long time to figure out how to do. The first thing you need
is a copy of the OpenWRT sources.

    svn co svn://dev.openwrt.org/openwrt/branches/8.09

If you want you can make your self an image. Otherwise let us get the
driver:

    wget http://wiki.xkyle.com/images/5/52/Mmc.tgz
    tar xzf Mmc.tgz
    cd mmc

Now you should take a look at the Makefile and the config.h to reflect
your io pins. run make, then get the file into
/lib/modules/kernel.version/ then:

    echo 0xb8 > /proc/diag/gpiomask  #Or whatever your gpiomask is
    insmod mmc

Here is my config:

    #define LOG_LEVEL 3
    #define USE_CMD18
    #define USE_CMD25

    /* GPIO pin 2 */
    //#define SD_DI 0x04
    #define SD_DI 0x020
    /* GPIO pin 4 */
    //#define SD_DO 0x10
    #define SD_DO 0x10
    /* GPIO pin 3 */
    #define SD_CLK 0x08
    /* GPIO pin 7 */
    #define SD_CS 0x80

    #if SD_DO == 0x10
            #define SHIFT_DO 3
    #else
    #if SD_DO == 0x40
            #define SHIFT_DO 1
    #endif
    #endif
    #if SD_DI == 0x04
            #define SHIFT_DI 5
    #else
    #if SD_DI == 0x20
            #define SHIFT_DI 2
    #endif
    #endif

