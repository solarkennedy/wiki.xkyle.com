---
categories:
 - Samba
---
Samba by default will not allow symlinks to go outside of a share for
[security reasons.](http://www.samba.org/samba/news/symlink_attack.html)

But sometimes you need to do this anyway.

First add this to your global conf to stop people from making bogus
symlinks:
[ref](http://www.samba.org/samba/docs/man/manpages-3/smb.conf.5.html#UNIXEXTENSIONS)
[global] unix extensions = no

Then add this to a share to allow symlinks to go to places outside the
share:
[ref](http://www.samba.org/samba/docs/man/manpages-3/smb.conf.5.html#WIDELINKS)
[share] \#Allows symlinks to traverse outside the share wide links = yes

