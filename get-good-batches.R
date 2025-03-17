#!/usr/bin/env Rscript

library(data.table)

hbcc.samples <- fread('/data/CARD_singlecell/Brain_atlas/HBCC_multiome/hbcc_final_samples_no_dups.csv')
nabec.samples <- fread('/data/CARD_singlecell/Brain_atlas/NABEC_multiome/nabec_final_samples_no_dups.csv')
hbcc.samples[, sample := tstrsplit(sample, split='-')[1]]
hbcc.samples[, sample := paste0('HBCC-', sample)]
hbcc.samples[,


ANids <- fread('Seq_Batch_IDs.csv')

dat <- fread('renaming.txt', header=F)
dat[, 'ID' := tstrsplit(V1, split='/')[4]]
dat[, 'ID' := tstrsplit(ID, split='_')[1]]
dat <- unique(dat[, .SD, .SDcols=c('V5','ID')])
setnames(dat, c('FlowCell','ID'))


hbcc.flowcells <- fread(cmd="find HBCC/ -name '*.fastq.gz' | cut -d '/' -f 3 | sort -u", header=F)
hbcc.flowcells[, 'cohort' := 'HBCC']
setnames(hbcc.flowcells, 'V1', 'FlowCell')
nabec.flowcells <- fread(cmd="find NABEC/ -name '*.fastq.gz' | cut -d '/' -f 3 | sort -u", header=F)
nabec.flowcells[, 'cohort' := 'NABEC']
setnames(nabec.flowcells, 'V1', 'FlowCell')
flowcells <- rbind(hbcc.flowcells, nabec.flowcells)

merge(dat,flowcells, by='FlowCell', all=T)

# HL7YMDSX5       <NA>  NABEC
# HTWVGDSX5       <NA>  NABEC
# HL7YMDSX5for NABEC scRNA batch 1
# HTWVGDSX5for NABEC scRNA batch 2

dat <- merge(dat, ANids, by='ID')[order(cohort,batch,modality)]
setnames(fns, 'V5', 'FlowCell')
setkey(fns, ID, FlowCell)

setkey(dat, ID, FlowCell)

dat <- merge(dat, fns)

metadata <- fread('PFC-Atlas-Sample-Metadata.csv')

# For HBCC, increment sequencing batch by 5
dat[, SequencingBatch := gsub('batch','', batch)]
dat[, SequencingBatch := as.numeric(SequencingBatch)]
dat[cohort=='HBCC', SequencingBatch := SequencingBatch + 5]
dat[, batch := NULL]

setnames(dat, 'V4', 'IID')

dat <- unique(dat[, .SD, .SDcols=c('FlowCell','cohort','modality','SequencingBatch')])



dt <- data.table(fn=list.files('.', recursive=T, pattern='*.fastq.gz'))
dt <- dt[fn %like% '^HBCC' | fn %like% '^NABEC']

dt[, c('cohort','modality','FlowCell','file') := tstrsplit(fn, split='/')]
dt[, 'IID' := tstrsplit(file, split='_')[1]]





dat <- rbindlist(list(dat,
data.table('FlowCell'= 'HL7YMDSX5',
            'cohort'= 'NABEC',
            'modality'= 'scRNA',
            'SequencingBatch'= 1
),
data.table('FlowCell'= 'HTWVGDSX5',
            'cohort'= 'NABEC',
            'modality'= 'scRNA',
            'SequencingBatch'= 2
)))[order(SequencingBatch,cohort, modality)]

dat <- merge(dt, dat, by='FlowCell', all=T)

dat[, modality.x := NULL]
setnames(dat, 'modality.y', 'modality')
dat[, cohort.x := NULL]
setnames(dat, 'cohort.y', 'cohort')

mdata <- metadata[, .SD, .SDcols=c('IID','Cohort','SequencingBatch')]
setnames(mdata, 'Cohort','cohort')

setkey(mdata, IID, cohort, SequencingBatch)
setkey(dat, IID, cohort, SequencingBatch)

dat.merge <- merge(dat,mdata, all=T)

