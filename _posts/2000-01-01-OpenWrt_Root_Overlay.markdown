### Packages You Need

`kmod-usb-storage kmod-fs-ext4 block-extroot block-hotplug block-mount`

### Packages for 12.09

`kmod-usb-storage kmod-fs-ext4 block-mount`

### Procedure

​1. Format then mount the USB drive

​2. Modify the /etc/config/fstab. The relevant sections are as follows:

    config mount
            option is_rootfs 1
            option target   /overlay
            option device   /dev/sda1
            option fstype   ext4
            option options  rw,sync
            option enabled  1
            option enabled_fsck 0
    config swap
            option device   /dev/sda2
            option enabled  1

​3. Copy the overlay content to the USB by: tar -C /overlay -cvf - . |
tar -C /mnt/sda1 -xf -

​4. Reboot

### References

-   <https://forum.openwrt.org/viewtopic.php?id=34188>

<Category:OpenWrt>
