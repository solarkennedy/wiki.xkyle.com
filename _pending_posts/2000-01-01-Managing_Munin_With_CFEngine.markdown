---
categories:
 - Munin
 - CFEngine
---
<Munin> is a great monitoring tool. I like to have a central munin
server that polls other servers to aggregate graphs. Here is how I use
<CFEngine> to do this for me:

    packages:
        munin-node      action=install

    copy:   
        $(files)/munin-node.conf  dest=/etc/munin/munin-node.conf
            mode=644
            owner=root
            group=root
            server=$(policyhost)
            verify=true
            define=new_munin_conf

    shellcommands:
            new_munin_conf::
                    "/etc/init.d/munin-node restart >/dev/null 2>&1" umask=022

### See Also

<CFEngine2Munin> - How to automatically generate configs for your munin
server.

