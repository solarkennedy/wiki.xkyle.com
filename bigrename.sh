#!/bin/bash

for EACH in *
do
  if [[ -f $EACH ]]; then
  OLD_NAME=`echo $EACH | sed 's/\.html//g'`
  find -type f | xargs sed -i "s/$OLD_NAME/$EACH/g" *
  fi
done

