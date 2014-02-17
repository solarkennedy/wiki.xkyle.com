This example uses <HAProxy> to put <SSH> and <SSL> on the same port!

### Configuration

    defaults
      timeout connect 5s
      timeout client 50s
      timeout server 20s

    listen ssl :443
      tcp-request inspect-delay 2s
      acl is_ssl req_ssl_ver 2:3.1
      tcp-request content accept if is_ssl
      use_backend ssh if !is_ssl
      server www-ssl :444
      timeout client 2h

    backend ssh
      mode tcp
      server ssh :22
      timeout server 2h

### References

-   <https://dgl.cx/2010/01/haproxy-ssh-and-ssl-on-same-port>

<Category:SSH> <Category:SSL> <Category:HAProxy>
