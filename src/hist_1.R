require(ggplot2)
###

#NAME <- 'DeepZ'
#NAME <- 'H3K36me3_SK-N-SH.ENCFF621CZO.hg19'
#NAME <- 'H3K36me3_SK-N-SH.ENCFF621CZO.hg38'
#NAME <- 'H3K36me3_SK-N-SH.ENCFF794VWV.hg19'
NAME <- 'H3K36me3_SK-N-SH.ENCFF794VWV.hg38'

###

bed_df <- read.delim(paste0(NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'))

