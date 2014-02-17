Switch to backuppc: su backuppc -s /bin/bash

Next create yourself a key: ssh-keygen

No passphrase. Your end goal remember is to enable backuppc to ssh to
your servers as root, with no password.

You can save yourself some trouble by disabling host key checking and
password auth:

    echo "
    StrictHostKeyChecking no
    PasswordAuthentication no
    UserKnownHostsFile /dev/null
    " >> ~/.ssh/config

I suppose it is a tad insecure, but is sure saves a lot of trouble.

<Category:BackupPC> <Category:SSH>
