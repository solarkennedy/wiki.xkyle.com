CFEngine is a tool to do configuration management across your servers.
This allows you to be consistent with your installs. It also allows
servers to heal themselves, even if they are down for maintenance. It is
the bomb.

### Creating CFEngine Boilerplate

CFEngine requires two essential config files, update.conf and
cfagent.conf.

#### update.conf

update.conf should almost ever change. It offers a failsafe to make sure
that updates get pushed, even if you make a mistake.

    # Example Update.conf
    # Taken from the example debian update.conf
    control:
       actionsequence  = ( copy tidy )  # Keep this simple and constant
       domain          = ( xkyle.com ) 
       policyhost      = ( cfengine.xkyle.com )
       master_cfinput  = ( /var/lib/cfengine2/masterfiles/inputs ) 
       workdir         = ( /var/cfengine )
      SplayTime = ( 1 )

    copy:
         $(master_cfinput)            dest=$(workdir)/inputs
                                      r=inf
                                      mode=700
                                      server=$(policyhost)
                                      trustkey=true
                                      verify=true

    tidy:
         # Cfexecd stores output in this directory.
         # Make sure we don't build up files and choke on our own words!
         $(workdir)/outputs pattern=* age=7

#### cfagent.conf

cfagent.conf gets read after update.conf. Try to keep it simple and use
import to keep configuration files manageable.

    control:
      domain = ( xkyle.com )
      access = ( root )
      cfrunCommand = ( "/usr/sbin/cfagent" )
      actionsequence = (
         packages
         copy
         files
         editfiles
         links
         tidy
         shellcommands
      )
      maxage = ( 7 )

      AllowRedefinitionOf = ( master_inputs )
      AllowRedefinitionOf = ( master_files )

      any::
      master_inputs   = ( /var/lib/cfengine2/inputs )
      master_files    = ( /var/lib/cfengine2/files )

      openwrt::
      master_inputs   = ( /etc/cfengine/inputs )
      master_files    = ( /etc/cfengine/files )

      redhat::
      master_inputs   = ( /var/cfengine/inputs )
      master_files    = ( /var/cfengine/files )

    import: 
        classes.conf
        import.conf

### Other Examples To Get Going

#### Using Imports

Start with a import.conf to import subsequent import files:

    import:
            any::
            any/import.cf
        desktops::
                desktops/import.cf
        servers::
                servers/import.cf
        cloud_xkyle_com::
                cloud.xkyle.com/import.cf

An example import file:

    import:
            any/motd.cf
            any/root-ssh-keys.cf
            any/package-manager.cf
            any/cfengine.cf
            any/etc.cf

#### In General

    action:
        some_class::
            something
            other_class::
                    do something else
                    define=additional_action_needed

    nextaction:
        some_class::
            something
            other_class::
                    do something else
            additiona_action_needed::
                    restart service with new config file

<Category:CFEngine>
