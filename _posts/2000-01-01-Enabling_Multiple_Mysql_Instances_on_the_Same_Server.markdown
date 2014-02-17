---
categories:
 - Mysql
 - Upstart
---
Using the mysqld\_multi script, you can spawn multiple instances of
mysql on the same server. This can be good for development, [Mysql
Replication](Mysql Replication "wikilink"), or backups.

Setting up your Config file
---------------------------

You can use the one my.cnf file in /etc/mysql/ to control both of your
instances. Here is an example. Just put the number after [mysqld] like
[mysqld1].

Don't forget to add server-id = X where x is a unique number. Also, you
can't mix your files together, so make sure they are all storing to
different places.

    [mysqld_multi]
    mysqld     = /usr/bin/mysqld_safe
    mysqladmin = /usr/bin/mysqladmin

    [mysqld1]
    port            = 3306
    datadir=/var/lib/mysql
    socket=/var/lib/mysql/mysql.sock
    user=mysql
    server-id               = 1
    log_bin                 = /var/log/mysql/mysql-bin.log
    expire_logs_days        = 20
    max_binlog_size         = 100M
    log_error                = /var/log/mysql/error.log

    [mysqld2]
    port            = 3305
    datadir=/var/lib/mysql-slave
    socket=/var/lib/mysql/mysql-slave.sock
    user=mysql
    server-id               = 2
    log_error                = /var/log/mysql/slave-error.log

    relay-log = /var/log/mysql/relay.log
    relay-log-info-file = /var/log/mysql/relay-log.info
    relay-log-index = /var/log/mysql/relay-log.index

    master-host = 127.0.0.1
    master-port = 3306
    master-user = replicant
    master-password = replicator

Setting Up Init Scripts on Ubuntu with Upstart
----------------------------------------------

You will need to files in /etc/init/ if you want 2 instances of mysql.
Here is an example of each: (These are taken from Ubuntu Lucid 10.04)

    # MySQL Service

    description     "MySQL Server"
    author          "Mario Limonciello <superm1@ubuntu.com>"

    start on (net-device-up
              and local-filesystems
          and runlevel [2345])
    stop on runlevel [016]

    respawn

    env HOME=/etc/mysql
    umask 007

    pre-start script
        #Sanity checks
        [ -r $HOME/my.cnf ]
        [ -d /var/run/mysqld ] || install -m 755 -o mysql -g root -d /var/run/mysqld
        # Load AppArmor profile
        if aa-status --enabled 2>/dev/null; then
            apparmor_parser -r /etc/apparmor.d/usr.sbin.mysqld || true
        fi
        LC_ALL=C BLOCKSIZE= df --portability /var/lib/mysql/. | tail -n 1 | awk '{ exit ($4<4096) }'
    end script

    script
        if [ "$RUNLEVEL" = "0" -o "$RUNLEVEL" = "1" -o "$RUNLEVEL" = "6" ]; then
            exec /usr/bin/mysqld_multi stop 1
        else
            exec /usr/bin/mysqld_multi start 1
        fi
    end script

    post-start script
        for i in `seq 1 30` ; do
            /usr/bin/mysqladmin --defaults-file="${HOME}"/debian.cnf ping && {
                exec "${HOME}"/debian-start
                # should not reach this line
                exit 2
            }
            sleep 1
        done
        exit 1
    end script

And Number 2 (the slave):

    # MySQL Service slave

    description     "MySQL Server"
    author          "Mario Limonciello <superm1@ubuntu.com>"

    start on (net-device-up
              and local-filesystems
          and runlevel [2345])
    stop on runlevel [016]

    respawn

    env HOME=/etc/mysql
    umask 007


    script
        if [ "$RUNLEVEL" = "0" -o "$RUNLEVEL" = "1" -o "$RUNLEVEL" = "6" ]; then
            exec /usr/bin/mysqld_multi stop 2
        else
            exec /usr/bin/mysqld_multi start 2
        fi
    end script

So you have the /etc/init/mysql.conf and /etc/init/mysql-slave.conf, now
you should be able to start them: service mysql start service
mysql-slave start

Setting Up Init Scripts on Centos / Redhat
------------------------------------------

This is more complicated than upstart.

One way to do it is with a mysqld\_multi script, that inidividual
mysql\_X scripts can call.

-   [mysqld\_multi init script](mysqld_multi init script "wikilink")
-   [mysql\_1 init script](mysql_1 init script "wikilink")

Then Run: chkconfig mysqld off chkconfig mysql\_1 on chkconfig mysql\_2
on

