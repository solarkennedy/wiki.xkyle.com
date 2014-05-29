#!/bin/bash

for EACH in *
do
  if [[ -f $EACH ]]; then
  OLD_NAME=`echo $EACH | sed 's/\.html//g'`
  sed "s/$OLD_NAME/$EACH/g" *
  fi
done

