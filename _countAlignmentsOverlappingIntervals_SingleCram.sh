#!/usr/bin/env bash

# provide cram as cmd line argument
cram=$1

if [ -z $1 ]; then
	echo "Please include cram/bam file as additional argument"
	exit 0
fi

baseInput=$(basename $cram)
fileName=${baseInput%%.*}

bedtools multicov \
	-bams $cram \
	-bed intervals.txt \
	> ${fileName}.multicov.tsv
