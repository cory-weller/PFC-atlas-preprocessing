#!/usr/bin/env bash

exit 0
# do not run again! Only for reference purposes

cd /vf/users/CARD_AUX/users/wellerca/PFC_data_upload


rearrangeFlowCell() {
    DIR=${1}
    
    # Run in subshell
    (
    cd $DIR
    for oldname in *.fastq.gz; do
        sampleid=$(echo $oldname | cut -d '_' -f 1)
        newname=$(echo $oldname | sed 's/_L00/_S1_L00/g')
        mkdir -p $sampleid
        mv ${oldname} ${sampleid}/${newname}
    done
    )
}

rearrangeFlowCell HBCC/snATAC_fastq/HK7F7DMXY


cells=(
HBCC/snATAC_fastq/HKKMMDMXY
HBCC/snATAC_fastq/HKLKJDMXY
HBCC/snATAC_fastq/HLF5JDMXY
HBCC/snATAC_fastq/HLVGTDMXY
HBCC/snATAC_fastq/HLVJNDMXY
HBCC/snATAC_fastq/HLVM5DMXY
HBCC/snATAC_fastq/HLVTHDMXY
HBCC/snATAC_fastq/HM2CTDMXY
HBCC/snATAC_fastq/HNGFMDMXY
HBCC/snRNA_fastq/H7TJWDSX7
HBCC/snRNA_fastq/H7W73DSX7
HBCC/snRNA_fastq/H7WGLDSX7
HBCC/snRNA_fastq/HTNGNDSX7
HBCC/snRNA_fastq/HW2LNDSX7
HBCC/snRNA_fastq/HY23VDSX5
NABEC/snATAC_fastq/HJ2N2DMXY
NABEC/snATAC_fastq/HJ73CDMXY
NABEC/snATAC_fastq/HJNTLDMXY
NABEC/snATAC_fastq/HJNTMDMXY
NABEC/snATAC_fastq/HK235DMXY
NABEC/snATAC_fastq/HK3V5DMXY
NABEC/snATAC_fastq/HK3VCDMXY
NABEC/snATAC_fastq/HK725DMXY
NABEC/snATAC_fastq/HKCGCDMXY
NABEC/snATAC_fastq/HKGC2DMXY
NABEC/snRNA_fastq/HL7YMDSX5
NABEC/snRNA_fastq/HTWNHDSX5
NABEC/snRNA_fastq/HTWVGDSX5
NABEC/snRNA_fastq/HTY73DSX5
NABEC/snRNA_fastq/HY2YYDSX5
)

for cell in ${cells[@]}; do
    rearrangeFlowCell $cell
done