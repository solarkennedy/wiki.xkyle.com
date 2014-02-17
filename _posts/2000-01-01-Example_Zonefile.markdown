And example zone file for xkyle.com:

    xkyle.com.  86400   IN  SOA ns1.he.net. hostmaster.he.net. (
                        2010121005  ; Serial
                        10800   ; Refresh
                        1800    ; Retry
                        604800  ; Expire
                        86400 ) ; Minimum TTL
    xkyle.com.  86400   IN  NS  ns1.he.net.
    xkyle.com.  86400   IN  NS  ns2.he.net.
    xkyle.com.  86400   IN  TXT "v=spf1 ip4:64.111.100.0/24 ip4:66.33.201.0/24 ip4:66.33.216.0/24 ip4:208.97.132.0/24 ip4:208.97.187.0/24 ip4:208.113.200.0/24 ip4:208.113.244.0/24 ip4:208.113.175.0/24 include:_spf.google.com -all"
    xkyle.com.  86400   IN  MX  10 aspmx.l.google.com.
    dev.xkyle.com.  86400   IN  A   75.119.198.87
    wiki.xkyle.com. 86400   IN  A   69.163.141.10
    www.xkyle.com.  86400   IN  A   69.163.141.10
    ipv6.xkyle.com. 86400   IN  AAAA    2001:470:1f05:6ca:0:0:0:1
    docs.xkyle.com. 86400   IN  CNAME   ghs.google.com.
    mail.xkyle.com. 86400   IN  CNAME   ghs.google.com.
    xkyle.com.  86400   IN  A   69.163.141.10
    *.xkyle.com.    86400   IN  A   66.35.48.52
    cal.xkyle.com.  86400   IN  CNAME   calendar.xkyle.com.
    $include /etc/bind/keys/Kxkyle.com.+005+22726.key  ; //KSK;
    $include /etc/bind/keys/Kxkyle.com.+005+43308.key  ; //ZSK

And an example line to include this zone in bind as a master:

    zone "xkyle.com"
    {
        type master;
        file "/etc/bind/db.xkyle.com";
        allow-transfer {4.2.2.2;};
    };

And how to include it as a slave:

    zone "xkyle.com"
    {
        type slave;
        file "secondary/db.xkyle.com";
        masters { 8.8.8.8; };
    };

And how to confirm that you can transfer the zone from the slave server
(8.8.8.8 in this example):

    dig xkyle.com @4.2.2.2 AXFR

[Example Relative Zonefile](Example Relative Zonefile "wikilink")

<Category:DNS> <Category:Bind>
