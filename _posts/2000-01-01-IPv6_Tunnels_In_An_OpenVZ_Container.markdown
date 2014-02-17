---
categories:
 - IPv6
 - OpenVZ
---
It's not too hard to setup an <IPv6> tunnel inside an <OpenVZ>
container. However, you cannot use normal interface tools (ifconfig, ip)
because of the way openvz containers are designed. Instead you must use
a userspace tunnel program. <http://code.google.com/p/tb-tun/>

### Install

    apt-get -y install iproute gcc || yum -y install iproute gcc
    wget http://tb-tun.googlecode.com/files/tb-tun_r18.tar.gz
    tar zxf  tb-tun_r18.tar.gz
    # You can either use the prebuilt binary or compile it.
    gcc tb_userspace.c -l pthread -o tb_userspace
    mv tb_userspace /usr/sbin/

### Configuration

    #The 216 ip is the remote tunnel endpoint
    setsid tb_userspace tun6to4 216.66.22.2 any sit > /dev/null &
    ifconfig tun6to4 up
    ifconfig tun6to4 inet6 add 2001:470:7:899::2/64
    #Extra ipv6 ip here
    ifconfig tun6to4 inet6 add 2001:470:8:899::1/64
    ifconfig tun6to4 mtu 1480
    route -A inet6 add ::/0 dev tun6to4

