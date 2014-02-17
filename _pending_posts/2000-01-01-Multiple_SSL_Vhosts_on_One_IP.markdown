---
categories:
 - Apache
 - SSL
---
### Introduction

-   **Problem**: Standard SSL assumes one service per IP, per port,
    which means multiple vhosts each need an IP for SSL support.
-   **Solution**: Server Name Inidcation. This is a way for a client to
    tell a server which hostname it is after, before it gets the Cert.
    See <http://en.wikipedia.org/wiki/Server_Name_Indication>

### Howto

<http://wiki.apache.org/httpd/NameBasedSSLVHostsWithSNI>

    # Ensure that Apache listens on port 443
    Listen 443
        
    # Listen for virtual host requests on all IP addresses
    NameVirtualHost *:443

    # Go ahead and accept connections for these vhosts
    # from non-SNI clients
    SSLStrictSNIVHostCheck off

    <VirtualHost *:443>
      # Because this virtual host is defined first, it will
      # be used as the default if the hostname is not received
      # in the SSL handshake, e.g. if the browser doesn't support
      # SNI.
      DocumentRoot /www/example1
      ServerName www.example.com

      # Other directives here

    </VirtualHost>

    <VirtualHost *:443>
      DocumentRoot /www/example2
      ServerName www.example2.org

      # Other directives here

    </VirtualHost>

### Gotchas

See:
<http://en.wikipedia.org/wiki/Server_Name_Indication#Unsupported_operating_systems.2C_browsers.2C_and_libraries>

For a list of applications/browsers/operating systems that do not
support this. The big one is IE on XP.

### Nagios Checks

To check for certificate experiration, use this check command. On at
lease Ubuntu 10.04 it is SNI aware:

    define command{
            command_name    check_certificate
            command_line    /usr/lib/nagios/plugins/check_http --ssl -H '$HOSTNAME$' -C 14
            }

    define service{
        hostgroup ssl-hosts
        service_description Certificate Expiration
        check_command check_certificate
        use generic-service
    }

### See Also

-   <Apache>
-   <SSL>

