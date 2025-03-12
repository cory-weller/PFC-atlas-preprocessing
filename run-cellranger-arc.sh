#!/usr/bin/env bash
#SBATCH --time 24:00:00
#SBATCH --mem 80G
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 24
#SBATCH --gres=lscratch:500

module load cellranger-arc/2

N=${SLURM_ARRAY_TASK_ID}

SAMPLEFILE='/data/CARD_AUX/users/wellerca/PFC_data_upload/SAMPLES.txt'
IID=$(sed -n ${N}p ${SAMPLEFILE})
TMPDIR="/lscratch/${SLURM_JOB_ID}"
OUTDIR="${PWD}/CELLRANGER/${IID}/"
mkdir -p ${OUTDIR}
OUTDIR=$(realpath ${OUTDIR})

cd $TMPDIR || exit 0


REF='/fdb/cellranger-arc/refdata-cellranger-arc-GRCh38-2024-A'
SAMPLESHEET="/data/CARD_AUX/users/wellerca/PFC_data_upload/SAMPLESHEETS/${IID}.csv"

echo "IID ${IID}"
echo "TMPDIR ${TMPDIR}"

echo "SAMPLESHEET ${SAMPLESHEET}"

cellranger-arc count --id=${IID} \
                       --reference=${REF} \
                       --libraries=${SAMPLESHEET} \
                       --localcores=24 \
                       --localmem=64

# - Run summary HTML:                              ${IID}/outs/web_summary.html
# - Run summary metrics CSV:                       ${IID}/outs/summary.csv
# - Per barcode summary metrics:                   ${IID}/outs/per_barcode_metrics.csv
# - Filtered feature barcode matrix MEX:           ${IID}/outs/filtered_feature_bc_matrix
# - Filtered feature barcode matrix HDF5:          ${IID}/outs/filtered_feature_bc_matrix.h5
# - Raw feature barcode matrix MEX:                ${IID}/outs/raw_feature_bc_matrix
# - Raw feature barcode matrix HDF5:               ${IID}/outs/raw_feature_bc_matrix.h5
# - Loupe browser visualization file:              ${IID}/outs/cloupe.cloupe
# - GEX Position-sorted alignments BAM:            ${IID}/outs/gex_possorted_bam.bam
# - GEX Position-sorted alignments BAM index:      ${IID}/outs/gex_possorted_bam.bam.bai
# - GEX Per molecule information file:             ${IID}/outs/gex_molecule_info.h5
# - ATAC Position-sorted alignments BAM:           ${IID}/outs/atac_possorted_bam.bam
# - ATAC Position-sorted alignments BAM index:     ${IID}/outs/atac_possorted_bam.bam.bai
# - ATAC Per fragment information file:            ${IID}/outs/atac_fragments.tsv.gz
# - ATAC Per fragment information index:           ${IID}/outs/atac_fragments.tsv.gz.tbi
# - ATAC peak locations:                           ${IID}/outs/atac_peaks.bed
# - ATAC smoothed transposition site track:        ${IID}/outs/atac_cut_sites.bigwig
# - ATAC peak annotations based on proximal genes: ${IID}/outs/atac_peak_annotation.tsv
find . > files.txt
cp files.txt ${OUTDIR}

cp "${IID}/outs/summary.csv" ${OUTDIR}
cp "${IID}/outs/raw_feature_bc_matrix.h5" ${OUTDIR}
cp "${IID}/outs/atac_fragments.tsv.gz" ${OUTDIR}
cp "${IID}/outs/atac_fragments.tsv.gz.tbi" ${OUTDIR}

cd

echo "Done!"
