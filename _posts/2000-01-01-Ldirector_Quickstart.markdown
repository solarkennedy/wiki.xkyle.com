---
categories:
 - Linux
 - LVS
 - Ldirector
---
Ldirector is a tool to administrate <LVS>

### Solving the Arp Problem

Sysctl.conf net.ipv4.conf.eth0.arp\_ignore = 1
net.ipv4.conf.eth0.arp\_announce = 2 net.ipv4.conf.all.arp\_ignore = 1
net.ipv4.conf.all.arp\_announce = 2

### Base Config

[Category:High Availability](Category:High Availability "wikilink")
