---
categories:
 - Puppet
 - Cron
---
Sometimes it is more efficient to run <Puppet> via <cron> instead of a
daemon:

      cron { "puppet":
          command => "/usr/bin/puppet agent -t --logdest syslog > /dev/null 2>&1",
          user => "root",
          minute => fqdn_rand( 60 ),
          ensure => present,
      }

