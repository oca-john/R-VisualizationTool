#!/usr/bin/Rscript
library(dplyr)
a <- read.csv("PKD-鉴别诊断基因总LIST.csv", header = FALSE)
b <- read.csv("第一批-T12-cnv.csv", header = TRUE)
write.csv(filter(b, b$X.gene %in% a$V1), file = "result.csv", row.names = FALSE)
