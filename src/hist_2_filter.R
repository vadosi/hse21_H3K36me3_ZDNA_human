#NAME <- 'H3K36me3_SK-N-SH.ENCFF621CZO.hg19'
#NAME <- 'H3K36me3_SK-N-SH.ENCFF794VWV.hg19'
NAME <- 'H3K36me3_SK-N-SH.intersect_with_DeepZ'
#NAME <- 'SK-N-SH_K562'
require(dplyr)
###

bed_df <- read.delim(paste0(NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('filter_peaks.', NAME, '.init.hist.pdf'))

# Remove long peaks
bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 2000)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('filter_peaks.', NAME, '.filtered.hist.pdf'))

bed_df %>%
  select(-len) %>%
  write.table(file=paste0(NAME ,'.filtered.bed'),
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)
