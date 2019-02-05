#!/bin/bash

TESTFILE="input3.txt"
RESULT=

while IFS='' read -r BOX || [[ -n "$BOX" ]]; do

  echo $(echo $BOX | cut -f 1 -d ' ')

  COLLISION=''

  BOXINDEX=$(echo $BOX | cut -f 1 -d ' ' | cut -f 2 -d"#")
  BOXX=$(echo $BOX | cut -f 3 -d " " | cut -f 1 -d ',')
  BOXY=$(echo $BOX | cut -f 3 -d " " | cut -f 2 -d ',' | sed 's/.$//')
  BOXWIDTH=$(echo $BOX | cut -f 4 -d " " | cut -f 1 -d 'x')
  BOXHEIGHT=$(echo $BOX | cut -f 4 -d " " | cut -f 2 -d 'x')

  while IFS='' read -r COMPARINGBOX || [[ -n "$COMPARINGBOX" ]] && [[ -n COLLISION ]]; do

    if [[ $BOX != $COMPARINGBOX ]]; then

      if [[ $BOX < $COMPARINGBOX ]]; then

        COMPAREINDEX=$(echo $COMPARINGBOX | cut -f 1 -d ' ' | cut -f 2 -d"#")
        COMPAREX=$(echo $COMPARINGBOX | cut -f 3 -d " " | cut -f 1 -d ',')
        COMPAREY=$(echo $COMPARINGBOX | cut -f 3 -d " " | cut -f 2 -d ',' | sed 's/.$//')
        COMPAREWIDTH=$(echo $COMPARINGBOX | cut -f 4 -d " " | cut -f 1 -d 'x')
        COMPAREHEIGHT=$(echo $COMPARINGBOX | cut -f 4 -d " " | cut -f 2 -d 'x')

        # Collision detection
        if [[ $BOXX < $((COMPAREX + COMPAREWIDTH)) && $((BOXX + BOXWIDTH)) > $COMPAREX && $BOXY < $((COMPAREY + COMPAREHEIGHT)) && $((BOXY + BOXHEIGHT)) > $COMPAREY ]]; then
            COLLISION=1
        fi

      fi

    fi

  done < $TESTFILE

  if [[ -z $COLLISION ]]; then
    RESULT=$BOX
  fi

done < $TESTFILE

echo $RESULT
