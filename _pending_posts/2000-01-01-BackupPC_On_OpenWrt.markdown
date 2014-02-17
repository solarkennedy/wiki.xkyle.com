---
categories:
 - BackupPC
 - OpenWrt
 - Samba
---
These are instructions for installing Openwrt on Backfire. This include
rsync, all the perl stuff, ssh'ing, etc.

This is written for Openwrt Backfire (10.03) on the Kirkwood (Arm)
architecture.

### Dependencies

First you need these dependencies. I'm assuming you have the space. If
you don't, where are you putting the backups?

    opkg update

    opkg install perl
    opkg list | grep -o -E perlbase-\\w+ | xargs opkg install

    opkg remove dropbear
    opkg install openssh-server openssh-client 
    /etc/init.d/sshd enable  # For luck!

    #Now for the Xfer methods, take what you need
    opkg install http://xkyle.com/packages/perl-file-rsyncp_0.68-1_kirkwood.ipk
    opkg install rsync
    opkg install tar
    opkg install samba-client

    #optional stuff, but again they are nice to have
    opkg install net-tools  --force-overwrite  #for hostname, etc. Replaces some busybox stuff

-   That perl-file-rsyncp package from me? Yea you need it if you want
    to use the rsync method with backuppc. Don't ask me how I got it to
    cross compile. I don't think I could bear to do it again.
-   You can probably get away with dropbear instead of openssh, but
    openssh is so much nicer if you ask me. Be prepared to heavily edit
    your config.pl for backuppc if you are going to use dropbear, it
    doesn't use keys in the same format or the same places as openssh,
    which can be critical for proper functioning of backuppc if you are
    using rsync+ssh.
-   You probably don't need all that perl stuff, can't hurt though. I
    haven't filtered out what is absolutely essential or not yet.
-   A special shout out and thanks to [Ted
    Carnahan](http://www.tedcarnahan.com/) for his [awesome
    instructions!](http://www.tedcarnahan.com/2009/07/09/installing-backuppc-on-openwrt/)
-   If you are using samba, you probably want the samba tools. If you
    are using tar, you probably need the for-real gtar.

### Installing

    wget http://sourceforge.net/projects/backuppc/files/backuppc/3.1.0/BackupPC-3.1.0.tar.gz/download
    tar xzf BackupPC-3.1.0.tar.gz
    cd BackupPC-3.1.0

Now before you run this command, maybe edit it to what you want. I don't
bother using another use, I just use root to make things simpler. This
command actually installs backuppc with that --batch.

    ./configure.pl --batch --backuppc-user=root --html-dir-url=/backuppc/ --html-dir=/www/backuppc/ --cgi-dir=/www/cgi-bin/
    chmod +x /www/cgi-bin/BackupPC_Admin

### Extras

An init script:

    cat > /etc/init.d/backuppc <<@EOF
    #!/bin/sh /etc/rc.common
    # Startup init script for BackupPC for OpenWrt
    START=95
    STOP=10

    start() {
        /usr/local/BackupPC/bin/BackupPC -d
    }
    stop() {
        /usr/bin/pkill -f "/usr/local/BackupPC/bin/BackupPC -d"
    }
    restart() {
        stop
        start
    }
     
    reload() {
        /usr/bin/pkill -HUP "/usr/local/BackupPC/bin/BackupPC -d" -f
    }
    @EOF

Then chmod and enable the startup script: chmod 755 /etc/init.d/backuppc
/etc/init.d/backuppc enable /etc/init.d/backuppc start

And now for basic authentication: echo "/cgi-bin/:root:password" \>\>
/etc/httpd.conf \#This is the username you have in your backuppc hosts
file, could be anything. /etc/init.d/uhttpd restart

Maybe some SSL while we are at it? No reason to send the password in the
clear anyway. opkg install uhttpd-mod-tls px5g /etc/init.d/uhttpd
restart

