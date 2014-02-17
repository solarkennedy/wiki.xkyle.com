---
categories:
 - RPM
 - Yum
---
### Local

    [local-files]
    name=Local Fedora $releasever - $basearch files
    failovermethod=priority
    baseurl=file:///mnt/f17/
    enabled=1
    gpgcheck=0

### Remote

