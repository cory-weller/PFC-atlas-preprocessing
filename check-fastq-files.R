#!/usr/bin/env Rscript

PROJDIR <- '/data/CARD_AUX/users/wellerca/PFC-atlas-preprocessing'
library(data.table) 
setwd('/data/CARD_AUX/users/wellerca/PFC-atlas-preprocessing')
hbcc.files <- list.files('HBCC', recursive=T, pattern='*.fastq.gz', full.names=T)
nabec.files <- list.files('NABEC', recursive=T, pattern='*.fastq.gz', full.names=T)

dat <- data.table(fn=c(hbcc.files,nabec.files))

dat[, c('cohort','modality','FlowCell','sample','fastq') := tstrsplit(fn, split='/')]
dat[, modality := gsub('_fastq','',modality)]
samples <- unique(dat$sample)


# Load table of samples

metadata <- fread('pfc-sample-metadata.csv')

setkey(metadata, cohort, sample, modality, FlowCell)
setkey(dat, cohort, sample, modality, FlowCell)



dat <- merge(dat, metadata)


unused.files <- dat[used==FALSE]$fn

stopifnot(length(unused.files) == 0)
writeLines(sort(unique(dat$sample)), con='SAMPLES.txt')
dat[, fastq := NULL]
fwrite(dat, file='pfc-files-metadata.csv', sep=',', quote=F)

# Build samplesheets
for(i in unique(dat$sample)) {
    ss <- dat[sample==i]
    ss[modality=='snATAC', 'library_type' := 'Chromatin Accessibility']
    ss[modality=='snRNA', 'library_type' := 'Gene Expression']
    ss[, fastqs := paste0(PROJDIR, '/', fn)]
    ss[, fastqs := dirname(fastqs)]
    ss <- unique(ss[, .SD, .SDcols=c('fastqs','sample','library_type')])
    fwrite(ss, file=paste0('SAMPLESHEETS/', i, '.csv'), sep=',', quote=F)
}



if(FALSE) {
    tar('unused_files.tar', files=unused.files, compression='none')
}

