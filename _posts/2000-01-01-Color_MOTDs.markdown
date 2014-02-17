Using Figlet / Toilet
---------------------

Color MOTDs on a linux server can add a splash of cooleness to a linux
server. A good tool to make these is a program called Toilet and Figlet.

`sudo apt-get install toilet figlet`

Now you can pipe text to them:

`echo My Hostname | toilet --metal --font future`

You can try other settings and fonts. Look [Here for a list of figlet
fonts](http://www.figlet.org/examples.html).

![](ToiletOutput.jpg "image")\
 Now just stick that into your MOTD:

`echo My Hostname | toilet --metal --font future > /etc/motd`

Or if you are using a newer ubuntu with a fancy motd, put it in your
motd.tail:

`echo My Hostname | toilet --metal --font future > /etc/motd.tail`

Using ANSI Escape Sequences
---------------------------

    CYAN='\033[0;36m'
    NOCOLOR="\033[0m"
    echo -e "${CYAN}Hello World${NOCOLOR}

See All Available Colors
------------------------

    T='gYw'   # The test text

    echo -e "\n                 40m     41m     42m     43m\
         44m     45m     46m     47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo

#### References

-   <http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html>

<Category:Linux>
