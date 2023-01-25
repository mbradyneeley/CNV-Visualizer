#!/usr/bin/env bash

# Pass in as cmd args your start, end, and chr#
start_region=$3
end_region=$4
# Set the flanking region that will be visualized on either side
# of the CNV window specified above:
flank=200000
# Set the chromosome number
chr=$2
# Pass in gene name
gene=$5

# provide cram as cmd line argument
cram=$1

if [ -z $1 ]; then
	echo "Please include cram/bam file as additional argument"
	exit 0
fi
if [ -z $2 ]; then
	echo "Please include all command args as ./script <cram> <chr#> <start> <end> <geneName>"
	exit 0
fi
if [ -z $3 ]; then
	echo "Please include all command args as ./script <cram> <chr#> <start> <end> <geneName>"
	exit 0
fi
if [ -z $4 ]; then
	echo "Please include all command args as ./script <cram> <chr#> <start> <end> <geneName>"
	exit 0
fi
if [ -z $5 ]; then
	echo "Please include all command args as ./script <cram> <chr#> <start> <end> <geneName>"
	exit 0
fi

# step by 1000
inv=0
for num in $(seq $((start_region-flank)) 1000 $((end_region+flank)))
do
	let "inv++"
	echo $chr$'\t'$num$'\t'$((num+1000))$'\t'inv$inv >> intervals.txt
done

# Bedtools multicov step
baseInput=$(basename $cram)
fileName=${baseInput%%.*}

bedtools multicov \
	-bams $cram \
	-bed intervals.txt \
	> ${fileName}.multicov.tsv

# From the multicov.tsv file produced, with awk:
#	- Take the average count across the bins (last column)
#	- Divide each bin count by average to normalize
#	- Take log of each bin count to center everything around 0

awk -v mean=`awk '{ total += $5 } END { print total/NR }' ${fileName}.multicov.tsv` \
	'{ print $2"\t"$3"\t"log($5/mean)/log(10) }' ${fileName}.multicov.tsv \
	> normalized.bin.count.txt

# Produce plot
Rscript --vanilla plotCNV.R $fileName $start_region $end_region $gene

# Clean up
rm normalized.bin.count.txt *.multicov.tsv intervals.txt
