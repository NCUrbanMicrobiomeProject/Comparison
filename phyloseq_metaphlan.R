rm(list=ls())
library("phyloseq")
library("ggplot2")

taxaLevels <- c("p", "c", "o", "f", "g")
formalTaxaLevels <- c("phylum", "class", "order", "family", "genus")

if (.Platform$OS.type == "unix") {
  projectDir <- "/Volumes/GoogleDrive/My Drive/Programs/Normalizations"  
} else {
  projectDir <- "C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project"
}
setwd(projectDir)

if (.Platform$OS.type == "unix") {
  qiimeDir <- "/Volumes/GoogleDrive/My Drive/Datasets/Wastewater/qiime/otus_nochimTest/processed"  
  metaphlanDir <- "/Volumes/GoogleDrive/My Drive/Datasets/Wastewater/MetaPhlAn/processed/"
} else {
  qiimeDir <- "C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project"
  metaphlanDir <- "C:/Users/dmash/OneDrive/Documents/R Microbiome Code/NC Urban Microbiome Project"
}

for(i in 1:length(taxaLevels)){
  qiimeName <- paste0("ra_",taxaLevels[i],"_qiimewMetadata.txt")
  setwd(qiimeDir)
  qiime.raw <- read.table(qiimeName, header=TRUE, sep='\t', check.names = FALSE)
  qiimeTaxaColStart <- 49
  qiimeMetadata <- 1:48
  
  #qiime.raw <- qiime.raw[!duplicated(qiime.raw),]
  dropqiime <- c("30SEPT2016HiSeq_Run_Sample_1_UNCC_Gibas_CAGATCTG_L008_UPA4_S_profile", 
                 "26SEPT2016HiSeq_Run_Sample_2_UNCC162_Gibas_ACTTGATG_L001_UPA4_S_profile")
  
  qiime.raw <- qiime.raw[!(qiime.raw$MetaPhlAnResults2 %in% dropqiime),]
  
  metaphlanName <- paste0("MetaPhlAn_LogNormwithMetadata_",formalTaxaLevels[i],".txt")
  setwd(metaphlanDir)
  metaphlan.raw <- read.table(metaphlanName, header=TRUE, sep='\t', check.names = FALSE, comment.char="@")
  metaphlanTaxaColStart <- 48
  metaphlanMetadata <- 1:47
  
  orderThing <- intersect(metaphlan.raw$MetaPhlAnResults2, qiime.raw$MetaPhlAnResults2)
  
  metaphlan.raw <- metaphlan.raw[match(orderThing, qiime.raw$MetaPhlAnResults2),] 
  metaphlan.raw <- metaphlan.raw[match(orderThing, metaphlan.raw$MetaPhlAnResults2),]
  metaphlan.raw$Sample <- ifelse((metaphlan.raw$Sample == "UW A") | (metaphlan.raw$Sample == "UW B") | (metaphlan.raw$Sample == "MNT A") | (metaphlan.raw$Sample == "MNT B"), "Control", ifelse((metaphlan.raw$Sample == "UP A") | (metaphlan.raw$Sample == "UP B"), "Upstream", ifelse((metaphlan.raw$Sample == "DS A") | (metaphlan.raw$Sample == "DS B"), "Downstream", ifelse((metaphlan.raw$Sample == "HOSP") | (metaphlan.raw$Sample == "RES") | (metaphlan.raw$Sample == "INF"), "Influent", ifelse((metaphlan.raw$Sample == "UV") | (metaphlan.raw$Sample == "PCE") |(metaphlan.raw$Sample == "ATE")|(metaphlan.raw$Sample == "PCI") | (metaphlan.raw$Sample == "FCE"), "WWTP", NA)))))
  metaphlan.raw <- metaphlan.raw[complete.cases(metaphlan.raw),]
  otumat = metaphlan.raw[,metaphlanTaxaColStart:ncol(metaphlan.raw)]
  rownames(otumat) <- metaphlan.raw$MetaPhlAnResults2
  otumat <- data.matrix(otumat)
  
  #testo <- colnames(otumat)[1:10]
  #otumat <- otumat[1:10, ]
  
  tax.split <- strsplit(colnames(otumat), split=paste0("\\.", taxaLevels[i], "__"))
  # Then remove the first of each element b/c that is the kingdom
  tax.remain <- lapply(tax.split, function(x) ifelse(length(x) > 1, x[-1], x[1]))
  tax.df <- t(data.frame(matrix(unlist(tax.remain), ncol=length(unlist(tax.remain)), byrow=T)))
  rownames(tax.df) <- colnames(otumat)
  colnames(tax.df) <- formalTaxaLevels[1:ncol(tax.df)]
  taxmat <- as.matrix(tax.df)
  OTU = otu_table(otumat, taxa_are_rows = FALSE)
  TAX = tax_table(taxmat)
  sampledata = sample_data(metaphlan.raw[,metaphlanMetadata])
  rownames(sampledata) <- rownames(OTU)
  physeq = phyloseq(OTU, TAX, sampledata)
  test.subset = subset_taxa(physeq, phylum == "Actinobacteria")
  test.subset = subset_samples(physeq, Location == "Mallard Creek")
  plot_bar(test.subset, fill = "phylum", title = "MetaPhlAn Relative Abundance: Phylum") + theme(axis.title.x=element_blank(),axis.text.x=element_blank(), axis.ticks.x = element_blank())
  metaphlan.ord <- ordinate(physeq, method = "PCoA", distance = "bray")
  p1 <- plot_ordination(physeq, metaphlan.ord, type="samples", color= "Sample", title="Samples by Location: MetaPhlAn", shape = "Location")
  p1 <- plot_ordination(physeq, metaphlan.ord, type="taxa", color="phylum", title="taxa")
  print(p1)
  #p1 + facet_wrap(~phylum, 5)
}


#make the equivalent graph for Metaphlan 
#Explore different variables and produce a couple more PCoA plots
#Captions for pictures 
#Save ALL pictures as PDF and convert
#Resolution of at least 300, maybe higher (600?)
#Draft by tomorrow