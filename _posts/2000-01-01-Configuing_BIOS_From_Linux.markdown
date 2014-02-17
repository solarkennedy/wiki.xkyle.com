Configuring <BIOS> settings from within Linux is hard. It seems to be
vendor specific.

### Intel

Some Intel server boards are supported by the <syscfg> utility which
allows you to see all sorts of goodies for IPMI and BIOS stuff.

-   Manual:
    <http://www.intel.com/support/motherboards/server/sb/CS-022714.htm>

### Dell

Dell has this huge OpenManage deal. But eventually they seem to have
support for [Dell syscfg](Dell syscfg "wikilink")? (Different version)

-   <http://linux.dell.com/wiki/index.php/Syscfg>

There also seems to be some tools for "PowerEdge C" servers for "Cloud"
stuff. Tools for configuring the bios from a kinda fishy website:
<http://poweredgec.com/>

Seriously, if you have a Dell Server that starts with a C, check out the
[Dell setupbios](Dell setupbios "wikilink") command:
<http://poweredgec.com/files/>

### HP

HP has <conrep>, <scli>, and <hpasmcli>. I don't know the differences
between these tools yet. The possibilities are there.

-   CONREP:
    <http://h18004.www1.hp.com/products/servers/management/toolkit/stk/index.html>
-   hpasmcli:
    <http://h30499.www3.hp.com/t5/General/Possible-to-set-Boot-Controller-Order-Proliant-from-Linux/td-p/4788562>\#.UMJ59YMR4mk

### Generic

There is /dev/nvram, but it seems to be obsolete on newer platforms with
<UEFI>. In theory you can copy and paste /dev/nvram to other identical
servers to copy bios settings.

There is also smbios-token-ctl, part of <smbios-utils> which should be
able to, in theory, set and read bios settings that are exposed through
libsmbios.

### UEFI

UEFI is kinda next-gen bios. There is fwts uefidump and cat
/sys/firmware/efi/vars Somewhere in here there is at least boot order
that grub-efi can control.

#### References

-   <http://stackoverflow.com/questions/6259124/apis-for-querying-and-setting-bios-properties>

<Category:BIOS> <Category:Dell> <Category:syscfg> <Category:HP>
<Category:Intel>
