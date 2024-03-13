#!/usr/bin/env Rscript

# Obs vs Exp statistical matrix comparison script
# Calculates p-values for each cell in an observed matrix against distributions from expected matrices.
# Usage: Rscript script_name.R -o <observed_matrix_path> -e <expected_matrices_directory> -p <output_file_path>

args <- commandArgs(trailingOnly = TRUE)

# Parse command line arguments
options <- list()
for (i in seq(1, length(args), 2)) {
  options[[substr(args[i], 2, nchar(args[i]))]] <- args[i + 1]
}

# Paths
observed_matrix_path <- options$o
expected_matrices_dir <- options$e
output_file_path <- options$p  

# Load observed matrix (tab-separated .txt files)
observed_matrix <- read.delim(observed_matrix_path, sep = "\t")

# Matrices should be tab-separated values in the directory
expected_files <- list.files(expected_matrices_dir, full.names = TRUE)
n <- dim(observed_matrix)[1]

# Initialize matrix to store p-values
p_value_matrix <- matrix(0, n, n)

# Load and process each expected matrix (tab-separated .txt files)
expected_matrices <- lapply(expected_files, function(file) read.delim(file, sep = "\t"))

# Function to calculate p-value for each cell
calculate_p_value <- function(observed, distributions) {
  # Assuming normal distribution for simplification
  test_result <- t.test(x = distributions, mu = observed)
  return(test_result$p.value)
}

# Calculate p-values for each cell
for (i in 1:n) {
  for (j in 1:n) {
    distributions <- sapply(expected_matrices, function(matrix) matrix[i,j])
    observed_value <- observed_matrix[i,j]
    p_value_matrix[i, j] <- calculate_p_value(observed_value, distributions)
  }
}

# Save the p_value_matrix to the specified file
write.csv(p_value_matrix, output_file_path, row.names = FALSE)

