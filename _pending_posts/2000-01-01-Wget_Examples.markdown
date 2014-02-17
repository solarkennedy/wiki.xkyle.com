---
categories:
 - Wget
---
Examples:

#### Mirror a site, only go down levels

`wget --no-parent -m `[`http://ppa.launchpad.net/swift-core/release/ubuntu/`](http://ppa.launchpad.net/swift-core/release/ubuntu/)

#### Screw index crap

`--reject "*index.html*"`

