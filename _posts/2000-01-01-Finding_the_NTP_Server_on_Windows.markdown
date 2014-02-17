If you are on a domain, you have a <NTP> server.

    $ w32tm /dumpreg /subkey:parameters

    Value Name                 Value Type          Value Data
    ------------------------------------------------------------

    ServiceDll                 REG_EXPAND_SZ       %systemroot%\system32\w32time.dll
    ServiceMain                REG_SZ              SvchostEntry_W32Time
    ServiceDllUnloadOnStop     REG_DWORD           1
    Type                       REG_SZ              AllSync
    NtpServer                  REG_SZ              pdc.yourcompany

#### References

-   <http://serverfault.com/questions/49105/how-to-find-time-server-in-a-domain>

<Category:NTP>
