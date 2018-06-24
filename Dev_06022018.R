setwd("C:/Users/dmash/Documents/R Microbiome Code/NC Urban Microbiome Project")
library(ggplot2)
library(reshape2)
input_files <- list.files(pattern=".txt")

for(i in 1:length(input_files)){
  j <- read.table(input_files[i], header=TRUE)
  k <- startsWith(input_files[i], "MetaPhlAn")
  if(k == TRUE) {
    meltmeta <- melt(j, id.vars=colnames(j)[1], measure.vars=colnames(j)[48:ncol(j)])
    input_files.plot <- ggplot(data=meltmeta) + aes(x=Row.names, fill=variable) + geom_bar()
    ggsave(filename = input_files, plot = last_plot(), device = "pdf", path = "C:/Users/dmash/Desktop", scale = 1, width = NA, height = NA, dpi = 300, limitsize = FALSE)
  } else{
    meltqiime <- melt(j, id.vars=colnames(j)[1], measure.vars=colnames(j)[51:ncol(j)])
    input_files.plot <- ggplot(data=meltqiime) + aes(x=Row.names, fill=variable) + geom_bar()
    ggsave(filename = input_files.pdf, plot = last_plot(), device = "pdf", path = "C:/Users/dmash/Desktop", scale = 1, width = NA, height = NA, dpi = 300, limitsize = FALSE)
  }
}

# make sure you state when the metadata ends for qiime and metaphlan (using if else?)
# ggsave
