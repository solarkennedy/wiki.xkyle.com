---
categories:
 - Puppet
---
### Prerequisites

This assumes you have <Puppet> installed with [stored
configs](Stored Configs with Puppet "wikilink") configured already.

### Server

```puppet
class nagios::server {
  package { [ "nagios" ]:
    ensure => latest;
  }
  service { "nagios":
    ensure => running,
    enabled => true,
  }
  
  # Hack for bug #3299 where nagios stuff is root:600
  file { ["/etc/nagios/hosts.d/", "/etc/nagios/services.d/"]:
    ensure  => directory,
    mode    => 644,
    recurse => true,
  }
  
  # Collect and instantiate all the puppet stuff
  Nagios_host <<||>>
  Nagios_service <<||>>
  
}
```

### Client

```puppet
class nagios::client {
  package { [ "nrpe", "nagios-plugins-all"]:
    ensure => latest,
    }
  file { "/etc/nagios/nrpe.cfg":
    source => "puppet:///modules/nagios/nrpe.cfg",
    notify => Service["nrpe"],
  }
  service { "nrpe":
    ensure  => running,
    enabled => true,
  }
 
  # Virtual definition that will become real on the server
  @@nagios_host { $fqdn:
    ensure  => present,
    alias   => $hostname,
    address => $ipaddress,
    use     => "generic-host",
    target  => "/etc/nagios/hosts.d/$fqdn.cfg",
    notify  => Service["nagios"],
  }
}
```

### References

-   <http://projects.puppetlabs.com/projects/1/wiki/Nagios_Patterns>

