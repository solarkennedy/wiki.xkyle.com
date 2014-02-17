To watch youtube videos in a stream of conciousness way:

    #!/bin/bash
    while [ 1 ]; 
    do 
       for EACHVIDEO in `wget -O - -q "http://search.twitter.com/search.atom?q=youtube.com" | grep http://www.youtube.com | grep "<content" | sed 's/quot;/\n/g' | grep "http://www.youtube.com" | cut -f 1 -d "&" `
       do
          totem --enqueue `./youtube-dl -g -b "$EACHVIDEO" ` &
          sleep  2s
       done
       sleep 30s
    done

You need the [youtube-dl](http://bitbucket.org/rg3/youtube-dl/wiki/Home)
script.

<Category:Scripts> <Category:Linux>
