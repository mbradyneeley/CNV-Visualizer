# CNV-Visualizer

## Use the vizualizeAlignmentsWorkflow.sh for visualizing read coverage.
- Takes as input a cram file
- Makes intermediate file based off of bed file: ivls_of_interest.bed
- Uses bedtools multicov to count alignments from cram overlapping each 
  interval as specified in the intermediate file created by the workflow
- plotCNV.R takes care of the plotting using ggplot2


## Dependencies:
- Bedtools
- R: ggplot2
- R: tidyverse

#### January 2023 - Brady Neeley
