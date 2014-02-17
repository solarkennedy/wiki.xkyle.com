---
categories:
 - CFEngine
---
<CFEngine> enables system administrators to centrally control the
installed packages on lots of servers. However, CFEngine allows (or
burdens) the sysadmin to setup the "glue" to allow CFEngine to control
the package manager. By default it is not package manager aware.

### Teaching CFEngine How to Use Apt-get

One problem using apt-get with CFEngine is that is, sometimes, an
interactive program. It will ask about upgrades, overwriting config
files, etc. We need to make apt-get get less interactive. One way to do
that is with a wrapper
[1](http://www.debian-administration.org/article/Installing_packages_across_multiple_hosts_with_CFEngine).

Here is my wrapper:

    #!/bin/sh
    # cf_apt-get.sh - Teach CFEngine to apt-get non-interactively

    export DEBIAN_FRONTEND=noninteractive
    export DEBIAN_PRIORITY=critical

    if [ $# -gt 0 ]; then
        /usr/bin/logger -p local0.notice "$0: $*"
        # Don't use AllowUnauthenticated unless you need it!
        /usr/bin/apt-get -y -q $* -o APT::Get::AllowUnauthenticated=true -o Dpkg::Options::="--force-confold"
    fi

Some notable options here, is our DEBIAN\_ variables and our apt-get
options. In this case we tell dpkg to only ask us critical question and
skip asking us stuff that it would normally ask (run apt-get install
exim for an example). Also we tell dpkg to always pick the existing
config file whenever there is a config file upgrade. (Never overwrite
our config file). Also in this particular case I have it allowing
unauthenticated packages. (It is bad, I know)

Now lets put this script somewhere on our CFEngine server and push it
out!

    control:

            ubuntu::
            DefaultPkgMgr      = ( dpkg )
            DPKGInstallCommand = ( "/usr/sbin/cf_apt-get.sh install %s" )
            DPKGRemoveCommand  = ( "/usr/sbin/cf_apt-get.sh remove %s" )


    copy:
            ubuntu::
            # this is a shell script wrapper to do non-interactive apt-get
            /usr/lib/cfengine2/masterfiles/files/ubuntu/usr/sbin/cf_apt-get.sh  dest=/usr/sbin/cf_apt-get.sh
                            mode=755
                            owner=root
                            group=root
                            server=$(policyhost)
                            verify=true
                            backup=timestamp

### Using The New Control

Now that cfengine knows how to handle apt-get, lets instruct it to
enforce certain packages:

    packages:
        ubuntu::
                    # All ubuntu servers need these packages 
            acpid           action=install
            screen          action=install
            ethtool         action=install
            iotop           action=install
            mailutils       action=install
            build-essential     action=install
            lvm2            action=install
            # Remove list   
            landscape-common    action=remove
                    evolution               action=remove

            # Ubuntu HA servers, their package names are different than centos
        haservers.ubuntu::
            drbd8-utils     action=install
            heartbeat       action=install
            xfsprogs        action=install
            nfs-kernel-server   action=install  
            haservers.centos::
                    kmod-drbd       action=install
            heartbeat       action=install
                    kmod-xfs                action=install
            xfsprogs        action=install
                    nfs-utils           action=install

### Conclusion

Using this in combination with other CFEngine techniques you can see how
one can declare a server into a certain class, wait an hour, and then
everything is in place. Welcome to the world of server automation. This
works with 1 or 100 servers.

