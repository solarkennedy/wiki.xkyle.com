---
categories:
 - Linux
 - SELinux
 - Security
---
So SELinux is on and you think it is interfering? You can run:
setenforce 0

To turn it off, does it work now? It does? Well lets append the SELinux
policy to allow what you are trying to do!

The troubleshooting Processing
------------------------------

Here is how to fix something that is broken because of SELinux. Lets say
this real life-example is that you want to put some web content in
/home/httpd/kyle.com/html, but SELinux won't allow apache to access that
directory. Here is how to fix it

First take a look at the audit log to see if this really is the problem:
tail /var/log/audit/audit.log type=AVC msg=audit(1257532299.305:87917):
avc: denied { write } for pid=3939 comm="httpd" name="logs" dev=dm-0
ino=1707853 scontext=root:system\_r:httpd\_t:s0
tcontext=root:object\_r:user\_home\_t:s0 tclass=dir type=AVC
msg=audit(1257532360.458:87918): avc: denied { getattr } for pid=3950
comm="httpd" path="/home/httpd/xkyle.com/html" dev=dm-0 ino=1707854
scontext=root:system\_r:httpd\_t:s0
tcontext=root:object\_r:user\_home\_t:s0 tclass=dir

You could also do a tail -f on it and perform some action to see it
happen in progress. So we have some denied errors, apache is somehow
reaching for something out of context. Well lets build a new policy that
allows this behaviour, then load it: cat /var/log/audit/audit.log |
audit2allow

This will show you an aggregation of the errors and format it. If you
want all those things to be in the new policy, run this: cat
/var/log/audit/audit.log | audit2allow -M local

Now let us load (install) it semodule -i local.pp

You can delete the local.\*, semodule puts a copy in
/etc/selinux/targeted/modules/active/modules/

Setbool for more options
------------------------

There are some toggles for SELinux! Take a look at them with: getsebool
-a

See some that you think you need? Here is an example: setsebool -P
httpd\_can\_network\_connect=1

This allows httpd to make outbound connections. The -P makes it
permanent and puts the option on disk so it survives a reboot.

Are there things that are not spiting out errors to audit.log?
--------------------------------------------------------------

So you have some policy, but something STILL isn't working? There might
be something that is configured to specifically not show up in the audit
log. Let's turn these on! But try to keep it on for only a little while,
because you don't want to fill your new policy with all sorts of junk.
So run: semodule -BD

Then do the thing that doesn't work. Then run: semodule -B

To turn it back to normal. Now run the audit2allow to see if you get
some new stuff to make a better policy.

