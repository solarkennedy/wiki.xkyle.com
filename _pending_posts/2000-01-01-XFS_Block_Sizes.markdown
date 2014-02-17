---
categories:
 - XFS
 - Linux
 - RAID
---
xfsprogs and the mkfs.xfs utility **automatically** select the best
stripe size and stripe width for underlying devices that support it,
such as Linux software RAID devices. Earlier versions of xfs used a
built-in libdisk and the GET\_ARRAY\_INFO ioctl to gather the
information; newer versions make use of enhanced geometry detection in
libblkid. When using libblkid, accurate geometry may also be obtained
from hardware RAID devices which properly export this information.

To create XFS filesystems optimized for RAID arrays manually, you'll
need two parameters:

-   **chunk size**: same as used with mdadm
-   **number of "data" disks**: number of disks that store data, not
    disks used for parity or spares. For example:
    -   RAID 0 with 2 disks: 2 data disks (n)
    -   RAID 1 with 2 disks: 1 data disk (n/2)
    -   RAID 10 with 10 disks: 5 data disks (n/2)
    -   RAID 5 with 6 disks (no spares): 5 data disks (n-1)
    -   RAID 6 with 6 disks (no spares): 4 data disks (n-2)

With these numbers in hand, you then want to use mkfs.xfs's su and sw
parameters when creating your filesystem.

-   **su**: Stripe unit, which is the RAID chunk size, in bytes
-   **sw**: Multiplier of the stripe unit, i.e. number of data disks

If you've a 4-disk RAID 5 and are using a chunk size of 64 KiB, the
command to use is:

`mkfs -t xfs -d su=64k -d sw=3 /dev/md0`

Alternately, you may use the sunit/swidth mkfs options to specify stripe
unit and width in 512-byte-block units. For the array above, it could
also be specified as:

`mkfs -t xfs -d sunit=128 -d swidth=384 /dev/md0`

The result is exactly the same; however, the su/sw combination is often
simpler to remember. Beware that sunit/swidth are inconsistently used
throughout XFS' utilities (see xfs\_info below).

To check the parameters in use for an XFS filesystem, use xfs\_info.

`xfs_info /dev/md0`

`meta-data=/dev/md0               isize=256    agcount=32, agsize=45785440 blks`\
`         =                       sectsz=4096  attr=2`\
`data     =                       bsize=4096   blocks=1465133952, imaxpct=5`\
`         =                       sunit=16     swidth=48 blks`\
`naming   =version 2              bsize=4096   ascii-ci=0`\
`log      =internal               bsize=4096   blocks=521728, version=2`\
`         =                       sectsz=4096  sunit=1 blks, lazy-count=0`\
`realtime =none                   extsz=196608 blocks=0, rtextents=0`

Here, rather than displaying 512-byte units as used in mkfs.xfs, sunit
and swidth are shown as multiples of the filesystem block size (bsize),
another file system tunable. This inconsistency is for legacy reasons,
and is not well-documented.

For the above example, sunit (sunit×bsize = su, 16×4096 = 64 KiB) and
swidth (swidth×bsize = sw, 48×4096 = 192 KiB) are optimal and correctly
reported.

While the stripe unit and stripe width cannot be changed after an XFS
file system has been created, they can be overridden at mount time with
the sunit/swidth options, similar to ones used by mkfs.xfs.

From Documentation/filesystems/xfs.txt in the kernel tree:

` sunit=value and swidth=value`\
`       Used to specify the stripe unit and width for a RAID device or`\
`       a stripe volume.  "value" must be specified in 512-byte block`\
`       units.`\
`       If this option is not specified and the filesystem was made on`\
`       a stripe volume or the stripe width or unit were specified for`\
`       the RAID device at mkfs time, then the mount system call will`\
`       restore the value from the superblock.  For filesystems that`\
`       are made directly on RAID devices, these options can be used`\
`       to override the information in the superblock if the underlying`\
`       disk layout changes after the filesystem has been created.`\
`       The "swidth" option is required if the "sunit" option has been`\
`       specified, and must be a multiple of the "sunit" value.`

Source: [Samat Says: Tuning XFS for RAID](http://says.samat.org/)

