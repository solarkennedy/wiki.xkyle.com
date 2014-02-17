* * * * *

WARNING: This doesn't work yet

* * * * *

### Install

-   Be sure to download the "ESXi Driver Rollup 1" iso in order to get
    the raid driver for installation

### Monitoring

`# On your client`\
`scp vmware-esx-provider-LSIProvider.vib root@`<server>`:/tmp/`

`# On the server`\
`esxcli software vib install -v `[`file:///tmp/vmware-esx-provider-LSIProvider.vib`](file:///tmp/vmware-esx-provider-LSIProvider.vib)`  -f --maintenance-mode`

### See Also

[Enable SNMP on ESXi 5](Enable SNMP on ESXi 5 "wikilink")

<Category:ESX>
