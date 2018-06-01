setwd("C:/Users/dmash/Desktop")
library(ggplot2)
library(reshape2)

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

#Melting Metaphlan Data

metaclass_melt <- melt(metaclass, id.vars=colnames(metaclass)[1], measure.vars=colnames(metaclass)[48:83])
metafamily_melt <- melt(metafamily, id.vars=colnames(metafamily)[1], measure.vars=colnames(metafamily)[48:206])
metagenus_melt <- melt(metagenus, id.vars=colnames(metagenus)[1], measure.vars=colnames(metagenus)[48:413])
metaphylum_melt <- melt(metaphylum, id.vars=colnames(metaphylum)[1], measure.vars=colnames(metaphylum)[48:69])
metaorder_melt <- melt(metaorder, id.vars=colnames(metaorder)[1], measure.vars=colnames(metaorder)[48:124])
metaspecies_melt <- melt(metaspecies, id.vars=colnames(metaspecies)[1], measure.vars=colnames(metaspecies)[48:802])

#Melting QIIME Data

qiimeclass_melt <- melt(qiimeclass, id.vars=colnames(qiimeclass)[1], measure.vars=colnames(qiimeclass)[51:321])
qiimefamily_melt <- melt(qiimefamily, id.vars=colnames(qiimefamily)[1], measure.vars=colnames(qiimefamily)[51:1067])
qiimegenus_melt <- melt(qiimegenus, id.vars=colnames(qiimegenus)[1], measure.vars=colnames(qiimegenus)[51:2125])
qiimephylum_melt <- melt(qiimephylum, id.vars=colnames(qiimephylum)[1], measure.vars=colnames(qiimephylum)[51:126])
qiimeorder_melt <- melt(qiimeorder, id.vars=colnames(qiimeorder)[1], measure.vars=colnames(qiimeorder)[51:638])
qiimespecies_melt <- melt(qiimespecies, id.vars=colnames(qiimespecies)[1], measure.vars=colnames(qiimespecies)[51:2650])
