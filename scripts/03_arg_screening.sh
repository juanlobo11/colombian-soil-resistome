#!/bin/bash
# ---------------------------------------------------------------------------
# Script: 03_arg_screening.sh
# Description: Metagenome binning (MetaBAT2) and ARG screening (ABRicate)
#              against CARD, ResFinder, and NCBI databases.
# ---------------------------------------------------------------------------

ASSEMBLY_DIR="../data/assemblies"
BINS_DIR="../data/bins"
RESULTS_DIR="../results/abricate"

mkdir -p ${BINS_DIR} ${RESULTS_DIR}

echo "Starting Metagenome Binning (MetaBAT2) and AMR Screening (ABRicate)..."

for CONTIGS in ${ASSEMBLY_DIR}/*/*.contigs.fa; do
    
    SAMPLE=$(basename $(dirname ${CONTIGS}))
    
    echo "1. Binning contigs for sample: ${SAMPLE}"
    # Agrupamiento en MAGs con los parámetros del TFM (minContig 1500, minBinSize 200000)
    metabat2 -i ${CONTIGS} -o ${BINS_DIR}/${SAMPLE}/${SAMPLE}_bin -m 1500 -s 200000
    
    echo "2. Screening MAGs with ABRicate (CARD, ResFinder, NCBI)..."
    # Búsqueda de genes de resistencia en las 3 bases de datos curadas
    for DB in card resfinder ncbi; do
        abricate --db ${DB} --minid 80 --mincov 80 ${BINS_DIR}/${SAMPLE}/*.fa > ${RESULTS_DIR}/${SAMPLE}_${DB}.tsv
    done
    
done

echo "Binning and AMR Screening completed successfully."
