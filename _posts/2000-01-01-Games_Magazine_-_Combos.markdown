---
categories:

---
Combos is a [Games Magazine](Games Magazine "wikilink") puzzle where one
must find Disney animated films that have a series of letters in the
title. An example is "erpa = Peter Pan" because the letters e,r,p,a
appear in Peter Pan in that order. Sounds like a perfect job for Grep!

Code
----

Here is the code:

    #!/bin/bash
    for LETTER in `echo $1 | sed 's/./&\n/g'`
    do
    COMMAND="$COMMAND ?$LETTER"
    done
    exec egrep -e "$COMMAND" list

Explaination
------------

The code outputs an grep command like this: grep -e ' ?n ?d ?w' list The
class " ?" matches a possible blank space, then we have a "n", then any
number of characters, and so on. The above shell script just makes it
easy to create those reg-ex's.

The List
--------

Here is the list from
[here](http://www.disneyanimation.com/aboutus/history.html):

    snow white and the seven dwarfs
    pinocchio
    fantasia
    dumbo
    bambi
    saludos amigos
    the three caballeros
    make mine music
    fun and fancy free
    melody time
    the adventures of ichabod and mr. toad
    cinderella
    alice in wonderland
    peter pan
    lady and the tramp
    sleeping beauty
    101 dalmatians
    the sword and the stone
    the jungle book
    the aristocats
    robin hood
    the many adventures of winnie the pooh
    the rescuers
    the fox and the hound
    the black cauldron
    the great mouse detective
    oliver & company
    the little mermaid
    the rescuers down under
    beauty and the beast
    aladdin
    the lion king
    pocahontas
    the hunchback of notre dame
    hercules
    mulan
    tarzan
    fantasia 2000
    dinosaur
    the emperor’s new groove
    atlantis: the lost empire
    lilo and stitch
    treasure planet
    brother bear
    home on the range
    chicken little
    meet the robinsons
    bolt

In action
---------

    kyle@kyle-laptop:~$ ./combo.sh  ndw
    snow white and the seven dwarfs

[Category:Games Magazine](Category:Games Magazine "wikilink")
