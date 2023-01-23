#!/usr/bin/env bash

# provide cram as cmd line argument
if [ -z "$*" ]; then
	echo "Please include cram/bam files as an additional argument"
	exit 0
fi

bedtools multicov \
	-bams "$@" \
	-bed intervals.txt \
	> multisample.$(date +"%Y_%m_%d_%I_%M_%p").multicov.tsv
