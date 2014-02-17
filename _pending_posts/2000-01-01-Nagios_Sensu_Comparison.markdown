---
categories:
 - Nagios
 - Sensu
---
  -------------------------------------------------------- --------------------------------------------------------------- -------------------------------------------------------------
  **Nagios**                                               **Sensu**                                                       **Comment**
  ?                                                        handlers]]                                                      Takes action on events
  host\_definition on server                               client.json on client                                           Defines the hostname / ip
  checks in /usr/lib64/nagios/plugins/                     checks in /etc/sensu/plugins/                                   Compatible, use either.
  n/a                                                      mutators]]                                                      Sits in-between the **event** and the **handler**
  nrpe check]]                                             [Sensu Standalone Checks](Sensu Standalone Checks "wikilink")   a check that is executed on the client
  manually remove host from config files + nagios reload   curl -X DELETE <http://<sensu-api>/client/<node>\>              Remove a host config
  host\_groups                                             subscriptions]]                                                 Groups of hosts that all will do a particular set of checks
  -------------------------------------------------------- --------------------------------------------------------------- -------------------------------------------------------------

