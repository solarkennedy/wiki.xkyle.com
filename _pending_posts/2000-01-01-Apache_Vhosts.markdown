---
categories:
 - SSL
 - Apache
---
### Example

    # Listen for virtual host requests on all IP addresses
    NameVirtualHost *:80

    <VirtualHost *:80>

      DocumentRoot /www/example1
      ServerName www.example.com

      ErrorLog /var/log/apache2/vhost-error.log
      CustomLog /var/log/apache2/vhost-access.log combined

      # Other directives here

    </VirtualHost>

### SSL Example

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

### Centos Example

    <VirtualHost *:80>
        ServerAdmin webmaster@dummy-host.example.com
        DocumentRoot /www/docs/dummy-host.example.com
        ServerName dummy-host.example.com
        ErrorLog logs/dummy-host.example.com-error_log
        CustomLog logs/dummy-host.example.com-access_log common
    </VirtualHost>

