# This script applies the Benjamini-Hochberg FDR correction to a matrix of p-values read from a CSV file.

args <- commandArgs(trailingOnly = TRUE)
input_file_path <- args[1]
output_file_path <- args[2]

# Read the p-value matrix (input file)
p_values <- read.csv(input_file_path, row.names = NULL)

# Detect the number of rows and columns
nrows <- nrow(p_values)
ncols <- ncol(p_values)

# Flatten the matrix to a vector for p.adjust
p_value_vector <- as.vector(t(p_values))

# Benjamini-Hochberg FDR correction
p_adjusted_values <- p.adjust(p_value_vector, method = "BH")

# Reshape the adjusted p-values back into matrix form using the detected dimensions
p_adjusted_matrix <- matrix(p_adjusted_values, nrow = nrows, ncol = ncols)

# Save the adjusted p-value matrix to a new CSV file without quotes
write.csv(p_adjusted_matrix, output_file_path, row.names = FALSE, quote = FALSE)

