#!/bin/bash
for EACH in _posts/*.markdown
do

  if grep -q REDIRECT $EACH; then
    continue
  fi
  echo $EACH
  CATEGORIES=`grep 'Category:' $EACH | tr ' ' '\n' | sed -e "s/<Category:/\n - /g" | grep ' - ' |  cut -f 1 -d '>' `
#  echo "categories:
#$CATEGORIES"

echo "---
categories:
$CATEGORIES
---" | cat - $EACH > /tmp/tmp.txt
mv /tmp/tmp.txt $EACH

  sed -i '/<Category:/d' $EACH

done
