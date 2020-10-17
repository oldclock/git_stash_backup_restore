#!/bin/bash

STASH_TOTAL=$(git stash list | wc -l)
echo "total stash count: $STASH_TOTAL"

for index in $(seq 1 $STASH_TOTAL)
do
	#git stash list | awk -F[:] '{print $3}' | awk '{print $1}' | head -n ${index} | tail -n 1
	STASH_COMMENT=$(git stash list | awk -F[:] '{print $3}' | awk '{print $1}' | head -n ${index} | tail -n 1)
	echo saving $index $STASH_COMMENT to patch file
	
	PATCH_FILE_NAME=$(printf "stash-%04d-%s.patch" $index $STASH_COMMENT)
	STASH_INDEX=$(printf "stash@{%d}\n" $((${index} - 1)))
	git stash show -p $STASH_INDEX > $PATCH_FILE_NAME
done
