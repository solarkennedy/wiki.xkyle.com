---
categories:
 - SSL
---
Picking SSL Ciphers for a webserver is kind of a black art. There are
issues with older clients (Windows XP), PCI Compliance, ans speed. I
don't know what the deal really is.

### Examples

### Testing

`openssl s_client -host HOSTNAME -port 443`
`Another web tool to analyze your ciphers:`
[`https://www.ssllabs.com/ssltest/analyze.html`](https://www.ssllabs.com/ssltest/analyze.html)

#### References

-   <http://matt.io/technobabble/hivemind_devops_alert:_nginx_does_not_suck_at_ssl/ur>
-   <http://timelordz.com/wiki/SSL_Certificates>
-   <https://www.openssl.org/docs/apps/ciphers.html>

