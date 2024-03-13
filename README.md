# pvalue_obs_vs_exp

These scripts facilitate the comparison of an observed matrix against a set of expected matrices by calculating p-values for each cell and adjusting these p-values using 
the False Discovery Rate (FDR) correction method.

## Scripts and Their Usage

### calculate_pvalues.R

- **Purpose**: Calculates p-values for each cell in an observed matrix compared against distributions from a set of expected matrices.
- **Usage**:
  ```
  Rscript calculate_pvalues.R -o <observed_matrix_path> -e <expected_matrices_directory> -p <output_pvalues_path>
  ```
  - `-o <observed_matrix_path>`: Path to the observed matrix file.
  - `-e <expected_matrices_directory>`: Path to the directory containing expected matrices.
  - `-p <output_pvalues_path>`: Path for the output file to save the p-values matrix.

### fdr_correction.R

- **Purpose**: Applies the FDR correction using the Benjamini-Hochberg method to a matrix of p-values, adjusting for multiple comparisons.
- **Usage**:
  ```
  Rscript fdr_correction.R <input_pvalues_path> <output_adjusted_pvalues_path>
  ```
  - `<input_pvalues_path>`: Path to the input CSV file containing the matrix of p-values.
  - `<output_adjusted_pvalues_path>`: Path where the adjusted p-values matrix will be saved.
