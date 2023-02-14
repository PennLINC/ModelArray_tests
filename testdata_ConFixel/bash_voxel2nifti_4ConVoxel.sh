#!/bin/bash
# This is to convert toy voxel-wise data back to NIfTI format for testing ConVoxel

# conda activate confixel

main_folder="/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/ConFixel/tests/data_voxel_toy"

cmd="volumestats_write"
cmd+=" --group-mask-file group_mask_FA.nii.gz"
cmd+=" --cohort-file cohort_FA.csv"
cmd+=" --relative-root ${main_folder}"
cmd+=" --analysis-name results_lm"
cmd+=" --input-hdf5 FA_wResults.h5"
cmd+=" --output-dir FA_stats"
cmd+=" --output-ext .nii.gz"

echo $cmd
$cmd