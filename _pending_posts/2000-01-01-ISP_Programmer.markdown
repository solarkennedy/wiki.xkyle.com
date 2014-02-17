---
categories:
 - Electronics
 - AVR
---
If you have an arduino or a <AVR> microcontroller that needs
programming, but you don't have a bootloader installed, you can use the
ISP method of programming.

First, build a cable:
<http://www.captain.at/electronics/atmel-programmer/> Its just cables
and 3 resistors. Cheap!

Then run the software: (on linux)

    rmmod lp
    modprobe ppdev

This should have created a /dev/parport0 file in the /dev directory.

if you run:

     uisp -dprog=dapa

it should tell you what kind of chip you have.

Now Program:

    avrdude -p attiny13 -P /dev/parport0 -c dapa                -U flash:w:Flame_Board_Code.hex

    avrdude -p chiptype -P (device file) -c (programmer type)   -U whattoprogram:write:filename

