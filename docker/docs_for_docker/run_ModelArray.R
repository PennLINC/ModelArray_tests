# This file is used to test ModelArray when running within a docker/singularity container

rm(list=ls())
library(ModelArray)

# =======================================
# Define input filenames
# =======================================
# the mounted data directory in singularity container:
dir_mounted_data <- "/mnt/myProject/data"
# filename of example fixel data (.h5 file):
h5_path <- file.path(dir_mounted_data, "demo_FDC_n100.h5")
# filename of example fixel data (.h5 file):
csv_path <- file.path(dir_mounted_data, "cohort_FDC_n100.csv")

# =======================================
# Get ready
# =======================================
# create a ModelArray-class object:
modelarray <- ModelArray(h5_path, scalar_types = c("FDC"))
# load the CSV file:
phenotypes <- read.csv(csv_path)

# =======================================
# Run statistical analysis
# =======================================
formula.lm <- FDC ~ Age + sex + dti64MeanRelRMS
# run linear model fitting with ModelArray.lm()
mylm <- ModelArray.lm(formula.lm, modelarray, phenotypes, "FDC",
                      element.subset = 1:100,  # TODO: COMMENT THIS OUT!!!
                      n_cores = 4)
dim(mylm) # TODO: TO COMMENT OUT!

# Notes: Make sure you also request >=4 CPU cores on the cluster
# Notes: Above is a full run of all fixels which will take some time; if you want to quickly test out first, add `element.subset = 1:100` in `ModelArray.lm()`

# =======================================
# Write the results
# =======================================
writeResults(h5_path, df.output = mylm, analysis_name = "results_lm")

# =======================================
# Check the results (optional)
# =======================================
# create a new ModelArray-class object:
modelarray_new <- ModelArray(filepath = h5_path, scalar_types = "FDC",
                             analysis_names = c("results_lm"))
modelarray_new
