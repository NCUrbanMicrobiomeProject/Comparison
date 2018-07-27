setwd("C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project")
library(ggplot2)
library(reshape2)
input_files <- list.files(pattern=".txt")

for(i in 1:length(input_files)){
  j <- read.table(input_files[i], header=TRUE)
  k <- grepl("metaphlan", input_files[i], ignore.case = TRUE)
  if(k == TRUE) {
    start <- 48
    meltmeta <- melt(j, id.vars=colnames(j)[4], measure.vars=colnames(j)[start:ncol(j)])
    setwd("C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project/melted_files")
    write.table(meltmeta, file = paste0("melt", input_files[i]), sep = "\t", row.names = FALSE, append = FALSE)
    setwd("C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project/")
    attach(meltmeta)
    sortmeltmeta <- meltmeta[order(-meltmeta$value),]
    require(data.table)
    metagroup <- data.table(sortmeltmeta)
    metamax <- metagroup[metagroup[, .I[value == max(value)], by=variable]$V1]
    topmeta <- data.frame(metamax[1:30])
    input_files.plot <- ggplot(data=topmeta) + aes(y=value, x=Sample.Location, fill=variable) + geom_bar(stat = "identity") + theme(legend.position = "")
    ggsave(filename = paste("plot", input_files[i], ".pdf"), plot = input_files.plot, device = "pdf", path = "C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project/metaphlan_plots", width = NA, height = NA, dpi = 300, limitsize = TRUE)
    
    
  } else{
    start <- 51
    meltqiime <- melt(j, id.vars=colnames(j)[4], measure.vars=colnames(j)[start:ncol(j)])
    setwd("C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project/melted_files")
    write.table(meltqiime, file = paste0("melt", input_files[i]), sep = "\t", row.names = FALSE, append = FALSE)
    setwd("C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project/")
    attach(meltqiime)
    sortmeltqiime <- meltqiime[order(-meltqiime$value),]
    require(data.table)
    qiimegroup <- data.table(sortmeltqiime)
    qiimemax <- qiimegroup[qiimegroup[, .I[value == max(value)], by=variable]$V1]
    topqiime <- data.frame(qiimemax[1:30])
    input_files.plot <- ggplot(data=topqiime) + aes(y=value, x=Sample.Location, fill=variable) + geom_bar(stat = "identity") + theme(legend.position = "")
    ggsave(filename = paste("plot", input_files[i], ".pdf"), plot = input_files.plot, device = "pdf", path = "C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project/qiime_plots", width = 10, height = 10, dpi = 300, limitsize = TRUE)
    
  }
}