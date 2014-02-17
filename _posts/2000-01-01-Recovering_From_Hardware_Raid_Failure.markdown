---
categories:
 - RAID
 - Disks
 - Partitions
---
Have some raid disks out of a hardware raid that have failed? Need ot
pick up the pieces and put it together? Use linux's software raid to the
rescue!

Let's say you have 2 disk images of a raid 0 array you need to put
together.

-   First, make read only loop devices of your raid members:

`losetup -r -f raid0a /dev/loop0`\
`losetup -r -f raid0b /dev/loop1`

-   If you know you have some metadata in the beginning, you can skip
    past it with the offset mode:

`losetup -r --offset 512 /dev/loop0 /dev/sda `\
`losetup -r --offset 512 /dev/loop1 /dev/sdb `

Now let's say that loop0 is the first part of the raid0, and loop1 is
the second part. Let us build a raid array out of those two pieces.
mdadm --build /dev/md0 --raid-devices=2 --level=0 /dev/loop2 /dev/loop1

The --build function skips the whole superblock nonsense, it assumes you
know exactly what you are doing. If you setup the loop devices as
read-only, then you have no risk of losing data. Order MATTERS! If the
first stripe is on the first disk for a raid0, you have to specify it
first! Raid1 this doesn't matter, but any other raid level it will. If
you think you have the strip order wrong, and easy way to test is do an
fdisk -l after your building. If you know you are supposed to have a
partition table, it will show up. If you have the order wrong, the first
block (where the partition table resides) will not come up first, and
hence will not show up on fdisk.

The default for mdadm is --auto=yes, meaning it will automatically
create the appropriate partition device files so you can mount each
partition appropriately.

If you are working with a raid1 array, and you know you do NOT want
mdadm to resync (and potentially overwriting stuff) us the
--assume-clean argument.

