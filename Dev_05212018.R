setwd("C:/Users/dmash/Desktop")
library(ggplot2)

#importing MetaPhlan files

metaclass <- read.table("MetaPhlAn_LogNormwithMetadata_class.txt", header=TRUE)
metagenus <- read.table("MetaPhlAn_LogNormwithMetadata_genus.txt", header=TRUE)
metafamily <- read.table("MetaPhlAn_LogNormwithMetadata_family.txt", header=TRUE)
metaphylum <- read.table("MetaPhlAn_LogNormwithMetadata_phylum.txt", header=TRUE)
metaorder <- read.table("MetaPhlAn_LogNormwithMetadata_order.txt", header=TRUE)
metaspecies<- read.table("MetaPhlAn_LogNormwithMetadata_species.txt", header=TRUE)

#importing QIIME files

qiimephylum <- read.table("qiimeopenmerge_CSSwithMetadata_L_2.txt", header=TRUE)
qiimeclass <- read.table("qiimeopenmerge_CSSwithMetadata_L_3.txt", header=TRUE)
qiimeorder <- read.table("qiimeopenmerge_CSSwithMetadata_L_4.txt", header=TRUE)
qiimefamily <- read.table("qiimeopenmerge_CSSwithMetadata_L_5.txt", header=TRUE)
qiimegenus <- read.table("qiimeopenmerge_CSSwithMetadata_L_6.txt", header=TRUE)
qiimespecies <- read.table("qiimeopenmerge_CSSwithMetadata_L_7.txt", header=TRUE)

#practice plot with Sample Location and Doxycycline content
ggplot(data = metaclass) + aes(x = Sample.Location, fill = Doxycycline..ng.L.) + geom_bar()
