#!/usr/bin/Rscript

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))

args = commandArgs(TRUE)

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

ggplot(data = fin, aes(x=pos, y=val)) + geom_line() + xlab("Position") + ylab("Log Count Aligned Overlaps")

#save plot
ggsave(paste0(args[1],"_", args[2], "_", args[3], "_CNV_plot.png"), units = "cm", width = 20, height = 10)
# File format cramfileName_startCNV_endCNV_CNV_plot.png
