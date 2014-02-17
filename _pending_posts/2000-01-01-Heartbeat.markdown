---
categories:

---
Heartbeat Quick Install
-----------------------

### Centos 5

    yum -y install heartbeat
    chkconfig heartbeat on

Base Config
-----------

And we need a /etc/ha.d/authkeys for authentication:

    auth 1
    1 md5 d8e8fca2dc0f896fd7cb4cb0031ba249

Don't forget: chmod 600 /etc/ha.d/authkeys

And a bare /etc/ha.d/ha.cf:

    logfacility     local0
    bcast   eth0
    auto_failback off
    node    lb1
    node    lb2

And a simple /etc/ha.d/haresources for <ldirector>:

    lb1 \
            IPaddr::192.168.0.1 \
        ldirectord

See Also:

-   <drbd>

[Category:High Availability](Category:High Availability "wikilink")
