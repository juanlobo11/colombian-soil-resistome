#!/bin/bash
# ---------------------------------------------------------------------------
# Script: 03_arg_screening.sh
# Description: Identification of ARGs in assemblies using ABRicate (CARD database).
# ---------------------------------------------------------------------------

ASSEMBLY_DIR="../data/assemblies"
RESULTS_DIR="../results/abricate"

mkdir -p ${RESULTS_DIR}

echo "Starting AMR gene screening with ABRicate..."

for FASTA in ${ASSEMBLY_DIR}/*/*.fa; do
    
    SAMPLE=$(basename $(dirname ${FASTA}))
    
    echo "Screening sample: ${SAMPLE}"
    
    # ABRicate screening against CARD database
    abricate --db card ${FASTA} > ${RESULTS_DIR}/${SAMPLE}_card.tsv
    
done

echo "AMR Screening completed successfully."
