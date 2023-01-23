#!/usr/bin/env bash

# Change the start and end positions of the CNV you want to visualize here:
start_region=162336527
end_region=162448611
# Set the flanking region that will be visualized on either side
# of the CNV window specified above:
flank=200000

# provide cram as cmd line argument
cram=$1

if [ -z $1 ]; then
	echo "Please include cram/bam file as additional argument"
	exit 0
fi

# Remove the previous file if it is there
rm intervals.txt

# step by 1000
inv=0
for num in $(seq $((start_region-flank)) 1000 $((end_region+flank)))
do
	let "inv++"
	echo chr6$'\t'$num$'\t'$((num+1000))$'\t'inv$inv >> intervals.txt
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

awk -v mean=`awk '{ total += $5 } END { print total/NR }' JMS-6613-LIB-PDPGJS.multicov.tsv` \
	'{ print $2"\t"$3"\t"log($5/mean)/log(10) }' ${fileName}.multicov.tsv \
	> normalized.bin.count.txt

# Produce plot
Rscript --vanilla plotCNV.R $fileName $start_region $end_region

# Clean up
rm normalized.bin.count.txt JMS-6673-LIB-PDPGJS.multicov.tsv intervals.txt
