# CNV-Visualizer

<img width="1602" alt="Screen Shot 2023-01-23 at 3 32 16 PM" src="https://user-images.githubusercontent.com/55114836/214154637-e1f653e7-bd57-48f1-b2d6-380e397fe147.png">

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
