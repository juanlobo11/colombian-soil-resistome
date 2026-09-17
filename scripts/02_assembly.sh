#!/bin/bash
# ---------------------------------------------------------------------------
# Script: 02_assembly.sh
# Description: Metagenomic assembly of clean reads using MEGAHIT.
# ---------------------------------------------------------------------------

CLEAN_DATA="../data/clean"
ASSEMBLY_OUT="../data/assemblies"

echo "Starting Metagenomic Assembly with MEGAHIT..."

for R1_CLEAN in ${CLEAN_DATA}/*_1_clean.fastq.gz; do
    
    # Generar el nombre del archivo reverse y extraer el nombre de la muestra
    R2_CLEAN="${R1_CLEAN/_1_clean.fastq.gz/_2_clean.fastq.gz}"
    SAMPLE=$(basename ${R1_CLEAN} _1_clean.fastq.gz)
    
    echo "Assembling sample: ${SAMPLE}"
    
    # Comando de MEGAHIT corregido
    megahit -1 ${R1_CLEAN} -2 ${R2_CLEAN} -o ${ASSEMBLY_OUT}/${SAMPLE} --out-prefix ${SAMPLE}
    
    echo "Finished assembling ${SAMPLE}"
done

echo "Assembly Pipeline completed successfully."
