#!/bin/bash
set -eu
for file in *.html; do
  title="${file%.*}"
  echo "
<html>
<head>
<meta http-equiv=\"refresh\" content=\"0; URL='https://github.com/solarkennedy/wiki.xkyle.com/wiki/${title}'\" />
</head>
</html>
"> $file
done


