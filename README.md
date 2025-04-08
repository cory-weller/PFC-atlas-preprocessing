# README

## TODO
- remove unnecessary files


```bash



```
```bash
find /data/CARD_singlecell/Brain_atlas -maxdepth 4 -name '*RawData_Outs.tar' -exec du -sh {} \;

# 638G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch1/AN00014456/AN00014456_10X_RawData_Outs.tar
# 723G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch1/AN00014457/AN00014457_10X_RawData_Outs.tar
# 676G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch2/AN00014812/AN00014812_10X_RawData_Outs.tar
# 687G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch2/AN00014813/AN00014813_10X_RawData_Outs.tar
# 665G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch3/AN00014985/AN00014985_10X_RawData_Outs.tar
# 688G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch3/AN00014986/AN00014986_10X_RawData_Outs.tar
# 711G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch4/AN00015125/AN00015125_10X_RawData_Outs.tar
# 714G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch4/AN00015126/AN00015126_10X_RawData_Outs.tar
# 690G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch5/AN00016884/AN00016884_10X_RawData_Outs.tar
# 714G    /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch5/AN00016885/AN00016885_10X_RawData_Outs.tar
# 789G    /data/CARD_singlecell/Brain_atlas/Hippo_Multiome/batch1/AN00020756/AN00020756_10X_RawData_Outs.tar
# 492G    /data/CARD_singlecell/Brain_atlas/Hippo_Multiome/batch1/AN00020757/AN00020757_10X_RawData_Outs.tar
# 813G    /data/CARD_singlecell/Brain_atlas/Hippo_Multiome/batch2/AN00020961/AN00020961_10X_RawData_Outs.tar
# 478G    /data/CARD_singlecell/Brain_atlas/Hippo_Multiome/batch2/AN00020962/AN00020962_10X_RawData_Outs.tar
# 838G    /data/CARD_singlecell/Brain_atlas/Hippo_Multiome/batch3/AN00021286/AN00021286_10X_RawData_Outs.tar
# 488G    /data/CARD_singlecell/Brain_atlas/Hippo_Multiome/batch3/AN00021287/AN00021287_10X_RawData_Outs.tar
# 665G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch1/AN00013174/AN00013174_10X_RawData_Outs.tar
# 571G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch1/AN00013175/AN00013175_10X_RawData_Outs.tar
# 671G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch2/AN00013413/AN00013413_10X_RawData_Outs.tar
# 676G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch2/AN00013415/AN00013415_10X_RawData_Outs.tar
# 645G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch3/AN00013701/AN00013701_10X_RawData_Outs.tar
# 620G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch3/AN00013702/AN00013702_10X_RawData_Outs.tar
# 685G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch4/AN00013820/AN00013820_10X_RawData_Outs.tar
# 639G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch4/AN00013821/AN00013821_10X_RawData_Outs.tar
# 664G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch5/AN00013895/AN00013895_10X_RawData_Outs.tar
# 698G    /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch5/AN00013896/AN00013896_10X_RawData_Outs.tar

```

```bash
while IFS=',' read ID cohort batch modality; do
    tarfile="/data/CARD_singlecell/Brain_atlas/${cohort}_multiome/${batch}/${ID}/${ID}_10X_RawData_Outs.tar"
    size=$(du -sh ${tarfile} | awk '{print $1}')
    targetdir="${cohort}/${modality}_fastq"
    echo tar -xvf ${tarfile} -C ${targetdir}
done < <(awk 'NR > 1' Seq_Batch_IDs.csv)
```

