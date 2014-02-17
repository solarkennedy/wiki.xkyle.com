---
categories:
 - ESX
 - SNMP
---
### Prereqs

Download the perl toolkit from
<http://www.vmware.com/support/developer/viperltoolkit/index.html>

     sudo apt-get install libxml-libxml-perl libclass-methodmaker-perl libarchive-zip-perl libcrypt-ssleay-perl libssl-dev perl-doc libuuid-perl libdata-dump-perl libsoap-lite-perl

     #Download the vSphere SDK for Perl Linux Installer stuff
     tar xzf VMware-vSphere-Perl-SDK-5.0.0-422456.x86_64.tar.gz
     cd vmware-vsphere-cli-distrib/
     export http_proxy="" 
     export ftp_proxy="" 
     perl vmware-install.pl 

### Enable It

     # Show that it is off
     vicfg-snmp.pl --server <hostname> --username <username> --password <password> --show

     # Enable it
     vicfg-snmp.pl --server <hostname> --username <username> --password <password> --enable

     # Make sure it is on 
     vicfg-snmp.pl --server <hostname> --username <username> --password <password> --show

     # Enable a community string:
     vicfg-snmp.pl --server <hostname> --username <username> --password <password> -c public

### Test It

    # snmpwalk -v 2c -c public <hostname> | head
    iso.3.6.1.2.1.1.1.0 = STRING: "VMware ESX 5.0.0 build-474610 VMware, Inc. x86_64"
    iso.3.6.1.2.1.1.2.0 = OID: iso.3.6.1.4.1.6876.4.1
    iso.3.6.1.2.1.1.3.0 = Timeticks: (30781018) 3 days, 13:30:10.18
    iso.3.6.1.2.1.1.4.0 = STRING: "not set"
    iso.3.6.1.2.1.1.5.0 = STRING: "hostname"
    iso.3.6.1.2.1.1.6.0 = STRING: "not set"
    iso.3.6.1.2.1.1.7.0 = INTEGER: 72
    iso.3.6.1.2.1.1.8.0 = Timeticks: (0) 0:00:00.00
    iso.3.6.1.2.1.1.9.1.2.1 = OID: iso.3.6.1.6.3.1
    iso.3.6.1.2.1.1.9.1.2.2 = OID: iso.3.6.1.2.1.31

### References

<http://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1008065>

