This script no longer works since Twitter disabled basic auth.

    #!/bin/ash
    wget --keep-session-cookies --http-user=email --http-password=pass \
     --post-data="status=Hellow World! It is `date +%T`" http://twitter.com:80/statuses/update.xml

<Category:Scripts>
