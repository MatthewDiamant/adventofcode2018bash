#!/bin/bash

FILE="input4.txt"
# FILE="test-input.txt"

function timeconvert {
  num=$(echo $1 | cut -d ":" -f2 | cut -d "]" -f1)
  echo $(expr $num + 0)
}

sort $FILE > sortedinput.txt

while IFS='' read -r line || [[ -n "$line" ]]; do
  # echo $(timeconvert "$line")
  if [[ $line == *"begins shift"* ]]; then
    CURRENTGUARD=$(echo $line | cut -d "#" -f2 | cut -d " " -f1)
  elif [[ $line == *"falls asleep"* ]]; then
    SLEEPTIME=$(timeconvert "$line")
  elif [[ $line == *"wakes up"* ]]; then
    WAKETIME=$(timeconvert "$line")
    TOTALTIME=$((GUARDS[$CURRENTGUARD] += $WAKETIME - $SLEEPTIME - 1))
    GUARDS[$CURRENTGUARD]=$TOTALTIME
  fi
done < "sortedinput.txt"

SLEEPIEST=$(for i in "${!GUARDS[@]}"; do printf "%s\t%s\n" "$i" "${GUARDS[$i]}"; done | sort -k2 -g -r | head -n1 | cut -f1)

echo $SLEEPIEST

MINUTES=()

while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ $line == *"begins shift"* ]]; then
    CURRENTGUARD=$(echo $line | cut -d "#" -f2 | cut -d " " -f1)
  fi
  if [[ $CURRENTGUARD == $SLEEPIEST ]]; then
    echo $line
    if [[ $line == *"falls asleep"* ]]; then
      SLEEPTIME=$(timeconvert "$line")
    elif [[ $line == *"wakes up"* ]]; then
      WAKETIME=$(timeconvert "$line")
      for i in `seq $SLEEPTIME $((WAKETIME - 1))`; do
        TIME[i]=$((++TIME[i]))
      done
    fi
  fi
done < "sortedinput.txt"

SLEEPIESTMINUTE=$(for i in "${!TIME[@]}"; do printf "%s\t%s\n" "$i" "${TIME[$i]}"; done | sort -k2 -g -r | head -n1 | cut -f1)

echo $SLEEPIEST $SLEEPIESTMINUTE $((SLEEPIEST * SLEEPIESTMINUTE))
