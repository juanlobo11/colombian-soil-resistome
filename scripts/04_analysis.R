# ---------------------------------------------------------------------------
# Script: 04_analysis.R
# Description: Process, filter, and summarize ABRicate AMR screening results.
# Tools: R (tidyverse: dplyr, readr, purrr, stringr)
# ---------------------------------------------------------------------------

library(dplyr)
library(readr)
library(purrr)
library(stringr)

# 1. Definir rutas de lectura y salida
results_dir <- "../results/abricate"
output_dir <- "../results/summary"

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# 2. Listar todos los reportes TSV generados por ABRicate
tsv_files <- list.files(path = results_dir, pattern = "\\.tsv$", full.names = TRUE)

# 3. Función para cargar y etiquetar cada muestra
load_abricate_file <- function(filepath) {
  sample_id <- str_remove(basename(filepath), "_card\\.tsv")
  read_tsv(filepath, show_col_types = FALSE) %>%
    mutate(BioSample = sample_id)
}

# 4. Consolidar, filtrar por calidad y remover redundancias
if (length(tsv_files) > 0) {
  combined_results <- map_dfr(tsv_files, load_abricate_file)
  
  filtered_args <- combined_results %>%
    filter(`%COVERAGE` >= 80, `%IDENTITY` >= 90) %>%
    select(BioSample, GENE, `%COVERAGE`, `%IDENTITY`, DATABASE, ACCESSION) %>%
    distinct()
  
  # 5. Exportar la tabla consolidada limpia
  write_csv(filtered_args, file.path(output_dir, "clean_amr_summary.csv"))
  message("Análisis completado. Resumen guardado en ../results/summary/clean_amr_summary.csv")
} else {
  message("No se encontraron archivos TSV en la ruta especificada.")
}
