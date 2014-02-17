There of lots of things you can put in your <PXE> boot config file.

### Boot To Local Disk

`LOCALBOOT 0`

### Send Output to Serial

`SERIAL 0 115200`\
`#Put at the top of the config file for best results. 0 means which serial port.`

### Wait for user input, then default

`DEFAULT localboot`\
`TIMEOUT 600 `\
`#Timeout is in 10ths of a second`

#### References

-   <http://people.mandriva.com/~aginies/doc/pxe/ch06.html>

<Category:PXE>
