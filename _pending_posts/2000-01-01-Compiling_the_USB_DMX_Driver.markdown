---
categories:
 - DMX
---
Build and install the usb kernel module
---------------------------------------

Erwil Rol's driver allows the Enttec OpenDMX USB driver to work with
LLA.

It's best to make sure that you're running the kernel that you're
intending to use - if you've upgraded from previous versions of Ubuntu
you may have several versions hanging around. Removing old ones using
Synaptic is probably a good idea.

### Compile and install driver

`<pre>
cd ~
mkdir dmx-software
cd dmx-software
git clone http://git.hbels.com/public/dmx_usb_module
cd dmx_usb_module
make
sudo cp ./dmx_usb.ko /lib/modules/$(uname -r)/kernel/drivers/usb/serial
sudo depmod
</pre>`

### Blacklist the other serial drivers

Because this dongle uses a usb to serial converter chip, it's recognised
by the hotplug/udev/hal system and drivers are loaded - unfortunately
not ones that work with QLC. The workaround is to blacklist the
alternative drivers. If you have other usb to serial converters then
they will stop working - if you need these then you will have to delve
into the source and change the USB device IDs that the drivers detect...
here we will go for the quick and dirty solution.

#### Ubuntu

With your favourite text editor, as root/sudo, edit
/etc/modprobe.d/blacklist e.g.:

`<pre>
sudo gedit /etc/modprobe.d/blacklist
</pre>`

add the following lines:

`<pre>
blacklist usbserial
blacklist usb-serial
blacklist ftdi_sio
</pre>`

#### Centos/Fedora

I do not know of any blacklisting in redhat based distros so just delete
the offending module

`` <pre>
mv /lib/modules/`uname -r`/kernel/drivers/usb/serial/ftdi_sio.ko /lib/modules/`uname -r`/kernel/drivers/usb/serial/ftdi_sio.ko.disabled
depmod -a
</pre> ``

### Remove the brltty package (Ubuntu only)

According to Synaptic, "BRLTTY is a daemon which provides access to the
Linux console (text mode) for a blind person using a soft braille
display". Unfortunately it has a habit of interfering with anything that
looks like it might be a serial console, USB to serial devices included.
There's probably a more elegant workaround, but we'll go for the quick
and dirty again, and remove it:

`<pre>
sudo apt-get remove brltty
</pre>`

### Test the driver

Plug in your dongle!! Hopefully all will go well, and if you type:

`<pre>
dmesg
</pre>`

you should see:

    DMX USB device now attached to dmx192

If you've got other modules loading, ftdi serial drivers, etc. then
something's wrong.

### More

[OLA on a ARM](OLA on a ARM "wikilink")

### References

-   [1](http://www.opendmx.net/index.php/LLA_and_Q_Light_Controller_Ubuntu_Tutorial#Build_and_install_the_usb_kernel_module)

