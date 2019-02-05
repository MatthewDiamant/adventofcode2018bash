#!/bin/bash

TWOLETTERS=0
THREELETTERS=0

function has_n_letters {
  echo $1 | grep -o . | sort | uniq -c | grep $2 | wc -l
}

while IFS='' read -r line; do
  [[ $(has_n_letters $line 2) -gt 0 ]] && TWOLETTERS=$((++TWOLETTERS))
  [[ $(has_n_letters $line 3) -gt 0 ]] && THREELETTERS=$((++THREELETTERS))
done < "input2.txt"

echo $(($TWOLETTERS*$THREELETTERS))
