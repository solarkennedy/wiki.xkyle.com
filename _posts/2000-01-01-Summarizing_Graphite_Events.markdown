<Graphite> is also great for measuring things that could be considered
"events". This could be something like a login failure, file creation,
terminated EC2 instance. Etc.

To insert these type of metrics into graphite, simply give them the
value 1: echo events.cfengine.push 1 \`date +%s\` | nc graphs.xkyle.com
2003

Use the drawAsInfinite function to make these events show up as straight
lines.
<https://graphs.xkyle.com/render/?target=drawAsInfinite%28events.cfengine.push%29&from>=-24hours

Or to see them over time, summarize and group them into say, 1 day
buckets: summarize(sumSeries(group(events.cfengine.push)), "1d")

### Converting Metrics Into Events

You can take any metric and convert it into an event by dividing itself.
(normalizing the metric to be "1"):
divideSeries(metrics.time\_it\_took\_to\_transfer,metrics.time\_it\_took\_to\_transfer)

Every time there is a transfer, no matter how long it took, it will be a
"1". Now sum those, and then summarizing them, say per hour:
summarize(sumSeries(divideSeries(metrics.time\_it\_took\_to\_transfer,metrics.time\_it\_took\_to\_transfer)),
'1h')

Now you have a graph of transfers per hour.

### References

<http://obfuscurity.com/2012/04/Unhelpful-Graphite-Tip-1>
<http://codeascraft.etsy.com/2010/12/08/track-every-release/>

<Category:Graphite>
