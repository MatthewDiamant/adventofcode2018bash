#!/usr/local/bin/bash

FILE="input4.txt"

function timeconvert {
  num=$(echo $1 | cut -d ":" -f2 | cut -d "]" -f1)
  echo $(expr $num + 0)
}

sort $FILE > sortedinput.txt

declare -A TIME

while IFS='' read -r line || [[ -n "$line" ]]; do
  echo $line
  if [[ $line == *"begins shift"* ]]; then
    CURRENTGUARD=$(echo $line | cut -d "#" -f2 | cut -d " " -f1)
  elif [[ $line == *"falls asleep"* ]]; then
    SLEEPTIME=$(timeconvert "$line")
  elif [[ $line == *"wakes up"* ]]; then
    WAKETIME=$(timeconvert "$line")
    for i in `seq $SLEEPTIME $((WAKETIME - 1))`; do
      TIME["$CURRENTGUARD,$i"]=$((++TIME["$CURRENTGUARD,$i"]))
    done
  fi
done < "sortedinput.txt"

SLEEPIEST=$(for i in "${!TIME[@]}"; do printf "%s\t%s\n" "$i" "${TIME[$i]}"; done | sort -k2 -g -r | head -n1 | cut -f1)

echo $(($(echo $SLEEPIEST | cut -d ',' -f 1) * $(echo $SLEEPIEST | cut -d ',' -f 2)))
