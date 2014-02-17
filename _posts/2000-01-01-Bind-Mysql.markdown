---
categories:
 - Mysql
 - DNS
 - Bind
---
Ubuntu by default does not have a package with bind-mysql-dlz installed.
Here is how to build one:

`mkdir -p /usr/local/src/bind9`\
`cd /usr/local/src/bind9`\
`apt-get install fakeroot bison`\
`apt-get source bind9`

You also need the mysqlclient-dev stuff so it will compile cleanly:
apt-get install libmysqlclient-dev

Now edit the config string so it builds with the mysql-dlz driver: cd
bind9\* vi debian/rules

Build it! dpkg-buildpackage -rfakeroot -b

If it worked go down a directory and install away! cd ..
dpkg-buildpackage -rfakeroot -b cd.. \#make sure you are in the right
directory obviously dpkg -i \*.deb

In named.conf.local you need this (edit at will):

    dlz "Mysql zone" {
       database "mysql
       {host=127.0.0.1 dbname=db_name user=db_user pass=db_pass}
       {select zone from dns_records where zone = '%zone%'}
       {select ttl, type, mx_priority, case when lower(type)='txt' then concat('\"', data, '\"') when lower(type) = 'soa' then concat_ws(' ', data, resp_person, serial, refresh, retry, expire, minimum) else data end from dns_records where zone = '%zone%' and host = '%record%'}";
    };

Make sure you have your sql set up. Here is the table structure:

     CREATE TABLE `dns_records` (
      `id` int(11) NOT NULL auto_increment,
      `zone` varchar(64) default NULL,
      `host` varchar(64) default NULL,
      `type` varchar(8) default NULL,
      `data` varchar(64) default NULL,
      `ttl` int(11) NOT NULL default '3600',
      `mx_priority` int(11) default NULL,
      `refresh` int(11) NOT NULL default '3600',
      `retry` int(11) NOT NULL default '3600',
      `expire` int(11) NOT NULL default '86400',
      `minimum` int(11) NOT NULL default '3600',
      `serial` bigint(20) NOT NULL default '2008082700',
      `resp_person` varchar(64) NOT NULL default 'resp.person.email',
      `primary_ns` varchar(64) NOT NULL default 'ns1.yourdns.here',
      `data_count` int(11) NOT NULL default '0',
      PRIMARY KEY  (`id`),
      KEY `host` (`host`),
      KEY `zone` (`zone`),
      KEY `type` (`type`)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1

And an example zone:

    insert into dns_records (zone, host, type, data, mx_priority) values ('domain.com', 'www', 'A', '1.2.3.4', null);
    insert into dns_records (zone, host, type, data, mx_priority) values ('domain.com', '@', 'A', '1.2.3.4', null);
    insert into dns_records (zone, host, type, data, mx_priority) values ('domain.com', 'www2', 'CNAME', 'www.domain.com.', null);
    insert into dns_records (zone, host, type, data, mx_priority) values ('domain.com', '@', 'MX', 'domain.com.', '0');

