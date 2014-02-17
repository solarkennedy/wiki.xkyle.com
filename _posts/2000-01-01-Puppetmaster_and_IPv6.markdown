---
categories:
 - Puppet
 - IPv6
 - Sysadmin
 - Linux
---
### Puppetmasterd

If you are using <webrick> as the puppetmaster web server, then you need
to adjust your puppet.conf to get it to bind on IPv4 **and** <IPv6>.

Edit your /etc/puppet/puppet.conf like this:

    [master]
    #This is needed in the master section if you need ipv6 on webrick:
    bindaddress="::"

### Puppet Agent

