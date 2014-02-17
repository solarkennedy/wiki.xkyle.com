You need to have outputting to serial:

### Bios

Usually this is described as Console Redirection. The bios might give
you an option between serial ports, one is usually the IPMI and the
other is the physical one.

Sometimes you can have it redirect "Legacy" or "Bootloader" output too.
That would be nice if you want to skip the next one.

### Bootloader

-   Grub: [Serial Output on GRUB](Serial Output on GRUB "wikilink")
-   pxelinux: [PXE Options](PXE Options "wikilink")

`SERIAL 0 115200`

### Linux Console

Linux command line in your boot loader: console=tty0
console=ttyS0,115200n8

### Linux Getty

[Configuring Linux for a Serial
Prompt](Configuring Linux for a Serial Prompt "wikilink") or [Autologin
Serial Console on Linux](Autologin Serial Console on Linux "wikilink")

<Category:IPMI> <Category:Serial> <Category:GRUB> <Category:BIOS>
