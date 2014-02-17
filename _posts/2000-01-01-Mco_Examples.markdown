### Filters

#### all machines with the service agent

`mco ping -A service`\
`mco ping --with-agent service`

#### all machines with the apache class on them

`mco ping -C apache`\
`mco ping --with-class apache`

#### all machines with a class that match the regular expression

`mco ping -C /service/`

#### all machines in the UK

`mco ping -F country=uk`\
`mco ping --with-fact country=uk`

#### all machines in either UK or USA

`mco ping -F "country=/uk|us/"`

#### just the machines called dev1 or dev2

`mco ping -I dev1 -I dev2`

#### all machines in the domain foo.com

`mco ping -I /foo.com$/`

### Fancy RPC Magic

#### Start a service

`mco rpc service start service=httpd`

#### Find the status of files across hosts

`mco rpc filemgr status -j file=/bin/bash`

#### List of hosts that are of a particular class

`mco find -C my-cool-class`

#### List of hosts with a class, the file is or is not a symlink

`mco rpc filemgr status -j file=/bin/bash -C my-cool-class | jgrep "not data.type=symlink" -s sender`\
`# Where it is a symlink`\
`mco rpc filemgr status -j file=/bin/bash -C my-cool-class | jgrep "data.type=symlink" -s sender`

#### List Servers with a package installed

`mco rpc package status package=memcached -j`\
`mco rpc package status package=memcached -j | jgrep "data.ensure!=absent and data.ensure!=purged" -s sender -s data.ensure`

#### Query for a particular version, then remove it

`mco rpc package status package=bash --json | jgrep "data.ensure=4.0" | mco rpc package uninstall package=bash`

#### References

-   <http://docs.puppetlabs.com/mcollective/reference/basic/basic_cli_usage.html>

<Category:MCollective> <Category:jgrep>
