#!/usr/bin/env Rscript

library(data.table) 

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

if(FALSE) {
    tar('unused_files.tar', files=unused.files, compression='none')
}

