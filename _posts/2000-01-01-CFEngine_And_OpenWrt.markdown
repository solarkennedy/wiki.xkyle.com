---
categories:
 - CFEngine
 - OpenWrt
---
With a recent patch to include <CFEngine> in <Openwrt>, we now have the
capability to use CFEngine to manage large systems of openwrt based
servers, access points,
[Dockstars](Install Openwrt on a Seagate Dockstar "wikilink"), whatever!
Awesome!

### Installing CFEngine on Openwrt

The [CFEngine
patch](https://lists.openwrt.org/pipermail/openwrt-devel/2011-May/011023.html)
by Christoph König is not yet integrated into Openwrt Upstream as of
this writing. This means compiling it yourself for the platform you need
using the Openwrt SDK. If you feel trusting you can download my package
built for the <Dockstar>:
<http://download.xkyle.com/ipkg/cfengine_2.2.10-1_kirkwood.ipk>

### Defining OpenWRT Systems (class) in CFEngine

In my update.conf and cfagent.conf, I define a openwrt class first, then
I can use that distinction to define other actions later on.
Specifically I define my working directory as /etc/cfengine to make sure
files go where they are expected:

    classes:
      openwrt = ( FileExists(/etc/openwrt_release) )

    control:
      actionsequence  = ( copy )
      domain          = ( YourCompany.com )
      policyhost      = ( CFengine.YourCompany.com  )
      sysadm          = ( ITguy@YourCompany.com )

      # This is with an ubuntu cfengine master server
      master_cfinput  = ( /var/lib/cfengine2/masterfiles/inputs )
      master_cffiles  = ( /var/lib/cfengine2/masterfiles/files )

      # The openwrt cfengine package likes things to be in /etc/cfengine
      openwrt::
      repository      = ( /etc/cfengine/outputs )
      workdir         = ( /etc/cfengine/ )

### Using Opkg to Manage Packages

    classes:
        openwrt::
        has_opkg_updates = ( FileExists(/var/opkg-lists/packages) )

    control:
        openwrt::
            DefaultPkgMgr      = ( dpkg )
            DPKGInstallCommand = ( "/bin/opkg install %s" )
            DPKGRemoveCommand  = ( "/bin/opkg remove %s" )

    packages:
        openwrt::
            vim-full action=install 

    shellcommands:
        !has_opkg_updates::
            "/bin/opkg update"

This is not 100% ideal. Depending on your action sequence, you may not
get the updated package list *before* the packages section. Eh, it can
wait till next time. Or, this is a wiki, if you have a better solution
by all means press the edit button :)

Also, since CFEngine was not build with opkg in mind, comparing versions
and such don't work. In fact, it can't really even know if something is
installed or not, so it just opkg installs everything on your list.
Luckily opkg is super fast, so it is not much of a waste.

### TODO

Write a apt-cache for openwrt to fake out cfengine? Patch cfengine to be
opkg aware?

