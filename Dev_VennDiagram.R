setwd("C:/Users/dmash/Documents/R Microbiome Code/NC Urban Microbiome Project")
library(ggplot2)
library(reshape2)
library(VennDiagram)
library(limma)

#importing MetaPhlan files

metaclass <- read.table("MetaPhlAn_LogNormwithMetadata_class.txt", header=TRUE)
metagenus <- read.table("MetaPhlAn_LogNormwithMetadata_genus.txt", header=TRUE)
metafamily <- read.table("MetaPhlAn_LogNormwithMetadata_family.txt", header=TRUE)
metaphylum <- read.table("MetaPhlAn_LogNormwithMetadata_phylum.txt", header=TRUE)
metaorder <- read.table("MetaPhlAn_LogNormwithMetadata_order.txt", header=TRUE)
#metaspecies<- read.table("MetaPhlAn_LogNormwithMetadata_species.txt", header=TRUE)

#importing QIIME files

qiimephylum <- read.table("ra_p_qiimewMetadata.txt", header=TRUE)
qiimeclass <- read.table("ra_c_qiimewMetadata.txt", header=TRUE)
qiimeorder <- read.table("ra_o_qiimewMetadata.txt", header=TRUE)
qiimefamily <- read.table("ra_f_qiimewMetadata.txt", header=TRUE)
qiimegenus <- read.table("ra_g_qiimewMetadata.txt", header=TRUE)
#qiimespecies <- read.table("qiimeopenmerge_CSSwithMetadata_L_7.txt", header=TRUE)

#Melting Metaphlan Data

metaclass_melt <- melt(metaclass, id.vars=colnames(metaclass)[c(4,31)], measure.vars=colnames(metaclass)[48:ncol(metaclass)])
metafamily_melt <- melt(metafamily, id.vars=colnames(metafamily)[c(4,31)], measure.vars=colnames(metafamily)[48:ncol(metafamily)])
metagenus_melt <- melt(metagenus, id.vars=colnames(metagenus)[c(4,31)], measure.vars=colnames(metagenus)[48:ncol(metagenus)])
metaphylum_melt <- melt(metaphylum, id.vars=colnames(metaphylum)[c(4,31)], measure.vars=colnames(metaphylum)[48:ncol(metaphylum)])
metaorder_melt <- melt(metaorder, id.vars=colnames(metaorder)[c(4,31)], measure.vars=colnames(metaorder)[48:ncol(metaorder)])
#metaspecies_melt <- melt(metaspecies, id.vars=colnames(metaspecies)[1], measure.vars=colnames(metaspecies)[48:802])

#Melting QIIME Data

qiimeclass_melt <- melt(qiimeclass, id.vars=colnames(qiimeclass)[c(4,31)], measure.vars=colnames(qiimeclass)[49:ncol(qiimeclass)])
qiimefamily_melt <- melt(qiimefamily, id.vars=colnames(qiimefamily)[c(4,31)], measure.vars=colnames(qiimefamily)[49:ncol(qiimefamily)])
qiimegenus_melt <- melt(qiimegenus, id.vars=colnames(qiimegenus)[c(4,31)], measure.vars=colnames(qiimegenus)[49:ncol(qiimegenus)])
qiimephylum_melt <- melt(qiimephylum, id.vars=colnames(qiimephylum)[c(4,31)], measure.vars=colnames(qiimephylum)[49:ncol(qiimephylum)])
qiimeorder_melt <- melt(qiimeorder, id.vars=colnames(qiimeorder)[c(4,31)], measure.vars=colnames(qiimeorder)[49:ncol(qiimeorder)])
#qiimespecies_melt <- melt(qiimespecies, id.vars=colnames(qiimespecies)[1], measure.vars=colnames(qiimespecies)[49:2650])


#Get just the taxa names

metaphylumvar <- unique(metaphylum_melt$variable)
qiimephylumvar <- unique(qiimephylum_melt$variable)
metaclassvar <- unique(metaclass_melt$variable)
qiimeclassvar <- unique(qiimeclass_melt$variable)
metafamilyvar <- unique(metafamily_melt$variable)
qiimefamilyvar <- unique(qiimefamily_melt$variable)
metagenusvar <- unique(metagenus_melt$variable)
qiimegenusvar <- unique(qiimegenus_melt$variable)
metaordervar <- unique(metaorder_melt$variable)
qiimeordervar <- unique(qiimeorder_melt$variable)

#Split the names in QIIME

qiimephylumsplit <- strsplit2(qiimephylumvar, split=".p__")
qiimeclasssplit <- strsplit2(qiimeclassvar, split=".c__")
qiimefamilysplit <- strsplit2(qiimefamilyvar, split=".f__")
qiimeordersplit <- strsplit2(qiimeordervar, split=".o__")
qiimegenussplit <- strsplit2(qiimegenusvar, split=".g__")

#Separate to get the specific taxa names

qiimephylumtaxa <- qiimephylumsplit[,c(2)]
qiimeclasstaxa <- qiimeclasssplit[,c(2)]
qiimefamilytaxa <- qiimefamilysplit[,c(2)]
qiimeordertaxa <- qiimeordersplit[,c(2)]
qiimegenustaxa <- qiimegenussplit[,c(2)]


