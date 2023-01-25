#!/usr/bin/Rscript

suppressPackageStartupMessages(library(biomaRt))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))

# Reads in cramFileName, startPosCNV, endPosCNV, geneName
args = commandArgs(TRUE)

# Read in gene info
gene = c(args[4])
# Annotate with position
mart <- useMart("ensembl")
mart <- useDataset("hsapiens_gene_ensembl", mart)
gene_positions <- getBM(
  attributes = c('hgnc_symbol', 'chromosome_name', 'start_position', 'end_position'),
  filters = 'hgnc_symbol',
  values = gene,
  mart = mart
)
rm(mart)

# Testing code
df = read_tsv("normalized.bin.count.txt",
              col_names = c("start", "end", "log_norm_count"))

df1 = rowid_to_column(df, "index")
test = as.data.frame(cbind(paste0(df1$index, "_", df1$start, "_", df$log_norm_count), paste0(df1$index, "_", df$end, "_", df$log_norm_count)))
test2 = as.data.frame(c(test$V1, test$V2))
good = arrange(test2, `c(test$V1, test$V2)`)
fin = separate(data = good, col = `c(test$V1, test$V2)`, into = c("idx", "pos", "val"), sep = "_")
# Make sure these next two columns are not interpreted as factors
fin$pos = as.numeric(fin$pos)
fin$val = as.numeric(fin$val)

ggplot(data = fin, aes(x=pos, y=val)) +
	geom_line() +
	geom_vline(xintercept = c(gene_positions$start_position, gene_positions$end_position), color = "blue") +
	xlab("Position") +
	ylab("Log Count Aligned Overlaps")

#save plot
ggsave(paste0(args[1],"_", args[2], "_", args[3], "_CNV_plot_with_Gene_start_end.png"), units = "cm", width = 20, height = 10)
# File format cramfileName_startCNV_endCNV_CNV_plot.png

ggplot(data = fin, aes(x=pos, y=val)) +
	geom_line() +
	xlab("Position") +
	ylab("Log Count Aligned Overlaps")

#save plot
ggsave(paste0(args[1],"_", args[2], "_", args[3], "_CNV_plot.png"), units = "cm", width = 20, height = 10)
# File format cramfileName_startCNV_endCNV_CNV_plot.png
