source('lib.R')

###

 if (!requireNamespace("BiocManager", quietly = TRUE))
   install.packages("BiocManager")
 BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
#BiocManager::install("TxDb.Mmusculus.UCSC.mm10.knownGene")
 BiocManager::install("org.Hs.eg.db")
 
install.packages('clusterProfiler')
library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
#library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(org.Hs.eg.db)

###

#NAME <- 'H3K36me3_SK-N-SH.ENCFF621CZO.hg19.filtered'
#NAME <- 'DeepZ'
NAME <- 'H3K36me3_SK-N-SH.ENCFF794VWV.hg19.filtered'
#NAME <- 'H3K36me3_SK-N-SH.intersect_with_DeepZ'
#NAME <- 'SK-N-SH_K562'
BED_FN <- paste0( NAME, '.bed')

###

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

#pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
png(paste0('chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()

# peak <- readPeakFile(BED_FN)
# pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
# covplot(peak, weightCol="V5")
# dev.off()
# 