#!/bin/bash

TESTFILE="input3.txt"

echo "Get grid dimensions"
GRIDWIDTH=$(awk '{ split($3, start_coords, /,/); split($4, box_dimens, /x/); print start_coords[1] + box_dimens[1] }' $TESTFILE | sort -nr | head -n1)
GRIDHEIGHT=$(awk '{ split($3, start_coords, /,/); split($4, box_dimens, /x/); print start_coords[2] + box_dimens[2] }' $TESTFILE | sort -nr | head -n1)

echo "Creating grid"
for i in `seq 1 $GRIDHEIGHT`; do
  GRID[i]=`printf '.%.0s' $(seq 1 $GRIDWIDTH)`
done

echo "Filling grid"
while IFS='' read -r line || [[ -n "$line" ]]; do

  GRIDX=$(echo $line | cut -f 3 -d " " | cut -f 1 -d ',')
  GRIDY=$(echo $line | cut -f 3 -d " " | cut -f 2 -d ',' | sed 's/.$//')
  BOXWIDTH=$(echo $line | cut -f 4 -d " " | cut -f 1 -d 'x')
  BOXHEIGHT=$(echo $line | cut -f 4 -d " " | cut -f 2 -d 'x')

  echo "Writing box $(echo $line | cut -f 1 -d ' ')"

  # Write box
  for y in `seq 1 $BOXHEIGHT`; do
    for x in `seq 1 $BOXWIDTH`; do
      if [[ ${GRID[$((GRIDY+y-1))]:$((GRIDX+x-2)):1} != "." ]]; then
        GRID[$((GRIDY + y - 1))]=$(echo ${GRID[GRIDY + y - 1]} | sed s/./\X/$((GRIDX + x - 1)))
      else
        GRID[$((GRIDY + y - 1))]=$(echo ${GRID[GRIDY + y - 1]} | sed s/./\#/$((GRIDX + x - 1)))
      fi
    done
  done

  # Dump grid
  # printf "%s\n" "${GRID[@]}" > test.txt

done < $TESTFILE

echo "Count overlaps"
for i in `seq 1 $GRIDHEIGHT`; do
  LINE=${GRID[i]}
  OVERLAPS="${LINE//[^X]}"
  RESULT=$(( RESULT + ${#OVERLAPS} ))
done

echo $RESULT
