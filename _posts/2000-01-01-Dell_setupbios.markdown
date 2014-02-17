<Dell> provides the setupbios tool to help automatically configure the
bios of C-class servers.

### Examples

Save your settings: ./setupbios setting save \> settings.ini

List all settings that you have available: ./setupbios setting list

Fetch a current setting: ./setupbios setting get quiet\_boot disabled

See what changes are different compared to the defaults:

    ./setupbios setting diff
    #
    # setupbios  |  built: 2012-10-10 14:44:42
    #
    #
    # This output can be captured, edited, then fed directly back in as follows:
    # ./setupbios setting diff > filename
    # ./setupbios setting readfile filename
    #

    ; date_generated:   02/08/2013 14:25:27


    #frequency_ratio              : (not present)   # 
    quiet_boot                    : disabled        # disabled   enabled*  

#### References

-   Downloads: <http://poweredgec.com/files/>
-   Main Site: <http://poweredgec.com/>

<Category:Dell> <Category:BIOS>
