library(ModelArray)
library(testthat)

folder_main = "/home/chenying/Desktop/fixel_project/data/data_voxel_grmpy"
filename_lm_h5 = "GRMPY_meanCBF_n209_indmask_nvoxels-0_wResults_20220504-180709.h5"
filename_gam_h5 ="GRMPY_meanCBF_n209_indmask_nvoxels-0_wResults_20220505-224603.h5"
#short_result ="model.nobs.nii.gz"
# filename_lm_results <- paste0("lm_fullOutputs_", short_result)
# filename_gam_results <- paste0("gam_fullOutputs_", short_result)

fn_lm_results <- file.path(folder_main, filename_lm_h5)
fn_gam_results <- file.path(folder_main, filename_gam_h5)
modelarray.lm <- ModelArray(fn_lm_results, scalar_types = "CBF", analysis_names = c("lm_fullOutputs"))
modelarray.gam <- ModelArray(fn_gam_results, scalar_types = "CBF", analysis_names = c("gam_fullOutputs"))

lm.nobs <- results(modelarray.lm)$lm_fullOutputs$results_matrix[,29]  # last column
gam.nobs <- results(modelarray.gam)$gam_fullOutputs$results_matrix[,27]  # last column
expect_equal(lm.nobs, gam.nobs)
