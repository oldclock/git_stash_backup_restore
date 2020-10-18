#!/bin/bash

STASH_TOTAL=$(ls -1 | grep "stash-" | wc -l)
echo "total stash count: $STASH_TOTAL"

for index in $(seq $STASH_TOTAL -1 1)
do
	PATCH_FILE_NAME=$(ls -1 stash-*.patch | head -n ${index} | tail -n 1)
	STASH_COMMENT=$(echo ${PATCH_FILE_NAME} | awk -F[.] '{print $1}' | awk -F[-] '{print $3}')
	echo patching $index $STASH_COMMENT
	git apply ${PATCH_FILE_NAME}
	echo saving stash $index
	git stash push -m ${STASH_COMMENT}
	git reset HEAD
done
