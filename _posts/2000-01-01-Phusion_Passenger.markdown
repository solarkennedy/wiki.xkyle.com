### Passenger.load Example

    LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-3.0.2/ext/apache2/mod_passenger.so
    PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-3.0.2
    PassengerRuby /usr/bin/ruby1.8

### Vhost Example

       <VirtualHost *:80>
          ServerName www.yourhost.com
          DocumentRoot /somewhere/public    # <-- be sure to point to 'public'!
          <Directory /somewhere/public>
             AllowOverride all              # <-- relax Apache security settings
             Options -MultiViews            # <-- MultiViews must be turned off
          </Directory>
       </VirtualHost>

<Category:Ruby> <Category:Apache>
