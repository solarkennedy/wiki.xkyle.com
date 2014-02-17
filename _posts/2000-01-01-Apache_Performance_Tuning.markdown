### Tuning MaxClients / ServerLimit

The Max amount of clients you can server, is likely limited by your
memory. It is a straight forward formula: MaxClients ≈ (RAM -
size\_all\_other\_processes)/(size\_apache\_process)

How big are your apache processes (in KB)? ps -ylC apache2 --sort:rss

Or top under the RSS column.

Example: \* System: VPS (Virtual Private Server), CentOS 4.4, with 128MB
RAM \* Apache: v2.0, mpm\_prefork, mod\_php, mod\_rewrite, mod\_ssl, and
other modules \* Other Services: MySQL, Bind, SendMail \* Reported
System Memory: 120MB \* Reported httpd process size: 7-13MB \* Assumed
memory available to Apache: 90MB

Optimal settings:

`   * StartServers 5`\
`   * MinSpareServers 5`\
`   * MaxSpareServers 10`\
`   * ServerLimit 15`\
`   * MaxClients 15`\
`   * MaxRequestsPerChild 2000`

### MPM Prefork Versus Worker Models

Perfork is the default way to do things. Its pretty good. The Worker
model is a more efficient way to do things, requiring less memory and
allowing more clients and more speed. Each process can communicate to
multiple clients.

The downside to this is that you have to use CGI to do any kind of
external processing like php. See [Using php-fcgi with Apache
Worker](Using php-fcgi with Apache Worker "wikilink")

If you are looking to speedup your application, there are probably some
other low-hanging-fruit to make it faster.

### KeepAlives

Keepalives can be good or bad, depending on your users. Sometimes it is
useful to use keepalives to let apache keep a connection and server
ready for a client that is going to make multiple requests. On the other
hand, that same client might open up 100 connections, and keepalives
will keep them open and unavailable to others for the
**KeepAliveTimeout**.

Example:

    # KeepAlive: Whether or not to allow persistent connections (more than
    # one request per connection). Set to "Off" to deactivate.
    #
    KeepAlive On

    #
    # MaxKeepAliveRequests: The maximum number of requests to allow
    # during a persistent connection. Set to 0 to allow an unlimited amount.
    # We recommend you leave this number high, for maximum performance.
    #
    MaxKeepAliveRequests 100

    #
    # KeepAliveTimeout: Number of seconds to wait for the next request from the
    # same client on the same connection.
    #
    KeepAliveTimeout 15

<Category:Apache>
