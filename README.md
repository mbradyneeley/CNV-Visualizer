# CNV-Visualizer

![Screen Shot 2023-01-23 at 3 43 22 PM](https://user-images.githubusercontent.com/55114836/214156591-fb37b769-896c-4ffc-8d29-3990a471fc3e.png)


## Use the vizualizeAlignmentsWorkflow.sh for visualizing read coverage.
- Takes as input a cram or bam file
- Makes intermediate file based off of bed file: ivls_of_interest.bed
- Uses bedtools multicov to count alignments from cram overlapping each 
  interval as specified in the intermediate file created by the workflow
- plotCNV.R takes care of the plotting using ggplot2


## Dependencies:
- Bedtools
- R: ggplot2
- R: tidyverse

#### January 2023 - Brady Neeley
