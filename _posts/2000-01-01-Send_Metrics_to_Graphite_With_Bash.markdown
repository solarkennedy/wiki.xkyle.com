Sending metrics to graphite with shell scripts is easy!

#### Code

To <Graphite>: echo "test.first 10 \`date +%s\`"|nc graphite.example.com
2003 To <Statsd>: echo "deploys.test.myservice:1|c" | nc -w 1 -u
graphite.example.com 8125

#### References

<http://typingandclicking.wordpress.com/2011/08/07/bash-script-to-graphite/>

<http://dev.nuclearrooster.com/2011/05/11/sending-metrics-to-statsd-from-bash/>

<Category:Graphite>
