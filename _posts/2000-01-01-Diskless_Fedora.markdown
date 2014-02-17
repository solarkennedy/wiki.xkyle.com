### DHCP

    yum -y install dhcp

    cat > /etc/dhcp/dhcpd.conf <<EOF
    authoritative;
    ddns-update-style none;

    # set lease time to infinite (-1)
    default-lease-time -1;

    subnet 192.168.0.0 netmask 255.255.255.0 {
      option domain-name "pxetest";
      option domain-name-servers 192.168.0.1;
      option routers 192.168.0.1;
      use-host-decl-names on;
      allow booting;
      allow bootp;
      class "pxeclients" {
       match if substring(option vendor-class-identifier, 0, 9) = "PXEClient";
       next-server server-ip;
       filename "pxelinux.0";
      }

      host pxe-test { hardware ethernet 00:00:00:00:00:00; fixed-address 192.168.0.2; }
    }
    EOF

    systemctl enable dhcpd.service
    systemctl restart dhcpd.service

### TFTP

    yum -y install tftp-server
    yum -y install syslinux
    cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/pxelinux.0

    # Enable the particular xinetd service
    sed -i 's/disable\t\t\t= yes/disable\t\t\t= no/' /etc/xinetd.d/tftp

    systemctl enable xinetd.service
    systemctl restart xinetd.service

### NFS

    yum -y install nfs-utils
    mkdir /srv

    cat > /etc/exports << EOF
    /srv/ 192.168.0.0/255.255.255.0(rw,sync,no_root_squash)
    EOF

    systemctl enable nfs-server.service 
    systemctl restart nfs-server.service 

### PXE Linux

    CLIENT_IP=192.168.0.2
    MAC=`printf '%02X' ${CLIENT_IP//./ }`

    mkdir -p /var/lib/tftpboot/pxelinux.cfg/
    cat > /var/lib/tftpboot/pxelinux.cfg/fedora16 <<EOF
    timeout 5
    default fedora16

    label fedora16
      kernel fedora16/vmlinuz-3.1.0-7.fc16.x86_64
      append initrd=fedora16/initramfs-3.1.0-7.fc16.x86_64.img ip=p4p1:dhcp root=nfs:192.168.0.1:/srv/pxe-test rw panic=30
    EOF

    # For tftp to work it needs a relative link
    cd /var/lib/tftpboot/pxelinux.cfg/
    ln -svf fedora16 $MAC

    mkdir -p /var/lib/tftpboot/fedora16/

    # Deal with kernel and initramfs
    yum -y install dracut-network # needed for root=nfs
    dracut /var/lib/tftpboot/fedora16/initramfs-3.1.0-7.fc16.x86_64.img 3.1.0-7.fc16.x86_64 --force
    cp /boot/vmlinuz-3.1.0-7.fc16.x86_64 /var/lib/tftpboot/fedora16/vmlinuz-3.1.0-7.fc16.x86_64

    # Not sure why, but the initrd doesn't have read permission
    chmod o+r /var/lib/tftpboot/fedora16/*

### Client Root Prep

    # Install a base system that we will nfs export
    # Alternatevly you can take an existing system:
    # rsync -aPv --exclude='/proc/*' --exclude='/sys/*' hostname.com:/ /srv/hostname/

    # Fresh install into an alternate root:
    yum -y groupinstall Base --installroot=/srv/pxe-test
    yum -y remove sendmail --installroot=/srv/pxe-test

    # Screw the kvm, just ssh:
    yum -y install openssh-server --installroot=/srv/pxe-test
    mkdir -p /srv/pxe-test/root/.ssh/
    chmod 700 /srv/pxe-test/root/.ssh/
    cp /root/.ssh/id_rsa.pub /srv/pxe-test/root/.ssh/authorized_keys
    chmod 600 /srv/pxe-test/root/.ssh/authorized_keys 

    # Need an fstab for the client
    cat > /srv/pxe-test/etc/fstab <<EOF
    none        /tmp        tmpfs   defaults    0 0
    tmpfs       /dev/shm    tmpfs   defaults    0 0
    sysfs       /sys        sysfs   defaults    0 0
    proc        /proc       proc    defaults    0 0
    EOF

    # Don't bother going graphical
    ln -sf /lib/systemd/system/multi-user.target /srv/pxe-test/etc/systemd/system/default.target

    # Disable NFSv4 boot slowness
    rm /srv/pxe-test/etc/systemd/system/multi-user.target.wants/nfs-idmap.service
    rm /srv/pxe-test/etc/systemd/system/multi-user.target.wants/rpcbind.service
    # Disable network manager as the kernel takes care of dhcp for us:
    rm /srv/pxe-test/etc/systemd/system/multi-user.target.wants/NetworkManager.service 

### References

-   <https://docs.fedoraproject.org/en-US/Fedora/14/html/Storage_Administration_Guide/nfs-diskless-systems.html>

<Category:PXE> <Category:NFS> <Category:Fedora>
