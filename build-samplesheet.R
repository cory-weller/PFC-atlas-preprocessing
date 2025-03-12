#!/usr/bin/env Rscript

library(data.table)

## Params
hbcc_directory <- 'HBCC'
nabec_directory <- 'NABEC'
parent_directory <- '/data/CARD_AUX/users/wellerca/PFC-atlas-preprocessing'

hbcc.files <- list.files(hbcc_directory, recursive=T, pattern='*.fastq.gz', full.names=T)
nabec.files <- list.files(nabec_directory, recursive=T, pattern='*.fastq.gz', full.names=T)

dat <- data.table(file_path=c(hbcc.files,nabec.files))
dat[, file_path := paste0(parent_directory, '/', file_path)]
#dat[, file_name := basename(file_path)]

dat[, c('cohort','modality','FlowCell','sample','file_name') := tstrsplit(file_path, split='/')[7:11]]
dat[, modality := gsub('_fastq','',modality)]

samples <- unique(dat$sample)

hbcc_samples_kept <- fread('hbcc_final_samples_no_dups.csv')
hbcc_samples_kept[, cohort := 'HBCC']
hbcc_samples_kept[, sample := gsub('-ARC','', sample)]
hbcc_samples_kept[, sample := paste0('HBCC-', sample)]
hbcc_samples_kept[, batchN := gsub('batch','', batch)]
hbcc_samples_kept[, batchN := as.numeric(batchN) + 5]
hbcc_samples_kept[, batch := NULL]

nabec_samples_kept <- fread('nabec_final_samples_no_dups.csv')
nabec_samples_kept[, cohort := 'NABEC']
nabec_samples_kept[, batchN := gsub('batch','', batch)]
nabec_samples_kept[, batchN := as.numeric(batchN)]
nabec_samples_kept[, batch := NULL]

kept_samples <- rbind(nabec_samples_kept, hbcc_samples_kept)
kept_samples[, used := TRUE]

runids <- fread('seq-batch-id.csv')

dat.sub <- dat[, .SD, .SDcols=c('cohort','modality','FlowCell','sample')]
dat.sub <- unique(dat.sub)
setkey(runids, cohort, modality, FlowCell)
setkey(dat.sub, cohort, modality, FlowCell)

dat.sub <- merge(runids, dat.sub)

setkey(kept_samples, sample, cohort, batchN)
setkey(dat.sub, sample, cohort, batchN)
dat.sub <- merge(dat.sub, kept_samples, all=TRUE)
dat.sub[is.na(used), used := FALSE]

fwrite(dat.sub, file='pfc-sample-metadata.csv', quote=F)


setdiff(unique(dat.sub[used==FALSE]$sample), unique(dat.sub[used==TRUE & sample %in% unique(dat.sub[used==FALSE]$sample)]$sample))