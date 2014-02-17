---
categories:
 - OpenWrt
---
### Prep

-   See [OpenWrt Development](OpenWrt Development "wikilink") to get a
    working tree

### Package Skeleton

-   Make a new folder in feeds/packages/bla
-   Add your make file
-   Rebuild the index: ./scripts/feeds update -i
-   Install your package: ./scripts/feeds install bla

### Building

-   make package/feeds/packages/bla/download V=99

