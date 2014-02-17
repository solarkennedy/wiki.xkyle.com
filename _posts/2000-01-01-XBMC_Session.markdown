You can run <XBMC> in a stripped down session. Put this in \~/.xsession

    xset -dpms
    xset s off
    /usr/bin/pulseaudio --start --log-target=syslog
    /usr/bin/synergyc 10.0.2.120
    /usr/bin/xbmc

<Category:XBMC>
