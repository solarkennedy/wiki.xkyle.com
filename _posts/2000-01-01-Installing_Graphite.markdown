### Prerequisites

`apt-get install libapache2-mod-python python-pip python-django-tagging python-django`\
`pip install carbon`\
`pip install whisper`\
`pip install graphite-web`\
`# Or with packages, see `[`https://github.com/dcarley/graphite-rpms`](https://github.com/dcarley/graphite-rpms)

### Initial Setup

`#Create basic django user junk`\
`python /opt/graphite/webapp/graphite/manage.py syncdb`\
`#Now run the devel server to test:`\
`/opt/graphite/bin/run-graphite-devel-server.py /opt/graphite/`
`You should be able to connect to 8080 and see an empty gui`

### More setup for the carbon collector

`cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf`

### Configure Carbon

`cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf`

### Start Carbon in debug mode

`PYTHONPATH=/opt/graphite/whisper /opt/graphite/bin/carbon-cache.py --debug start`

### Pull in data from munin

`wget `[`https://github.com/adamhjk/munin-graphite/raw/master/munin-graphite.rb`](https://github.com/adamhjk/munin-graphite/raw/master/munin-graphite.rb)\
`ruby munin-graphite.rb localhost`

* * * * *

#### References

<http://graphite.wikidot.com/quickstart-guide>

#### See Also

[Production Graphite](Production Graphite "wikilink")

<Category:Graphite>
