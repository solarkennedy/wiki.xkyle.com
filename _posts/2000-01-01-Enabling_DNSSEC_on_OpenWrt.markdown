Openwrt's default dns "server" is dnsmasq. It is what is called a "stub
resolver", where it simply forwards dns queries to the dns servers that
you get from your cable modem's dhcp. It itself cannot do DNSSEC
functions, but it will forward on dnssec to the client as long as the
upstream dns server is DNSSEC aware.

### Pre Test

First, ask your local server a dnssec question:

cody@cody-laptop2:\~\$ dig @10.0.2.254 +dnssec debian.org

    ; <<>> DiG 9.7.3 <<>> @10.0.2.254 +dnssec debian.org
    ; (1 server found)
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 20738
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags: do; udp: 4000
    ;; QUESTION SECTION:
    ;debian.org.            IN  A

    ;; ANSWER SECTION:
    debian.org.     3569    IN  A   128.31.0.51
    debian.org.     3569    IN  A   206.12.19.7

    ;; Query time: 48 msec
    ;; SERVER: 10.0.2.254#53(10.0.2.254)
    ;; WHEN: Sun Jul 17 08:26:02 2011
    ;; MSG SIZE  rcvd: 71

Things to note here:

-   No RRSIG in the response.
-   No ad bit in the flags section
-   I don't know if this is actually debians ip address...

### Test Your Upstream DNSSEC Server

I'm lucky that Comcast is on the ball with regards to DNSSEC, and they
provide 75.75.75.75 and 75.75.76.76 as DNSSEC aware validating
resolvers. They are not pushing these out via DHCP to everyone just yet
though...

Lets make sure they work:


    cody@cody-laptop2:~$ dig @75.75.75.75 +dnssec debian.org

    ; <<>> DiG 9.7.3 <<>> @75.75.75.75 +dnssec debian.org
    ; (1 server found)
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 9556
    ;; flags: qr rd ra ad; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags: do; udp: 4000
    ;; QUESTION SECTION:
    ;debian.org.            IN  A

    ;; ANSWER SECTION:
    debian.org.     3600    IN  A   128.31.0.51
    debian.org.     3600    IN  A   206.12.19.7
    debian.org.     3600    IN  RRSIG   A 7 2 3600 20110813220550 20110716220550 12650 debian.org. d97ki0CKfhdmyegQ0dwcunkow4f3986EyKK/hXTE/22DhjPmC9Oe4egv pAKaR9iA0qXnwksFA4oVIhV1nTYuCTH8KAOO3jNq3f3to2T4jFyteGBJ +teOaZgBlXLjiYVzg9WzN3bvYbbX4GH0h2KLG13fS5bbyq6FOfbe/Itp JNjVzpEU/lOLqdacZpwlga+3

    ;; Query time: 95 msec
    ;; SERVER: 75.75.75.75#53(75.75.75.75)
    ;; WHEN: Sun Jul 17 08:24:44 2011
    ;; MSG SIZE  rcvd: 257

Things to note:

-   ad (authenticated data) flag **is** set.
-   RRSIG is there
-   Of course I'm trusting 75.75.75.75, but it isn't trusting anybody!
    :)

### Make That Change

So we know that 75.75.75.75 (or whatever you are using) **can** do
DNSSEC. All we have to do is tell dnsmasq on Openwrt to use it! Through
the magic of UCI:

    uci set network.wan.dns=75.75.75.75
    uci commit
    reboot

Or just edit /etc/config/network like this:

    #### WAN configuration
    config interface        wan
            option ifname   "eth0.1"
            option proto    dhcp
            option dns      75.75.75.75

You can't just restart dnsmasq here because this setting isn't for
dnsmasq, it is for Openwrt. It specifies that it should ignore the
incoming dns server from the dhcp lease.

### Test

If you are using a modern openwrt (backfire), then that really should be
it:

    cody@cody-laptop2:~$ dig @10.0.2.254 +dnssec debian.org

    ; <<>> DiG 9.7.3 <<>> @10.0.2.254 +dnssec debian.org
    ; (1 server found)
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 53893
    ;; flags: qr rd ra ad; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags: do; udp: 4000
    ;; QUESTION SECTION:
    ;debian.org.            IN  A

    ;; ANSWER SECTION:
    debian.org.     1722    IN  A   206.12.19.7
    debian.org.     1722    IN  A   128.31.0.51
    debian.org.     1722    IN  RRSIG   A 7 2 3600 20110813220550 20110716220550 12650 debian.org. d97ki0CKfhdmyegQ0dwcunkow4f3986EyKK/hXTE/22DhjPmC9Oe4egv pAKaR9iA0qXnwksFA4oVIhV1nTYuCTH8KAOO3jNq3f3to2T4jFyteGBJ +teOaZgBlXLjiYVzg9WzN3bvYbbX4GH0h2KLG13fS5bbyq6FOfbe/Itp JNjVzpEU/lOLqdacZpwlga+3

    ;; Query time: 56 msec
    ;; SERVER: 10.0.2.254#53(10.0.2.254)
    ;; WHEN: Sun Jul 17 08:56:01 2011
    ;; MSG SIZE  rcvd: 257

### Summary

All we did is change our upstream dns server to a DNSSEC aware one. This
wiki page is 1% configuration and 99% explanation.

<Category:OpenWrt> <Category:DNSSEC>
