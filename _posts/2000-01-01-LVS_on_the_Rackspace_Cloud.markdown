Rackspace's environment provides a unique situation that demands special
considerations when using <LVS>. For one, the shared ip must be
**manually set by a rackspace technician** to be distributed between
both of your load balancers. This has something to do with how they
route packets and deal with layer 2.

### Load Balancer Config

-   Start with the firewall off
-   Install <heartbeat>

Example haresources:

    lb1.xkyle.com \
            IPaddr2::173.1.2.3/24  \
        ldirectord

Example ldirectord.cf:

    checktimeout=5
    checkinterval=1
    autoreload=yes
    quiescent=no
    virtual=173.1.2.3:80
            real=10.0.0.3:80 ipip
            real=10.0.0.4:80 ipip
        persistent= 3600
            scheduler=wlc
            service=http
            protocol=tcp
            checktype=negotiate
            checkport=80

Notice that we are using the ipip tunneling protocol. This is because
the boxes are not on a physical lan, so rewriting the mac addresses will
not work, and they must be tunneled.
[1](http://www.rackspacecloud.com/blog/2010/09/22/installing-and-configuring-lvs-tun/)

### Real Server Config

First add a tun0 file in /etc/sysconfig/network-scripts (centos):

    DEVICE=tunl0
    TYPE=ipip
    IPADDR=173.1.2.3
    NETMASK=255.255.255.255
    ONBOOT=yes

These sysctl configuration options are recommended:

    net.ipv4.ip_forward = 0
    net.ipv4.conf.default.rp_filter = 1
    net.ipv4.conf.default.accept_source_route = 0
    kernel.sysrq = 0
    kernel.core_uses_pid = 1
    net.ipv4.tcp_syncookies = 1
    kernel.msgmnb = 65536
    kernel.msgmax = 65536
    kernel.shmmax = 68719476736
    kernel.shmall = 4294967296
    net.ipv4.conf.lo.arp_ignore = 1
    net.ipv4.conf.lo.arp_announce = 2
    net.ipv4.conf.tunl0.arp_ignore = 1
    net.ipv4.conf.tunl0.arp_announce = 2
    net.ipv4.conf.all.arp_ignore = 1
    net.ipv4.conf.all.arp_announce = 2
    net.ipv4.tcp_tw_reuse = 1
    net.ipv4.tcp_tw_recycle = 1
    net.ipv4.tcp_fin_timeout = 15
    net.ipv4.ip_local_port_range = 1024 65536
    net.ipv4.tcp_synack_retries = 2
    net.ipv4.tcp_max_syn_backlog = 2048
    net.ipv4.conf.all.rp_filter = 0
    net.ipv4.conf.default.rp_filter = 0
    net.ipv4.conf.lo.rp_filter = 0
    net.ipv4.conf.eth0.rp_filter = 0
    net.ipv4.conf.eth1.rp_filter = 0
    net.ipv4.conf.tunl0.rp_filter = 0

### Reference

-   Rackspace Blog Post:
    <http://www.rackspacecloud.com/blog/2010/09/22/installing-and-configuring-lvs-tun/>

[Category:High Availability](Category:High Availability "wikilink")
<Category:LVS>
