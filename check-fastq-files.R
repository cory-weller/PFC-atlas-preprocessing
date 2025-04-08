#!/usr/bin/env Rscript

PROJDIR <- '/data/CARD_AUX/users/wellerca/PFC-atlas-preprocessing'
library(data.table) 
setwd('/data/CARD_AUX/users/wellerca/PFC-atlas-preprocessing')


# Import list of ATAC fastq files
atac.files <- fread('/data/CARD_AUX/SN_PFC_MULTIOME/PFC/snATAC_fastq/files.txt', header=FALSE)
atac.files[, 'modality' := 'ATAC']

# Import list of RNA fastq files
rna.files <- fread('/data/CARD_AUX/SN_PFC_MULTIOME/PFC/snRNA_fastq/files.txt', header=FALSE)
rna.files[, 'modality' := 'RNA']

# Bind together
dat <- rbind(atac.files, rna.files)
setnames(dat, 'V1', 'orig_path')

# Clean up
rm(rna.files)
rm(atac.files)

dat[, 'tmp1' := gsub('/vf/users/CARD_AUX/SN_PFC_MULTIOME/PFC/','', orig_path)]
dat[, c('v1','cohort','batch','psomagen_file','id_mode','flowcell','base_name') := tstrsplit(tmp1, split='/')]


# Wrangling
dat[, 'id' := tstrsplit(id_mode, split='_')[1]]

# Exclude Substantia Nigra samples
dat[, exclude := FALSE]
dat[id %like% '^SN', exclude := TRUE]
dat[id %like% '^SN', exclude_reason := 'SN Sample']
dat[id == '82073', exclude := TRUE]
dat[id == '82073', exclude_reason := 'MTG Sample']
dat[id=='943', exclude := TRUE]
dat[id=='943', exclude_reason := 'Triplicate Sample, use HBCC-1832 instead']
dat[id=='887', exclude := TRUE]
dat[id=='887', exclude_reason := 'Using files from SN tarfile location']
dat[id=='81962', exclude := TRUE]
dat[id=='81962', exclude_reason := 'Triplicate sample, use HBCC-1832 instead']

dat.hbcc <- dat[cohort=='hbcc']
dat.nabec <- dat[cohort=='nabec']
rm(dat)

# Fix transcribed sample error, rename 81972 as 81984
dat.hbcc[id == 81972, 'id' := 81984]


## Fix 8xxxx HBCC IDs
dat.hbcc[, 'hbcc_id' := as.numeric(id)]
hbcc_ids <- fread('hbcc-ids.txt')
hbcc_ids <- unique(hbcc_ids)    # Remove duplicated rows
setnames(hbcc_ids, c('newid','oldid'))

dat.hbcc <- merge(x=dat.hbcc, hbcc_ids,, by.x='hbcc_id', by.y='oldid', all.x=TRUE)
dat.hbcc[is.na(newid), 'newid' := id]
dat.hbcc[, 'hbcc_id' := NULL]
dat.hbcc[, 'id' := NULL]
setnames(dat.hbcc, 'newid', 'id')
dat.hbcc[exclude != TRUE, id := paste0('HBCC-',id)]

dat <- rbindlist(list(dat.nabec, dat.hbcc), use.names=TRUE)
rm(dat.hbcc)
rm(dat.nabec)
dat[, 'v1' := NULL]
dat[, 'tmp1' := NULL]


# Add missing HBCC-887
missing.rna <- fread('missing_887_rna.txt', header=F)
missing.rna[, 'modality' := 'RNA']

missing.atac <- fread('missing_887_atac.txt', header=F)
missing.atac[, 'modality' := 'ATAC']
missing <- rbind(missing.rna, missing.atac)
missing[, 'cohort' := 'hbcc']
missing[, batch := 'batch5']    # Should have been HBCC final batch

missing[, tmp1 := gsub('/data/CARD_AUX/users/catchingba/SN/', '', V1)]
missing[, 'tmp1' := gsub('_10X_RawData_Outs','',tmp1)]
missing[, c('psomagen_file','id_mode','flowcell','base_name') := tstrsplit(tmp1, split='/')]
missing[, 'tmp1' := NULL]
setnames(missing, 'V1', 'orig_path')
missing[, 'id' := 'HBCC-887']
missing[, 'exclude' := FALSE]
missing[, 'exclude_reason' := NA]

dat <- rbind(dat, missing)



# Manually fix sample swaps
# SWAP LABELS between HBCC-1536 and HBCC-3081
dat[id=='HBCC-1536', id := 'HBCC-3081-TMP']
dat[id=='HBCC-3081', id := 'HBCC-1536']
dat[id=='HBCC-3081-TMP', id := 'HBCC-3081']


