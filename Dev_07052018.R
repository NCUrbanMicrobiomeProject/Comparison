library(ggplot2)
library(reshape2)
input_files <- list.files(pattern=".txt")

for(i in 1:length(input_files)){
  j <- read.table(input_files[i], header=TRUE)
  k <- startsWith(input_files[i], "MetaPhlAn")
  if(k == TRUE) {
    start <- 48
    meltmeta <- melt(j, id.vars=colnames(j)[1], measure.vars=colnames(j)[start:ncol(j)])
    attach(meltmeta)
    sortmeltmeta <- meltmeta[order(-value),]
    require(data.table)
    metagroup <- data.table(sortmeltmeta)
    metamax <- metagroup[metagroup[, .I[value == max(value)], by=variable]$V1]
    topmeta <- data.frame(metagroup[1:10])
    input_files.plot <- ggplot(data=topmeta) + aes(x=rownames(topmeta, do.NULL = TRUE, prefix = "Row"), fill=variable) + geom_bar()
    ggsave(filename = paste("metaphlan.pdf"), plot = input_files.plot, device = "pdf", path = "~", scale = 1, width = NA, height = NA, dpi = 300, limitsize = TRUE)

    
    
    
  } else{
    start <- 51
    meltqiime <- melt(j, id.vars=colnames(j)[1], measure.vars=colnames(j)[start:ncol(j)])
    attach(meltqiime)
    sortmeltqiime <- meltqiime[order(-value),]
    require(data.table)
    qiimegroup <- data.table(sortmeltqiime)
    qiimemax <- qiimegroup[qiimegroup[, .I[value == max(value)], by=variable]$V1]
    topqiime <- data.frame(qiimemax[1:10])
    input_files.plot <- ggplot(data=topqiime) + aes(x=rownames(topqiime, do.NULL = TRUE, prefix = "Row"), fill=variable) + geom_bar()
    ggsave(filename = paste("qiime.pdf"), plot = input_files.plot, device = "pdf", path = "~", scale = 1, width = NA, height = NA, dpi = 300, limitsize = TRUE)
    
  }
}

# make sure you state when the metadata ends for qiime and metaphlan (using if else?)
# ggsave


