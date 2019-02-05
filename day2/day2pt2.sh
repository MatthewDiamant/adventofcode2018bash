#!/bin/bash

RESULT=

while IFS='' read -r word || [[ -n "$word" ]] && [[ -z $RESULT ]]; do
  while IFS='' read -r comparing_word || [[ -n "$comparing_word" ]] && [[ -z $RESULT ]]; do
    DIFF=0
    for (( i=0 ; i < ${#word} ; i++ )); do
      if [[ ${word:i:1} != ${comparing_word:i:1} ]]; then
        ((DIFF+=1))
      fi
    done
    if [[ $DIFF == 1 ]]; then
      RESULT="$word $comparing_word"
    fi
  done < "input2.txt"
done < "input2.txt"

echo $RESULT
