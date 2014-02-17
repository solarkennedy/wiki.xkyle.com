---
categories:
 - IPv6
---
IPv6 [Link local
addresses](http://en.wikipedia.org/wiki/Link-local_address) are
addresses that are automatically generated for each "link" or lan, that
are only relevant to that relevant lan segment. They are not globally
route-able. In the IPv4 world they are in **169.254.0.0/16**. In IPv6
they are **fe80::/10**.

It should be worth noting right away that **IPv6 Link Local Addresses
are only relevant in association with a particular lan (aka Zone
Index)**. This means an OS has no idea where to send a link-local packet
unless you specify the interface. You will see this in action with the
examples.

### Configuration

You probably already have them, without even doing anything! They come
with the ipv6 stack automatically, which is enabled in most distros:

    wlan0     Link encap:Ethernet  HWaddr 00:21:6a:00:00:00 
              inet addr:10.0.2.161  Bcast:10.0.2.255  Mask:255.255.255.0
              inet6 addr: fe80::221:6aff:fe7c:485c/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:5562 errors:0 dropped:0 overruns:0 frame:0
              TX packets:62 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000 
              RX bytes:566994 (566.9 KB)  TX bytes:16057 (16.0 KB)

And if you so desire... windows...\
<http://msdn.microsoft.com/en-us/library/ms739166%28v=vs.85%29.aspx>
![](Windows-ipv6.gif "image")

### Using Them (Examples)

When are these random addresses useful? Say you are on a network where
there is no dhcp server? Or maybe there is a dhcp server but you typo'd
a static IP, or moved some server and you can't reach it? IPv6 to the
rescue!

First do a broadcast ping:

    kyle@kyle:~$ ping6 -I eth0 ff02::1
    PING ff02::1(ff02::1) from fe80::226:b9ff:fe01:f746 eth0: 56 data bytes
    64 bytes from fe80::226:b9ff:fe01:f746: icmp_seq=1 ttl=64 time=0.076 ms
    64 bytes from fe80::8886:46ff:feb1:8d03: icmp_seq=1 ttl=64 time=1.18 ms (DUP!)
    64 bytes from fe80::210:75ff:fe1a:52a5: icmp_seq=1 ttl=64 time=4.10 ms (DUP!)
    64 bytes from fe80::210:75ff:fe1a:104f: icmp_seq=1 ttl=64 time=6.64 ms (DUP!)
    64 bytes from fe80::221:6aff:fe7c:485c: icmp_seq=1 ttl=64 time=111 ms (DUP!)
    64 bytes from fe80::226:b9ff:fe01:f746: icmp_seq=2 ttl=64 time=0.111 ms

In this case **ff02::1** is the link-local broadcast address. In the
ping command you must specify the interface with -I or else ping will
bomb out, as **link-local addresses are only relevant in association
with a particular lan.**

Now show your neighbors:

    kyle@kyle:~$ ip -6 neigh
    fe80::8886:46ff:feb1:8d03 dev eth0 lladdr 00:13:10:e4:da:3b router REACHABLE
    fe80::210:75ff:fe1a:104f dev eth0 lladdr 00:10:75:1a:10:4f DELAY
    fe80::221:6aff:fe7c:485c dev eth0 lladdr 00:21:6a:7c:48:5c DELAY
    fe80::210:75ff:fe1a:52a5 dev eth0 lladdr 00:10:75:1a:52:a5 DELAY

This is kinda like ARP in ipv6, but with automatic addresses that every
interface will have, no matter how screwed up the networking is. (as
long as the interface is actually up)

### Connecting to a Link-Local Address

#### Ping6

Remember, link-local addresses are meaningless without an associated lan
interface. Say in the previous example we want to try pinging the second
host. (the first host is a 'router'): kyle@kyle:\~\$ ping6
fe80::210:75ff:fe1a:104f connect: Invalid argument

Invalid argument? That is ping's way of saying that you didn't specify
the network interface, so it doesn't know where to send the packet. In
linux you must append the address with a "%eth0", depending on the
network interface. Lets try again: kyle@kyle:\~\$ ping6
fe80::210:75ff:fe1a:104f%eth0 PING
fe80::210:75ff:fe1a:104f%eth0(fe80::210:75ff:fe1a:104f) 56 data bytes 64
bytes from fe80::210:75ff:fe1a:104f: icmp\_seq=1 ttl=64 time=0.206 ms

Works now. In Windows you have to do an "%4" or some number connected to
the interface, available from ipconfig.
![](Windows-ipv6-ping.jpg "image")

#### Tracerout / mtr

Er. This doesn't apply ding-dong because all the link-local addresses
are only relevant in the local lan.

#### SSH

Like the ping, all you have to do is append the network interface after
with like "%eth0": kyle@kyle:\~\$ ssh root@fe80::210:75ff:fe1a:104f%eth0
The authenticity of host 'fe80::210:75ff:fe1a:104f%eth0
(fe80::210:75ff:fe1a:104f%eth0)' can't be established. RSA key
fingerprint is 4f:6d:99:e6:0b:9c:b7:a3:97:ff:3b:12:ec:dd:96:8a. No
matching host key fingerprint found in DNS. Are you sure you want to
continue connecting (yes/no)?

#### Nmap

Same thing, but add the -6 argument: nmap -6
fe80::8886:46ff:feb1:8d03%eth0

