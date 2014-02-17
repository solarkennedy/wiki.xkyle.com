Check an MTU on linux using ip: kyle@kyle:\~\$ ip link show wlan0 2:
wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN
qlen 1000 link/ether 00:21:5c:13:a3:a7 brd ff:ff:ff:ff:ff:ff

Test the MTU to a particular endpoint (with a 9000 MTU): ping -M do -s
8972 host.xkyle.com PING host.xkyle.com (1.2.3.4) 8972(9000) bytes of
data. 8980 bytes from host.xkyle.com (1.2.3.4): icmp\_seq=1 ttl=64
time=0.173 ms

When it doesn't work: kyle@kyle:\~\$ ping -M do -s 8972 leb.xkyle.com
PING leb.xkyle.com (199.167.199.187) 8972(9000) bytes of data. From
kyle.local (10.0.2.12) icmp\_seq=1 Frag needed and DF set (mtu = 1500)

<Category:Linux> <Category:Ethernet>
