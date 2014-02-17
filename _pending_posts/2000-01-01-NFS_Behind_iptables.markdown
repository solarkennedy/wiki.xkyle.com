---
categories:
 - iptables
 - NFS
 - Firewall
---
### Ubuntu

You need the following lines in these files:

##### /etc/default/nfs-common

`STATDOPTS="--port 32765 --outgoing-port 32766"`

##### /etc/default/nfs-kernel-server

`RPCMOUNTDOPTS="--manage-gids -p 32767"`

##### /etc/modprobe/nfslockd.conf

`options lockd nlm_udpport=32768 nlm_tcpport=32768`\
`options nfs callback_tcpport=32764`

Now you can put lines like these for..

##### <iptables>

    #NFS portmap
    -A INPUT -m state --state NEW -p tcp --dport 111 -j ACCEPT
    -A INPUT -m state --state NEW -p udp --dport 111 -j ACCEPT
    #NFS Mountd
    -A INPUT -m state --state NEW -p tcp --dport 2049 -j ACCEPT
    -A INPUT -m state --state NEW -p udp --dport 2049 -j ACCEPT
    #NFS RPC Mountd, lockd, statd, nlm call back
    -A INPUT -m state --state NEW -p tcp --dport 32764:32769 -j ACCEPT
    -A INPUT -m state --state NEW -p udp --dport 32764:32769 -j ACCEPT

And yay! No more crazy random open ports.

### RHEL/Centos

