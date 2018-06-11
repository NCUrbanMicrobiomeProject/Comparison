setwd("C:/Users/dmash/Documents/R Microbiome Code/ NC Urban Microbiome Project")
library(ggplot2)
library(reshape2)
input_files <- list.files(pattern=".txt")

for(i in 1:length(input_files)){
   j <- read.table(input_files[i], header=TRUE)
   k <- input_files[i].startswith("MetaPhlAn")
   if(k = TRUE) {
     melted <- melt(j, id.vars=colnames(j)[1], measure.vars=colnames(j)[48:length(j.cols)])
  } else{
     melted <- melt(j, id.vars=colnames(j)[1], measure.vars=colnames(j)[50:length(j.cols)])
}
}  
