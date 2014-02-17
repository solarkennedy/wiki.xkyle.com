---
categories:
 - EFI
 - BIOS
 - DHCP
---
### Procedure

​1. Enable "EFI Network Stack" in the BIOS.\
![](EFI_Network_Bios_Setting.PNG "image")

​2. Get into the [EFI Shell](EFI Shell "wikilink")

​3. Run: ifconfig -s eth0 dhcp ![](EFI DHCP eth0.PNG "image")

​4. Run ifconfig for verification: ifconfig -l eth0
![](EFI ifconfig l.PNG "image")

WARNING: Mixing TCP/IP stacks from other sources might cause unknown
effects.

