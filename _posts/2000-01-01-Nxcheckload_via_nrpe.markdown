<nxcheckload> is a script that <FreeNX> calls to see what the load is on
remote servers. It has to know this in order to load balance properly.

<NRPE> is a method that nagios uses to make remote load requests, and
you are probably already using it! So tapping nxcheckload into it is an
obvious choice.

### On the NX loadbalancer

First you need to make sure you have the check\_nrpe command. This
usually comes in some nagios package.

Second you need a nxcheckload scrip that the nx program will run. Like
this:

    #!/bin/bash
    /usr/lib64/nagios/plugins/check_nrpe -H outback2 -c check_nxload

### On the NX Node

First <NRPE> must be installed, and then put your nxcheckload script
into /usr/lib64/nagios/plugins, then add this to your nrpe.cfg:
command[check\_nxload]=/usr/lib64/nagios/plugins/check\_nxload

Or something like that. As long as your firewalls and allow\_hosts
permit the load balancers to make the nrpe query, it should work.

<Category:FreeNX> <Category:Nagios>
