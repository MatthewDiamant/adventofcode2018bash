#!/bin/bash

FREQ=0

while IFS='' read -r line || [[ -n "$line" ]]; do
  FREQ="$((FREQ + line))"
done < "input1.txt"

echo $FREQ
