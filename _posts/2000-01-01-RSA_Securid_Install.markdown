RSA Tokens are cool, but the linux installer that they comes with is
kinda bulky. If you are installing it widely, its good to know exactly
what files the installer is using, especially for <CFEngine> purposes.

### Needed Files

Here are the important files that the securid pam module needs:

-   /var/ace/\* (contains key and some test binaries)
-   /lib64/security/pam\_securid.so (actual pam module, also 32 bit in
    /lib if you need that)
-   /etc/sd\_pam.conf (conf file)

Technically you could probably slim it down even more and edit the
sd\_pam.conf to keep things even cleaner.

The rest have to do with your particular deployment. (ssh, logins, sudo,
etc) That is outside the scope of this article and has more to do with
your pam configuration. A sudo example is included in the glue below:

### CFEngine Glue

    files:
        securid_servers::
            /var/ace/
            mode=700
            owner=root
            group=root
            action=create

    copy:   
        securid_servers::
                    #Recrusivly copy this dir, has key and binaries
            $(common_conf)/var/ace/  dest=/var/ace/
                mode=755
                owner=root
                group=root
                server=$(policyhost)
                verify=true
                backup=timestamp
                recurse=inf

            #Being lazy here, could do 32 bit too if we had 32bit servers
            $(common_conf)/lib64/security/pam_securid.so  dest=/lib64/security/pam_securid.so
                mode=755
                owner=root
                group=root
                server=$(policyhost)
                verify=true
                backup=timestamp
            
            $(common_conf)/etc/sd_pam.conf  dest=/etc/sd_pam.conf
                            mode=644
                            owner=root
                            group=root
                            server=$(policyhost)
                            verify=true
                            backup=timestamp
            
            # We have an extra class here for those servers that securid_sudo
            # Some day we might have a securid_server that isn't for sudo, but for ssh or something
            # Also, the pam stuff is redhat specific

            # I guess I could do this with edit files, but I prefer copy as it allows the files themselves to be self-documenting.
            # Plus when you are on the server and you look at the file it yells at you "HEY MADE BY CFENGINE!"
        securid_servers.securid_sudo_servers.redhat::
            $(common_conf)/etc/pam.d/securid-auth  dest=/etc/pam.d/securid-auth
                            mode=644
                            owner=root
                            group=root
                            server=$(policyhost)
                            verify=true
                            backup=timestamp
            
            $(common_conf)/etc/pam.d/sudo-securid-rhel  dest=/etc/pam.d/sudo
                            mode=644
                            owner=root
                            group=root
                            server=$(policyhost)
                            verify=true
                            backup=timestamp

            $(common_conf)/etc/pam.d/sudo-i-securid-rhel  dest=/etc/pam.d/sudo-i
                            mode=644
                            owner=root
                            group=root
                            server=$(policyhost)
                            verify=true
                            backup=timestamp

### Pam Notes

The securid-auth file is just the normal system-auth file, but with
pam\_unix replaced with pam\_securid.

The sudo pam file is just the normal sudo file, but with system-auth
replaced with securid-auth.

<Category:RSA> <Category:SecurID> <Category:CFEngine>
<Category:Security>
