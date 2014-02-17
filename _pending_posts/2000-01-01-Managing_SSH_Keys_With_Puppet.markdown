---
categories:
 - Puppet
 - SSH
---
First grab the auth.pp module from
[here](http://projects.puppetlabs.com/projects/puppet/wiki/Module_Ssh_Auth_Patterns).
It should go in your /etc/puppet/modules directory.

Then you can declare the presence or absence of authorized keys, like
this:

    ssh_authorized_key {
            "kyle@secure":
                    ensure  => present,
                    user    => root,
                    type    => "ssh-rsa",
                    key     => "AAAA......j";
            "root@badguy":
                    ensure  => absent,
                    user    => root,
                    type    => "ssh-rsa",
                    key     => "AAAAB.......";
    }

For good measure you can do this:

    file {
            "/root/.ssh/":
            path    => "/root/.ssh/",
            ensure  => directory,
            mode    => 700,
            owner   => root,
            group   => root;
            "/root/.ssh/authorized_keys":
            path    => "/root/.ssh/authorized_keys",
            mode    => 600,
            owner   => root,
            group   => root;
         }

### Global known\_hosts file management

Here is how you can use ssh keys as [Puppet Exported
Resources](Puppet Exported Resources "wikilink") to collect and
consolidate them into a the global /etc/ssh/known\_hosts file?

    class sshkeys {
     
      # Include partial hostname 'app1.site' in hosts like 'app1.site.company.com'.
      $partial_hostname = regsubst($fqdn, '\.company\.com$', '')
      if $partial_hostname == $hostname {
        $host_aliases = [ $ipaddress, $hostname ]
      } else {
        $host_aliases = [ $ipaddress, $hostname, $partial_hostname ]
      }
     
      # Export hostkeys from all hosts.
      @@sshkey { $fqdn:
        ensure => present,
        host_aliases => $host_aliases,
        type => 'rsa',
        key => $sshrsakey,
      }
     
      # Import hostkeys to all hosts.
      Sshkey <<| |>>
    }

#### References

-   <http://blog.askreet.com/?p=14>

