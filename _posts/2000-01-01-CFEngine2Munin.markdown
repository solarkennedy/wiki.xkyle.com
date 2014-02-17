I'm tired of configuring <Munin>. <CFEngine> knows all my servers
anyway, so can't it do it for me?

### Start With Host Definitions

To get a list of hosts from CFEngine, use
[this](Extract Hosts from CFEngine "wikilink")

    for EACH in `./extract-hosts.sh`
    do
    TODO
    done

### See Also

[Managing Munin With CFEngine](Managing Munin With CFEngine "wikilink")

<Category:CFEngine> <Category:Munin>
