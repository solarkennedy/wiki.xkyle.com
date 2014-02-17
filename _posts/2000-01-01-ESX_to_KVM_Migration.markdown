This is a quick script to snag an <ESXi> vm image and import it into a
local <KVM> install.

    #!/bin/bash

    ESXHOST="$1"
    USERNAME="root"
    PASSWORD="$2"
    IMAGESTORE="$3"
    VMNAME="$4"
    NEWVMNAME='echo $IMAGESTORE | sed s/\ /_/g'
    DSNAME="$5"

    #First download the disk image
    echo "Retrieving Disk Image File..."
    wget --connect-timeout=5 --progress=bar --no-check-certificate -c --http-user=$USERNAME --http-password=$PASSWORD "https://$ESXHOST/folder/$VMNAME/$VMNAME-flat.vmdk?dcPath=ha-datacenter&dsName=$DSNAME" -O $IMAGESTORE/$NEWVMNAME.vmdk
    #Now download the esx config file
    echo "Retrieving Virtual Machine Configuration File..."
    wget --connect-timeout=5 --progress=bar --no-check-certificate -c --http-user=$USERNAME --http-password=$PASSWORD "https://$ESXHOST/folder/$VMNAME/$VMNAME.vmx?dcPath=ha-datacenter&dsName=$DSNAME" -O /tmp/$NEWVMNAME.vmx

    #parse the size of the ram
    echo "Acquiring Configured Ram Size..."
    RAM=`cat /tmp/$VMNAME.vmx | grep memsize | cut -f 2 -d '"'`

    #Now do the import, but don't bother attaching a console
    echo "Importing Virtual Machine..."
    virt-install --import --location=$IMAGESTORE/$NEWVMNAME.vmdk -n $NEWVMNAME -r $RAM --noautoconsole

<Category:ESX> <Category:KVM> <Category:Virtualization>
