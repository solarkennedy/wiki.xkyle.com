lmgrd by default binds to a port, then opens up a random port for
whatever vendor product you are serving out. As a sysadmin, this bothers
me, and screws with my firewalls.

### Setting A Static Port

Find your license file on your license server. It might be called
server.lic.

Edit the file and look for a line starting with VENDOR: VENDOR INTEL Add
a Port after it like this: VENDOR INTEL PORT=35074

If you want to be fancy use an [Upstart Script For lmgrd
(FlexLM)](Upstart Script For lmgrd (FlexLM) "wikilink") to restart it.

<Category:FlexLM> <Category:Linux>
