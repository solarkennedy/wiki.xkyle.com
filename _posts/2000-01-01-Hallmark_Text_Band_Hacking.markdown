---
categories:

---
### Components

**2.4gig RF board and chip:** I have confirmed that the chip in the
CMM9201 is an EM9201 V3.

*' Battery Pack*' The two CR2032 cells are in parallel (3 volts) and not
series ( 6 volts).

''' LEDs ''' There are 5 rows of 16 LEDs. Each row looks to have a 100
Ohm current limit resistor.

*' Bump switch*' The bump switch looks to be a metal cylinder with a
spring suspended in side.

### SPI Electrical Characteristics between LED and RF boards

-   All signals are positive with respect to ground.
-   (SCK) The SPI CLK is HI for 1 micro second (uS), and low for 3uS. (
    total 4uS).
-   (SCK) Data is 8 bits.
-   (SCK) There is a low delay of 2.5uS between bytes.
-   (SCK) There is a 16 mili second (mS) low delay between bursts of 3
    lots of 2 bytes at idle.
-   (SCK) And 6 ms low delay between the 3 lots of 2 bytes when
    'bumped'.

-   (SDI)

-   (SDO)

-   (CS)

-   (IRQ)

### SPI Protocol

*Each change to **SDI** is latched on the **rising edge of SCK**, and
each change to **SDO** is available on the **falling edge of SCK**.*

*A SPI transaction is all activity on SCK, SDI and SDO that occurs
between the falling edge of CSN and the next rising edge.*

*The first **bit of SDI** identifies the transaction as a register read
(‘1’) or write (‘0’).*

*This is followed by seven address bits and eight data bits.*

*Simultaneously the SDO returns the 8 status bits from RegInt1Sts
(address 0x00), followed by eight data bits from the requested
register.*

*Over this physical interface, the protocol is byte-based. Each byte
shall be sent **most-significant bit (MSb) first**.*

*The first bit of SDI identifies the transaction as a register **read**
(‘1’) or **write** (‘0’).* *This is followed by seven address bits and
eight data bits.* Simultaneously the SDO returns the 8 status bits from
RegInt1Sts, followed by eight data bits from the requested *register.*
*The protocol is byte-based. most-significant bit **(MSb) first**.*

![](SPI-RW-MBbFirst.png "image")

Every read or write comes with a FREE copy of the Status register at
0x00 ( and a set of cheap steak knives ).

A write to register 0x2C will be sent as 0x2C, But a read from Register
0x2C would be seen as 0xAC on the SPI bus.

0x80 = 0x00, 0x90 = 0x10, 0xA0 = 0x20, ..etc .

### Sniffing SPI

[Bus Pirate](Bus Pirate "wikilink") Settings:

-   Clock Speed: 250khz
-   Polarity: Idle Low.
-   Output clock edge: Idle to Active
-   Input sample phase: Middle
-   Output type: Open (shouldn't matter)
-   SPI bus sniffing mode when CS is Low.

**Sample of SDI line only. using raw Bus Pirate (BP) data of the EM920x
initialization.**

`[0x1A(0x00)0xB3(0x00)0x1A(0x00)0x5E(0x00)0x00(0x00)0xFF(0x00)0x01(0x00)0xFF(0x00)0x1B(0x00)0x74(0x00)`\
` 0x1B(0x00)0x9B(0x00)0x2A(0x00)0x7B(0x00)0x2B(0x00)0x14(0x00)0x22(0x00)0x60(0x00)0x35(0x00)0x41(0x00)`\
` 0x34(0x00)0x04(0x00)0x36(0x00)0x03(0x00)0x24(0x00)0x10(0x00)0x32(0x00)0x33(0x00)0x33(0x00)0x44(0x00)`\
` 0x31(0x00)0x87(0x00)0x32(0x00)0x11(0x00).....`

Below is the same data as above but put into human readable format with
notes from the EM9203 data sheet:

` Reg, Data,  Comment.`\
`[0x1A 0xB3 Reset 1/2 `\
`0x1A 0x5E   2/2`\
`0x00 0xFF Clear interrupts in Int1Sts`\
`0x01 0xFF Clear interrupts in Int2Sts`\
`0x1B 0x74 }Part of RF init sequence as per 9203 Data sheet sec 5.2.1`\
`0x1B 0x9B }   "`\
`0x2A 0x7B }   `\
`0x2B 0x14 } `\
`0x22 0x60 }  22 changes from 60 to 00`\
`0x35 0x41 }`\
`0x34 0x04 }`\
`0x36 0x03 } `\
`0x24 0x10 }`\
`0x32 0x33 }  32 changes from  33,11,ff,ee`\
`0x33 0x44 }  33 changes from  44,22,00,ee`\
`0x31 0x87 }  31 changes from  87,88,89,8a`\
`0x32 0x11 }`\
`0x33 0x22 }`\
`0x31 0x88 }`\
`0x32 0xFF }`\
`0x33 0x00 }`\
`0x31 0x89 }`\
`0x32 0xEE }`\
`0x33 0xEE }`\
`0x31 0x8A }`\
`0x22 0x00 } end of RF init ?`\
`0x04 0x02 Start RF`\
`0x00 0xFF Clear interrupts in Int1Sts`\
`0x01 0xFF Clear interrupts in Int2Sts`\
`0x02 0x00 Clear interrupt flag links to IRQ pin.`\
`0x03 0x01 Set Auto Callibration to flag on IRQ pin`\
`0x06 0x36 Start PLL callibration,Output power is 0dBm.`\
`0x06 0x16 Stop PLL callibration, power still 0 dBm.`\
`0x04 0x00 Clear config register.`\
`0x00 0xFF Clear interrupts in Int1Sts`\
`0x01 0xFF Clear interrupts in Int2Sts`\
`0x04 0x00 Clear config register`\
`0x05 0x02] Xtreme power down mode on.`\
`...snip`

### Test Mode

Hold down the front centre button while you turn the band on. Until you
get a running vertical bar.

Then step all LED rows with the left button. Then step all columns with
the right button.

Pushing the centre button again puts it into 'bump' test mode. Each
tap/bump says " OK".

Press/hold the left side ( not left front) button to get " RX\>\>\>" on
the screen.

Pressing the right button cycles through "T-20",..T-16, T-12, T-09,
T-06, T-03, T-000, T+4.

These nearly match the selectable TX power levels of the EM9201/3 chip
on the RF board.

### Hardware

![ 500px](XK-bandpic.png "image") ![](PwrSw-Xtal-BumpSw.png "image")
![](RF-Board.png "image") ![](Buttons LEDmatrix.png "image")

### References

-   <https://xkyle.com/hacking-a-hallmark-text-band-first-attempt/>
-   <http://www.c-max.com.hk/en/technology/rfcomm/2_4g_trans_ic>
-   <http://www.emmicroelectronic.com/webfiles/product/other/EM9201_DS.pdf>
-   <http://www.emmicroelectronic.com/webfiles/product/other/EM9203_DS.pdf>

