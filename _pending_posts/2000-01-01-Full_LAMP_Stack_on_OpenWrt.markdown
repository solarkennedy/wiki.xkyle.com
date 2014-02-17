---
categories:
 - OpenWrt
 - Apache
 - Mysql
---
### Remove Luci Web Interface (optional)

`opkg remove luci luci-admin-core luci-admin-full luci-admin-mini luci-app-firewall luci-app-initmgr luci-cbi luci-core luci-http luci-i18n-english luci-ipkg luci-lmo luci-nixio luci-sgi-cgi luci-sys luci-theme-base luci-theme-openwrt luci-uci luci-uvl luci-web --force-removal-of-dependent-packages`\
`rm -rf /www/luci-static/`

### Apache

`opkg install apache` `Change your DocumentRoot to be /www`\
`vi /etc/apache/httpd.conf` `Start it up:`\
`apachectl start`

### Php

Install: opkg install php5-cgi php5-cli php5-mod-mysql

Add the cgi handler in /etc/apache/httpd.conf:

    echo "
     AddHandler application/x-httpd-php5 php
     Action application/x-httpd-php5 /cgi-bin/php-cgi
    " >> /etc/apache/httpd.conf

Link our php-cgi binary to be in the right spot: ln -s /usr/bin/php-cgi
/usr/share/cgi-bin/

And tell apache to follow symlinks for the cgi, adjust this in your
/etc/apache/httpd.conf:

    <Directory "/usr/share/cgi-bin">
        AllowOverride None
        Options FollowSymLinks
        Order allow,deny
        Allow from all
    </Directory>

And restart to take effect: apachectl restart

### Mysql

Install: opkg install mysql-server Or opkg install
<http://xkyle.com/packages/mysql-server_5.0.18-3_kirkwood.ipk>

Setup where you are going to store the data (datadir): vi /etc/my.cnf

Make that directory if it doesn't exist: mkdir /mnt/mysql/

Initialize the system tables: mysql\_install\_db --force

Then start your daemon: /etc/init.d/mysqld start

