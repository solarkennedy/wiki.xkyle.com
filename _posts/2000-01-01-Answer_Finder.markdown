---
categories:
 - Scripts
---
This script compares a file of inputed questions and tries to find
strings that best fit, which are usually the answers. It is configured
for the questions to be in a standard text file called q.txt and the
answer text (usually the ebook or conglomeration of input data) in a.txt

This program requires the tre-agrep and the agrep programs which are
both in the apt repositories: apt-get install tre-agrep agrep

Using the different programs you can get slightly different results, one
of them will probably be the answer.

And on with the code. The output is a stream of html, just direct it to
an html file for easy reading.

    #!/bin/bash
    LINES=`cat q.txt | wc -l`
    for EACHLINE in `seq 1 $LINES`
    do
       LINE=`sed -n "$EACHLINE p" q.txt`
       echo -n '<font color="green">' 
       echo -n "$LINEORIG"
       echo '</font><br>'
       echo -n '<font color="red">'
       LINE1=`echo $LINE | cut -c 5-30`
       tre-agrep -i -B "$LINE" a.txt
       echo "<br>" 
       tre-agrep -w -i -B "$LINE" a.txt
       echo '</font><br>'
       echo -n '<font color="660000">'
       agrep -i -By "$LINE1" a.txt
       echo '</font><br><br>'
    done

Use it like this: bash script.sh \> output.html

