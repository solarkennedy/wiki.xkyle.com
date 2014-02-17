---
categories:
 - WiFi
---
These are instructions on how to unlock a Atheros (madwifi) card to
untold frequencies!

First get your frequencies that you have now:

    iwlist ath0 freq

Now change your regulatory domain and then modprobe with a new country
code. I had to do -g 1:0 to enable writing to my eeprom, you may have to
use a different GPIO other than 1. Also your memory base will probably
not be on fbef000 unless you have the same eeepc that I have.

    ifconig ath0 down
    rmmod ath_pci
    ath_info -g 1:0 -w fbef0000 regdomain 0x00
    modprobe ath_pci countrycode=511

Now check your freqencies:

    iwlist ath0 freq

Enjoy you new channels.... :)

P.S. One problem with this is the limited power on these wide channels.
If you need power you should choose a country code that has a good power
level for the frequency you need. Check out [this
list](http://madwifi-project.org/wiki/UserDocs/CountryCode).

