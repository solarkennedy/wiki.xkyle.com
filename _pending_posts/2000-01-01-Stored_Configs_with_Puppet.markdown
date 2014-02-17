---
categories:
 - Puppet
 - Mysql
---
This is how to configure <Puppet> to use stored configs. Stored configs
in puppet allow for clients to push back configuration like ssh keys,
nagios configs, etc into the Puppetmaster's database.

### Sqlite3 Backend

Packages: apt-get install sqlite3 libsqlite3-ruby ruby-activerecord

Puppet.conf on the puppetmaster: [master] storeconfigs = true dbadapter
= sqlite3 The sqlite backend is not usable with more than a few clients
due to locking issues. The databse ends up in
/var/lib/puppet/state/clientconfigs.sqlite3

### Mysql Backend

Packages: apt-get install mysql-client libmysql-ruby

Database Setup: \# mysql -u root -p mysql\> create database puppet;
mysql\> grant all privileges on puppet.\* to puppet@localhost identified
by 'password';

Puppet.conf on the puppetmaster: [master] storeconfigs = true dbadapter
= mysql dbuser = puppet dbpassword = password dbserver = localhost
dbsocket = /var/run/mysqld/mysqld.sock

### References

-   <http://projects.puppetlabs.com/projects/puppet/wiki/Using_Stored_Configuration>
-   <http://projects.puppetlabs.com/projects/1/wiki/My_Sql_Stored_Configuration_Patterns>

