---
categories:
 - Screen
 - IPMI
---
IPMI SOL (Serial over lan) is a useful way to get "console" access
without bothering to do a kvm.

### One server

`screen  1 ipmitool -H server01-ipmi -I lanplus -U root -P root sol activate`

### Like a Boss

    #Multi screenrc super-screen-rc
    screen  1 ipmitool -H server01-ipmi -I lanplus -U root -P root sol activate
    screen  2 ipmitool -H server02-ipmi -I lanplus -U root -P root sol activate
    screen  3 ipmitool -H server03-ipmi -I lanplus -U root -P root sol activate
    screen  4 ipmitool -H server04-ipmi -I lanplus -U root -P root sol activate
    screen  5 ipmitool -H server05-ipmi -I lanplus -U root -P root sol activate
    screen  6 ipmitool -H server06-ipmi -I lanplus -U root -P root sol activate
    screen  7 ipmitool -H server07-ipmi -I lanplus -U root -P root sol activate
    screen  8 ipmitool -H server08-ipmi -I lanplus -U root -P root sol activate
    screen  9 ipmitool -H server09-ipmi -I lanplus -U root -P root sol activate
    screen 10 ipmitool -H server10-ipmi -I lanplus -U root -P root sol activate

Then run that file: screen -c super-screen-rc

### Keyboard Commands

    ~.           #exit the console.
    <esc>1       #F1
    <esc>2       #F2
    <esc>0       #F10
    <esc>@       #F12

### Magic Sysrq Over SOL

`~B   #Send "break"`

