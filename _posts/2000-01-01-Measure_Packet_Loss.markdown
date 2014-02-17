---
categories:

---
### Easy

`netstat -s | grep retransmited` `Server perspective.`

### Intermediate

    # collectl -stn
    waiting for 1 second sample...
    #<----------Network----------><------------TCP------------->
    #  KBIn  PktIn  KBOut  PktOut PureAcks HPAcks   Loss FTrans
          0      1      0       1        1      0      0      0
          0      1      0       1        1      0      0      0

### Wireshark

<Wireshark> Filter **tcp.analysis.retransmission**

### Detecting loss in the kernel?

Dropwatch

-   <http://humblec.com/dropwatch-to-see-where-the-packets-are-dropped-in-kernel-stack/>

### References

-   <http://serverfault.com/questions/318909/how-passively-monitor-for-tcp-packet-loss-linux>
-   <https://www.coverfire.com/archives/2012/11/24/measuring-one-way-packet-loss/>

