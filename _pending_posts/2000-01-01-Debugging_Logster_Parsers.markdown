---
categories:
 - Logster
---
Sometimes it is helpful to run a <Logster> parser over and over to make
sure you get it right. Here is one way to do it.

### Procedure

Run your parser at least once: logster -D --output=stdout TestLogster
/var/log/test.log

What is your inode? ls -i /var/log/test.log

Now echo that inode and line number into the logtail state, that way
next time it runs it reads in all your lines: echo -e "154717\\n0" \>
/var/run/logtail-TestLogster-var-log-test.log.state; \\ logster -D
--output=stdout TestLogster /var/log/test.log