```bash

# See if it's only a single flow cell

move_files() {
    DIR=${1}
    FLOWCELLS=$(find ${DIR} -name '*.fastq.gz' | cut -d '/' -f 3 | sort -u)
    if [[ ${#FLOWCELL[@]} == 1 ]]; then
        echo "one flow cell $FLOWCELL"
        mkdir -p ${FLOWCELL}
        find ${DIR} -name '*.fastq.gz' -exec mv {} "${FLOWCELL}/" \;
        rm -rf ${DIR}
    else
        echo "multiple flow cells! BAD!"
    fi
}

DIR='AN00014457_10X_RawData_Outs'



# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch1/AN00013174/AN00013174_10X_RawData_Outs.tar -C NABEC/snRNA_fastq && cd NABEC/snRNA_fastq && move_files # DONE
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch1/AN00013175/AN00013175_10X_RawData_Outs.tar -C NABEC/snATAC_fastq && cd NABEC/snATAC_fastq && move_files 
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch2/AN00013415/AN00013415_10X_RawData_Outs.tar -C NABEC/snRNA_fastq && cd NABEC/snRNA_fastq && move_files # DONE
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch2/AN00013413/AN00013413_10X_RawData_Outs.tar -C NABEC/snATAC_fastq && cd NABEC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch3/AN00013702/AN00013702_10X_RawData_Outs.tar -C NABEC/snRNA_fastq && cd NABEC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch3/AN00013701/AN00013701_10X_RawData_Outs.tar -C NABEC/snATAC_fastq && cd NABEC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch4/AN00013821/AN00013821_10X_RawData_Outs.tar -C NABEC/snRNA_fastq && cd NABEC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch4/AN00013820/AN00013820_10X_RawData_Outs.tar -C NABEC/snATAC_fastq && cd NABEC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch5/AN00013896/AN00013896_10X_RawData_Outs.tar -C NABEC/snRNA_fastq && cd NABEC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/NABEC_multiome/batch5/AN00013895/AN00013895_10X_RawData_Outs.tar -C NABEC/snATAC_fastq && cd NABEC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch1/AN00014457/AN00014457_10X_RawData_Outs.tar -C HBCC/snRNA_fastq && cd HBCC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch1/AN00014456/AN00014456_10X_RawData_Outs.tar -C HBCC/snATAC_fastq && cd HBCC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch2/AN00014813/AN00014813_10X_RawData_Outs.tar -C HBCC/snRNA_fastq && cd HBCC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch2/AN00014812/AN00014812_10X_RawData_Outs.tar -C HBCC/snATAC_fastq && cd HBCC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch3/AN00014986/AN00014986_10X_RawData_Outs.tar -C HBCC/snRNA_fastq && cd HBCC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch3/AN00014985/AN00014985_10X_RawData_Outs.tar -C HBCC/snATAC_fastq && cd HBCC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch4/AN00015126/AN00015126_10X_RawData_Outs.tar -C HBCC/snRNA_fastq && cd HBCC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch4/AN00015125/AN00015125_10X_RawData_Outs.tar -C HBCC/snATAC_fastq && cd HBCC/snATAC_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch5/AN00016885/AN00016885_10X_RawData_Outs.tar -C HBCC/snRNA_fastq && cd HBCC/snRNA_fastq && move_files
# cd /home/wellerca/PFC_data_upload && tar -xvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch5/AN00016884/AN00016884_10X_RawData_Outs.tar -C HBCC/snATAC_fastq && cd HBCC/snATAC_fastq && move_files
```


```bash
find . -name '*.fastq.gz' | grep 'RawData' > fastqs.txt

<fastqs.txt cut -d '/' -f 2- | \
    tr '/' '\t' | sed 's/_scrn//g' | \
    sed 's/_scat//g' | \
    cut -f 1-2,4- | \
    sed 's/\t\([0-9]\)/\tHBCC-\1/g' | \
    sed -r 's/_S[0-9]+//g'| \
    paste fastqs.txt - | \
    grep -v 'SN' > renaming.txt

( while read oldname cohort mode iid flowcell fastq; do
    newdir="${cohort}/${mode}/${flowcell}"
    echo "mkdir -p ${newdir}"
    newname="${newdir}/${fastq}"
    echo "mv $oldname $newname"
done < renaming.txt ) > rename.sh

bash ./rename.sh


# Remove AN00###_Outs dirs
## Check if dirs are empty
find . -type d -name 'AN*_Outs' -exec find {} -name '*.fastq.gz' \;

## If so, delete
find . -type d -name 'AN*_Outs' -exec rm -rf {} \;
```


```bash
find . -name '*.fastq.gz' | cut -d '/' -f 5 | cut -d '_' -f 1 | sort -u > fastq-id-list.txt
```


## Rename HBCC samples from `8xxxx` to new four-digit `xxxx` identifiers
`rename2.R`


### Remove unused samplesq

Based on separation along principal component #1 for cohort HBCC, these 8 samples were excluded
by running [`remove-hbcc-outliers.sh`](scripts/remove-hbcc-outliers.sh) to generate `genotypes/HBCC_polarized_nooutliers.{bed,bim,fam}`.


| FID       | PC1    |
| --------- | ------ |
| HBCC_1058 | 0.2968 |
| HBCC_1331 | 0.3027 |
| HBCC_1385 | 0.3055 |
| HBCC_1431 | 0.2655 |
| HBCC_1560 | 0.3043 |
| HBCC_2429 | 0.3139 |
| HBCC_2756 | 0.3283 |
| HBCC_2781 | 0.2680 |

