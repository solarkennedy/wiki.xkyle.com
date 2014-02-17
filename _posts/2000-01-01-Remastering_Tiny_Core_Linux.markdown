---
categories:

---
### Prep

`yum -y install squashfs-tools`

### Unpack

    mkdir 1
    cd 1
    zcat ../core.gz | cpio -i -H newc -d

### Repack

`find | cpio -o -H newc | gzip -9 > ../core.gz`

#### References

-   <http://sirlagz.net/2011/05/17/how-to-remaster-tiny-core-linux/>

[Category:Tiny Core Linux](Category:Tiny Core Linux "wikilink")
