---
categories:

---
This [Games Magazine](Games Magazine "wikilink") puzzle requires you to
look at pictures and try to find words that get their first letters
chopped off one at a time to make new words. (3 of them).

Be sure to run:

    sudo apt-get install wamerican

to get /usr/share/dict/words.

    #!/bin/bash
    for EACH1 in `grep "^.....*" /usr/share/dict/words`
    do
        EACH2=`echo $EACH1 | cut -c 2-50`
        grep "^$EACH2$" /usr/share/dict/words > /dev/null
        if [ $? -eq 0 ]; then
            EACH3=`echo $EACH1 | cut -c 3-50`
            grep "^$EACH3$" /usr/share/dict/words >/dev/null
            if [ $? -eq 0 ]; then
            echo "$EACH1 -> $EACH2 -> $EACH3"
            fi
        fi
    done

[Category:Games Magazine](Category:Games Magazine "wikilink")
