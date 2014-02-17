<CFEngine> is a great tool for managing linux firewalls.

### Method 1: Using Copy

    control:
            any::
            AllowRedefinitionOf  = ( firewall_file )
                    firewall_file = ( $(common_conf)/firewalls/firewall.any )
            server::
                    firewall_file = ( $(common_conf)/firewalls/firewall.servers )
            laptops::
                    firewall_file = ( $(common_conf)/firewalls/firewall.laptops )

    copy:
            any::
                    $(firewall_file)  dest=/etc/sysconfig/iptables.cfengine
                            mode=400
                            owner=root
                            group=root
                            server=$(policyhost)
                            verify=true
                            backup=false
                            define=reload_iptables

    shellcommands:
           reload_iptables::
                   "/etc/init.d/iptables restart"

### Method 2: Editfiles

    editfiles:

            ## AMANDA ##
            configure_amanda::
                    { /etc/sysconfig/iptables
                            CatchAbort
                            BeginGroupIfNoLineMatching "^#\s+Backups.*$"
                                    LocateLineMatching "-A RH-Firewall-1-INPUT -j REJECT --reject-with icmp-host-prohibited"
                                    BeginGroupIfMatch "-A RH-Firewall-1-INPUT -j REJECT --reject-with icmp-host-prohibited"
                                            IncrementPointer  "-1"
                                            InsertLine "# Backups"
                                            InsertLine "-A RH-Firewall-1-INPUT -j ACCEPT -s amanda.host"
                                            InsertLine "-A RH-Firewall-1-INPUT -j ACCEPT -s amanda.host"
                                            InsertLine "# END Backups"
                                    EndGroup
                            EndGroup
                    }

<Category:CFEngine> <Category:Linux> <Category:Syadmin>
<Category:iptables>
