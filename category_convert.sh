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

  sed -i -e '1i ---' $EACH
  sed -i -e "1i $CATEGORIES" $EACH
  sed -i -e "1i categories:" $EACH
  sed -i  -e '1i ---' $EACH
  sed -i 'd/<Category:>' $EACH

done
