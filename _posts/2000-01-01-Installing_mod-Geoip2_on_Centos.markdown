This assumes that you will be using the free geoip database and you are
on a 64 bit system:

    yum install httpd-devel GeoIP GeoIP-data GeoIP-devel

    cd /usr/local/src/
    wget http://geolite.maxmind.com/download/geoip/api/mod_geoip2/mod_geoip2_1.2.5.tar.gz
    tar xzf mod_geoip2_1.2.5.tar.gz
    cd mod_geoip2_1.2.5

    apxs -i -a -L/usr/lib64 -I/usr/include -lGeoIP -c mod_geoip.c

Now setup your apache:

<http://www.maxmind.com/app/mod_geoip>

<Category:Apache>
