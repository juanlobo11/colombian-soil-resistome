# Metagenomic Characterization of Antimicrobial Resistance Genes in Colombian Soil Samples 🇨🇴🧬

## 🎯 Project Overview
Antimicrobial Resistance (AMR) is a critical global health threat. The environmental resistome, particularly in soils, acts as a vast reservoir for resistance determinants that can transition into human pathogens. This project investigates the presence, diversity, and clinical relevance of Antimicrobial Resistance Genes (ARGs) across diverse Colombian ecosystems—ranging from moist tropical forests to anthropogenically modified agricultural lands. The goal is to bridge environmental genomics with clinical infectious disease surveillance.

## 📊 Data Source
This analysis utilized 68 Whole Genome Sequencing (WGS) paired-end reads (Illumina) from the NCBI Sequence Read Archive (SRA), representing 34 non-redundant BioSamples across three major BioProjects:
*   **PRJNA1222139:** Palmira, Valle del Cauca (Agricultural soil).
*   **PRJEB18701:** Southern Colombia (Tropical and montane forests).
*   **PRJEB35365:** Casanare, Tauramena (Anthropogenically impacted soil).

*Note: Raw FASTQ files are not hosted in this repository due to size constraints. Instructions to fetch the data via SRA Toolkit are provided in the workflow.*

## 🛠️ Bioinformatics Stack
*   **Data Retrieval:** SRA Toolkit
*   **Quality Control & Trimming:** Trimmomatic 
*   **Metagenomic Assembly:** MEGAHIT
*   **AMR Profiling:** ABRicate (CARD, ResFinder, NCBI AMR databases)
*   **Data Wrangling & Analysis:** R (dplyr, readr)

## 🚀 Workflow
The computational pipeline was designed to process raw reads into actionable clinical insights:
1.  **Read Extraction:** Downloaded `.fastq.gz` files from NCBI SRA.
2.  **Quality Control:** Removed TruSeq3 adapters and low-quality bases using Trimmomatic (SLIDINGWINDOW:4:20, MINLEN:50).
3.  **Assembly:** De novo assembly of complex metagenomes using MEGAHIT.
4.  **ARG Detection:** Screened contigs against multiple curated databases to identify ARGs.
5.  **Data Curation:** Processed output tables in R to remove technical redundancies and group resistance profiles by BioSample.

## 📈 Key Findings
From the 34 non-redundant samples, 5 unique clinically relevant AMR genes were identified:
*   ***vanRO* (Glycopeptide/Vancomycin resistance):** The most prevalent gene, detected in 9 samples (predominantly in agricultural soils from Palmira).
*   **Higher Diversity in Modified Soils:** Anthropogenically impacted soils (Casanare) exhibited a highly heterogeneous resistance profile (including *mtrA* and *RbpA*), suggesting that human activity and land-use pressure directly influence the diversity of the environmental resistome compared to pristine ecosystems.
