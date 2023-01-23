The cram found here is from a sample with a DELETION on chr6 in the PRKN
gene. The position of it is, 162336528-162448611. The width is 112,084 bp.
Trying to vizualize this CNV using bedtools multicov

Use the vizualizeAlignmentsWorkflow.sh for visualizing read coverage.
- Takes as input a cram file
- Makes intermediate file based off of bed file: ivls_of_interest.bed
- Uses bedtools multicov to count alignments from cram overlapping each 
  interval as specified in the intermediate file created by the workflow
