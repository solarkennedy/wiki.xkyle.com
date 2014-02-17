### Requirements

Get your kernel debug stuff: yum install kernel-devel yum-utils
debuginfo-install kernel-2.6.32-131.0.15.el6.x86\_64

Warning: This is \*not\* kernel-debug, that is different. In the end you
need: kernel-debuginfo kernel-debuginfo-common-arch kernel-devel

### Test it

When you do not have debuginfo: stap -v -e 'probe vfs.read {printf("read
performed\\n"); exit()}' Pass 1: parsed user script and 76 library
script(s) using 97488virt/22472res/2816shr kb, in 80usr/10sys/84real ms.
WARNING: cannot find module kernel debuginfo: No DWARF information found
semantic error: no match while resolving probe point
kernel.function("vfs\_read") semantic error: no match while resolving
probe point vfs.read Pass 2: analyzed script: 0 probe(s), 0 function(s),
0 embed(s), 0 global(s) using 132280virt/35176res/7552shr kb, in
60usr/160sys/13441real ms. Pass 2: analysis failed. Try again with
another '--vp 01' option.

When it is working: Pass 1: parsed user script and 45 library script(s)
in 340usr/0sys/358real ms. Pass 2: analyzed script: 1 probe(s), 1
function(s), 0 embed(s), 0 global(s) in 290usr/260sys/568real ms. Pass
3: translated to C into
"/tmp/stapiArgLX/stap\_e5886fa50499994e6a87aacdc43cd392\_399.c" in
490usr/430sys/938real ms. Pass 4: compiled C into
"stap\_e5886fa50499994e6a87aacdc43cd392\_399.ko" in
3310usr/430sys/3714real ms. Pass 5: starting run. read performed Pass 5:
run completed in 10usr/40sys/73real ms.

### References

-   <https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/SystemTap_Beginners_Guide/using-systemtap.html>