toremove <- c('1536-ARC','3081-ARC','1832-ARC','943-ARC','SH-06-05-ARC','SH-96-35-ARC','UMARY-1544-ARC','UMARY-1845-ARC','UMARY-1818-ARC','UMARY-4789-ARC','KEN-845-ARC','KEN-1156>


# Remove outlier ancestries
HBCC-1058
HBCC-1331
HBCC-1385
HBCC-1431
HBCC-1560
HBCC-2429
HBCC-2756
HBCC-2781

SWAP LABELS between HBCC_1536 and HBCC_3081
# Rename HBCC_1536 as HBCC_3081_TMP
```bash
find . -name 'HBCC-1536_*'

mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_R3_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_R2_001.fastq.gz
```
# Renmame HBCC_3081 HBCC_1536
```bash
find . -name 'HBCC-3081_*'

mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1536_L002_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1536_L002_R3_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L002_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L003_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1536_L004_R2_001.fastq.gz
```
# Rename HBCC_3081_TMP HBCC_3081
```bash
find . -name 'HBCC-3081-TMP_*'

mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081-TMP_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-3081_L002_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081-TMP_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-3081_L002_R3_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L002_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L002_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L003_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L003_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081-TMP_L004_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-3081_L004_R2_001.fastq.gz
```


# Temporarily hold HBCC_943
```bash
find . -name 'HBCC-943_*'
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943-DUP_L002_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943-DUP_L002_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HM2CTDMXY/HBCC-943-DUP_L002_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HNGFMDMXY/HBCC-943-DUP_L002_R3_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L003_I1_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L003_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L003_I2_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L003_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L003_R1_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L003_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L003_R2_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L003_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L004_I1_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L004_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L004_I2_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L004_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L004_R1_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L004_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943_L004_R2_001.fastq.gz ./HBCC/snRNA_fastq/HTNGNDSX7/HBCC-943-DUP_L004_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943_L003_I1_001.fastq.gz ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943-DUP_L003_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943_L003_I2_001.fastq.gz ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943-DUP_L003_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943_L003_R1_001.fastq.gz ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943-DUP_L003_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943_L003_R2_001.fastq.gz ./HBCC/snRNA_fastq/HW2LNDSX7/HBCC-943-DUP_L003_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L002_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L002_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L002_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L002_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L003_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L003_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L003_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L003_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L004_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L004_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L004_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943-DUP_L004_R2_001.fastq.gz
```
# Rename HBCC_1832 as HBCC_943
```bash
find . -name 'HBCC-1832_*'

mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-1832_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HK7F7DMXY/HBCC-943_L002_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L001_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L001_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L001_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L001_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L001_R3_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L002_I1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_I1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L002_R1_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_R1_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L002_R2_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_R2_001.fastq.gz
mv ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-1832_L002_R3_001.fastq.gz ./HBCC/snATAC_fastq/HKLKJDMXY/HBCC-943_L002_R3_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L002_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L002_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L002_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L002_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L002_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L003_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L003_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L003_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L003_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L003_R2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L004_I1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_I1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L004_I2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_I2_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L004_R1_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_R1_001.fastq.gz
mv ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-1832_L004_R2_001.fastq.gz ./HBCC/snRNA_fastq/HY23VDSX5/HBCC-943_L004_R2_001.fastq.gz
```

# Remove Original HBCC-943
```bash
find . -name 'HBCC-943-DUP*' -delete
```


| FID       | PC1    |
| --------- | ------ |
| HBCC_1058 | 0.2968 |
| HBCC_1331 | 0.3027 |
| HBCC_1385 | 0.3055 |
| HBCC_1431 | 0.2655 |
| HBCC_1560 | 0.3043 |
| HBCC_2429 | 0.3139 |
| HBCC_2756 | 0.3283 |
| HBCC_2781 | 0.2680 |

toremove <- c('1536-ARC','3081-ARC','1832-ARC','943-ARC','SH-06-05-ARC','SH-96-35-ARC','UMARY-1544-ARC','UMARY-1845-ARC','UMARY-1818-ARC','UMARY-4789-ARC','KEN-845-ARC','KEN-1156>

```bash
while read id; do
    nfiles=$(find . -name "${id}_*" | wc -l)
    echo $id $nfiles
done < <(awk -F',' 'NR>1{print $1}' PFC-Atlas-Sample-Metadata.csv)
```

# The case of the missing HBCC sample
`HBCC-1563` (original ID `81984`)

```bash
tar -tvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch1/.snapshot/weekly-snap._2025-03-02_07_00_00_UTC/AN00014456/AN00014456_10X_RawData_Outs.tar > ~/PFC_data_upload/hbcc-batch1-files.txt
tar -tvf /data/CARD_singlecell/Brain_atlas/HBCC_multiome/batch1/.snapshot/weekly-snap._2025-03-02_07_00_00_UTC/AN00014457/AN00014457_10X_RawData_Outs.tar  >> ~/PFC_data_upload/hbcc-batch1-files.txt

grep -F 'fastq.gz' hbcc-batch1-files.txt | awk '{print $6}' | cut -d '/' -f 4 | cut -d '_' -f 1 | sort -u
```

# Run cellranger
```bash
cd /data/CARD_AUX/users/wellerca/PFC-atlas-preprocessing && \
sbatch --array=1-358%20 run-cellranger-arc.sh
```

## Redos

```bash
sbatch --array=44,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,176,177,178,179,180,181,182,183,188,201,204,205,206,207,208,210,211,212,213,214,215,217,218,219,220,221,224,226,227,228,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,252,254,255,256,257,259,260,261,262%20 run-cellranger-arc.sh
```