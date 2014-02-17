---
categories:
 - U-Boot
---
First of all, copy the file uboot.bin to your TFTP server. Then start
your SheevaPlug, connect the serial console and type the following
commands:

`version`\
`setenv serverip 192.168.3.33 # IP of your TFTP server`\
`setenv ipaddr 192.168.3.32`\
`bubt uboot.bin`

The upgrade process will ask whether you want to change the environment:

`**Warning**`\
`If U-Boot Endiannes is going to change (LE->BE or BE->LE),`\
`Then Env parameters should be overridden..`\
`Override Env parameters? (y/n) n`

Make sure to answer "n" here. Then reset:

`reset`

And then check the version again:

`version`

