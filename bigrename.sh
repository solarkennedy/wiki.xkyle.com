#!/bin/bash

for EACH in *
do
  if [[ -f $EACH ]]; then
  OLD_NAME=`echo $EACH | sed 's/\.html//g'`
  echo "Finding files with references of $OLD_NAME and making them into $EACH"
  sed -i "s/href=\"\/$OLD_NAME\"/href=\"\/$EACH\"/g" *.html
   
  fi
done

