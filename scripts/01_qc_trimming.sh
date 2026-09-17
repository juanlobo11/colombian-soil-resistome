#!/bin/bash
# ---------------------------------------------------------------------------
# Script: 01_qc_trimming.sh
# Description: Quality control and adapter trimming for WGS paired-end reads.
# Tools: Trimmomatic
# ---------------------------------------------------------------------------

RAW_DATA="../data/raw"
CLEAN_DATA="../data/clean"

mkdir -p ${CLEAN_DATA}

echo "Starting Quality Control with Trimmomatic..."

for R1 in ${RAW_DATA}/*_1.fastq.gz; do
    R2="${R1/_1.fastq.gz/_2.fastq.gz}"
    SAMPLE=$(basename ${R1} _1.fastq.gz)
    
    echo "Processing sample: ${SAMPLE}"
    
    trimmomatic PE -threads 4 \
        ${R1} ${R2} \
        ${CLEAN_DATA}/${SAMPLE}_1_clean.fastq.gz ${CLEAN_DATA}/${SAMPLE}_1_unpaired.fastq.gz \
        ${CLEAN_DATA}/${SAMPLE}_2_clean.fastq.gz ${CLEAN_DATA}/${SAMPLE}_2_unpaired.fastq.gz \
        ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
        LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50
        
    echo "Finished processing ${SAMPLE}"
done

echo "QC Pipeline completed successfully."
