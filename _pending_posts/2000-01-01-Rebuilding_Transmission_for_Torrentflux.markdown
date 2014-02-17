---
categories:
 - Transmission
 - Deb
---
Torrentflux is a great bittorrent client, even for the command line, and
must be patched to work with torrentflux.

Rebuilding The Package
----------------------

First, get the patch here: ![](Tf-transmission-1.72.patch.txt "image")

Rename it to just patch: mv Tf-transmission-1.72.patch.txt
Tf-transmission-1.72.patch

Download the source packages

    cd /usr/local/src/
    apt-get build-dep transmission-cli
    apt-get source transmission-cli
    cd transmission-1.72/
    # Move the patch into this directory
    # mv /home/kyle/Downloads/tf-transmission-1.72.patch .
    patch < tf-transmission-1.72.patch 
    dpkg-buildpackage -rfakeroot

Installing the Package
----------------------

`cd ..`\
`dpkg -i *.deb`

Now hold the package to make sure that future upgrades don't overwrite
your work: echo transmission-cli hold | dpkg --set-selections echo
transmission-daemon hold | dpkg --set-selections echo transmission-dbg
hold | dpkg --set-selections echo transmission-gtk hold | dpkg
--set-selections

Configuring Torrentflux
-----------------------

You can setup torrentflux to use transmission-cli as the default BT
client. Make sure you have the path set correctly in the setup.

There is also some sql magic you can run to convert all your existing
torrents, but I forgot the magic.

Other Patches
-------------

![](Transmission-1.77-cli.c.txt "image")

