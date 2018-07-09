library(ggplot2)
library(reshape2)
input_files <- list.files(pattern=".txt")

for(i in 1:length(input_files)){
  j <- read.table(input_files[i], header=TRUE)
  k <- startsWith(input_files[i], "MetaPhlAn")
  if(k == TRUE) {
    start <- 48
    meltmeta <- melt(j, id.vars=colnames(j)[4], measure.vars=colnames(j)[start:ncol(j)])
    attach(meltmeta)
    sortmeltmeta <- meltmeta[order(-value),]
    require(data.table)
    metagroup <- data.table(sortmeltmeta)
    metamax <- metagroup[metagroup[, .I[value == max(value)], by=variable]$V1]
    topmeta <- data.frame(metamax[1:30])
    input_files.plot <- ggplot(data=topmeta) + aes(x=Sample.Location, fill=variable) + geom_bar()
    ggsave(filename = paste("metaphlan.pdf"), plot = input_files.plot, device = "pdf", path = "~", width = NA, height = NA, dpi = 300, limitsize = TRUE)

    
    
    
  } else{
    start <- 51
    meltqiime <- melt(j, id.vars=colnames(j)[4], measure.vars=colnames(j)[start:ncol(j)])
    attach(meltqiime)
    sortmeltqiime <- meltqiime[order(-value),]
    require(data.table)
    qiimegroup <- data.table(sortmeltqiime)
    qiimemax <- qiimegroup[qiimegroup[, .I[value == max(value)], by=variable]$V1]
    topqiime <- data.frame(qiimemax[1:20])
    input_files.plot <- ggplot(data=topqiime) + aes(x=Sample.Location, fill=variable) + geom_bar()
    ggsave(filename = paste("qiime.pdf"), plot = input_files.plot, device = "pdf", path = "~", width = 10, height = 10, dpi = 300, limitsize = TRUE)
    
  }
}



