---
categories:
 - DRBD
 - Linux
 - Syadmin
---
### Install It

Centos 5: yum install kmod-drbd83

Ubuntu 10.04: apt-get install drbd8-utils drbdlinks

### The Config File

    global {
      usage-count yes;
    }
    common {
      protocol C;
    }
    resource r0 {
      on alice {
        device    /dev/drbd1;
        disk      /dev/sda7;
        address   10.1.1.31:7789;
        meta-disk internal;
      }
      on bob {
        device    /dev/drbd1;
        disk      /dev/sda7;
        address   10.1.1.32:7789;
        meta-disk internal;
      }
    }

### Initial Initialization

First create the metadata, based on the *resource name*. Do this on both
nodes drbdadm create-md resource

Now startup drbd to connect the two. Do this on both nodes:
/etc/init.d/drbd start

Check out the status of drbd:

    cat /proc/drbd
    version: 8.3.0 (api:88/proto:86-89)
    GIT-hash: 9ba8b93e24d842f0dd3fb1f9b90e8348ddb95829 build by buildsystem@linbit, 2008-12-18 16:02:26
     1: cs:Connected ro:Secondary/Secondary ds:Inconsistent/Inconsistent C r---
        ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:200768

Notice that they are both secondary, and their data is inconsistent.
Lets sync. Run this on your **Source** Node: drbdadm --
--overwrite-data-of-peer primary resource

And watch it sync: cat /proc/drbd

### Heartbeat Integration

Once <Heartbeat> is setup, you can have an /etc/ha.d/haresources file
like this:

    node1 \
            drbddisk \    
            Filesystem::/dev/drbd0::/data::ext3 \
            IPaddr::192.168.42.100 \
            nfs

