#!/bin/bash

FREQ=0
SEENSUMS=(0)
RESULT=
LOOPS=0

while [[ -z $RESULT ]]; do
	while IFS='' read -r line || [[ -n "$line" ]]; do
		FREQ="$((FREQ + line))"
		if [[ " ${SEENSUMS[@]} " =~ " ${FREQ} " ]]; then
			RESULT=$FREQ
		fi
		SEENSUMS+=("$FREQ")
	done < "input1.txt"
	echo $((++LOOPS))
done

echo $RESULT