# HBCC-1832, originally batch1 (now batch 6 with +5)
dat[id=='HBCC-1832', id := 'HBCC-943']

removed.samples <- dat[exclude == TRUE]
dat <- dat[exclude == FALSE]
dat[, exclude := NULL]
dat[, exclude_reason := NULL]


# Create numeric column for batch ID
dat[, 'batchN' := as.numeric(gsub('batch','',batch))]

# Increment HBCC samples by 5, such that
# NABEC = 1-5
# HBCC  = 6-10
dat[cohort == 'hbcc', 'batchN' := batchN + 5]
dat[, batch := NULL]

# HBCC-887 ATAC: AN00016884 batch10
# HBCC-887 RNA: AN00016354 batch10 (relabel from 6)

# Load list of final selected NABEC samples
nabec.final <- fread('nabec_final_samples_no_dups.csv')
nabec.final[, batchN := as.numeric(gsub('batch','',batch))]
nabec.final[, 'cohort' := 'nabec']

# Load list of final selected HBCC samples and merge batching information
hbcc.final <- fread('hbcc_final_samples_no_dups.csv')
hbcc.final[, batchN := 5 + as.numeric(gsub('batch','',batch))]
hbcc.final[, sample := gsub('-ARC','',sample)]
hbcc.final[, sample := paste0('HBCC-',sample)]
hbcc.final[, 'cohort' := 'hbcc']
hbcc.final <- hbcc.final[ sample != 'HBCC-943']
hbcc.final[sample == 'HBCC-1832', sample := 'HBCC-943']

used.samples <- rbindlist(list(nabec.final, hbcc.final))
used.samples[, 'batch' := NULL]
setnames(used.samples, 'sample', 'id')

# 
dt <- rbindlist(list(
data.table(used.samples, 'modality'='ATAC'),
data.table(used.samples, 'modality'='RNA')
))
dt[, good := TRUE]

setkey(dt, cohort, id, modality, batchN)
setkey(dat, cohort, id, modality, batchN)


dat <- merge(dat, dt, all.y=T)

metadata <- fread('/vf/users/CARD_singlecell/PFC_atlas/input/metadata.csv', header=T)
metadata <- metadata[SampleID != 'HBCC-1832']
metadata[, batchN := as.numeric(gsub('batch','',batch))]
metadata[cohort == 'HBCC', batchN := 5+batchN]

# Update HBCC-943 to match its true batch (when processed as HBCC-1832)
metadata[SampleID == 'HBCC-943', batchN := 6]
metadata[, 'batch' := NULL]
setnames(metadata, 'batchN', 'batch')

fwrite(metadata, file='pfc-metadata-359.csv', quote=F, sep=',', row.names=F, col.names=T, append=T)

dat[, tmp := gsub('_S[0-9]{1,}_','_S1_', base_name)]
dat[, suffix := tstrsplit(tmp, split='_S1_L')[2]]
dat[, new_basename := paste0(id, '_S1_L', suffix)]
dat[, modality := paste0('sn',modality)]
dat[, cohort := toupper(cohort)]
dat[, new_dir := paste0(cohort, '/', modality, '/', flowcell, '/', id)]
dat[, new_path := paste0(new_dir, '/', new_basename)]

# # Make new directories
# lapply(unique(dat$new_dir), function(x) dir.create(x, recursive=TRUE))

# # Create file-copying script
# writeLines('#!/usr/bin/env bash', con='copy_files.sh')
# fwrite(data.table('mv'='cp', '2'=dat$orig_path, '3'=dat$new_path), file='copy_files.sh', quote=F, row.names=F, col.names=F, sep=' ')

setnames(dat, 'id', 'sample')
if(FALSE) {
# Build samplesheets
for(i in unique(dat$sample)) {
    ss <- dat[sample==i]
    ss[modality=='snATAC', 'library_type' := 'Chromatin Accessibility']
    ss[modality=='snRNA', 'library_type' := 'Gene Expression']
    ss[, fastqs := paste0(PROJDIR, '/', new_dir)]
    ss[, fastqs := dirname(fastqs)]
    ss <- unique(ss[, .SD, .SDcols=c('fastqs','sample','library_type')])
    fwrite(ss, file=paste0('SAMPLESHEETS/', i, '.csv'), sep=',', quote=F)
}

# HBCC-2998

if(FALSE) {
    tar('unused_files.tar', files=unused.files, compression='none')
}


}
## Are SN samples properly handled?