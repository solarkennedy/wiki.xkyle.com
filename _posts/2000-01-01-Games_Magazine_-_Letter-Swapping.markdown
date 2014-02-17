---
categories:

---
Letter-Swapping is a [Games Magazine](Games Magazine "wikilink") puzzle
that is kinda complicated. You have two columns of Words, and the a
letter swaps from each side. In fact, I still don't really understand
it, I'm going to present the instructions verbatim from the magazine:

Some words are so compatible that they can exchange letters, like pen
pals. For example, LETTER and SWAPPING can trade the L and W to make
WETTER and SLAPPING. In the puzzles below, you'll make such swaps
between the soul mates in opposite columns. In puzzle A, for example,
you can switch the C in RECENT with the P in RAPIER to create REPENT and
RACIER. But beware - some switches have hitches and may land you in the
dead letter office! Once you've made an exchange, put the switched
letters in teh spaces provided. In the example, C is placed in the space
next to RECENT and P in the space beside RAPIER. If you've made all the
right swaps, the two groups of letters will spell out two more soul
mates that can exchange letters. Making that switch leads to each
muzzle's final answer. So swap 'til you drop!

    #!/bin/bash
    for EACHWORD in `cat col1` 
    do
    #EACHWORD=recent
        LETTERCOUNTER=0
        WORDLENGTH=`echo -n $EACHWORD | wc -c`
        for EACHLETTER in `echo -n $EACHWORD | sed 's/./&\n/g'`
        do
            for NEWLETTER in `cat thealphabet`
            do  
                #replace that letter with a differeint one
                NEWWORD="${EACHWORD:0:$LETTERCOUNTER}$NEWLETTER${EACHWORD:$LETTERCOUNTER+1:$WORDLENGTH}"
                OLDLETTER="${EACHWORD:$LETTERCOUNTER:1}"
                if [ "$NEWWORD" != "$EACHWORD" ]; then   #WE cannot have the same word again
                    grep -x $NEWWORD /usr/share/dict/words > /dev/null
                    if [ $? -eq 0 ]; then #Our new word is legit
                        
                    echo A new word is $NEWWORD
                                


                        

                    for CANDIDATE in `grep $NEWLETTER col2`
                    do
                    NEWWORD2=`echo $CANDIDATE | sed "s/$NEWLETTER/$OLDLETTER/" `
                    grep -x $NEWWORD2 /usr/share/dict/words > /dev/null
                                    if [ $? -eq 0 ]; then #Our new word is legit
                    #echo "Our new word is $NEWWORD (exchanged $OLDLETTER for $NEWLETTER on space $LETTERCOUNTER)  "
                    echo -n "$OLDLETTER $EACHWORD ($NEWWORD)"
                    echo -e  "\t $NEWLETTER $CANDIDATE ($NEWWORD2)"
                    fi
                    
                    done
                                            





                    fi
                fi 
            done
        let LETTERCOUNTER=$LETTERCOUNTER+1
        done
            


    done

[Category:Games Magazine](Category:Games Magazine "wikilink")
