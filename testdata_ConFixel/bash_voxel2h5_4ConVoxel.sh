#!/bin/bash
# This is to convert toy voxel-wise data to h5 format for testing ConVoxel

# conda activate confixel

main_folder="/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/ConFixel/tests/data_voxel_toy"

cmd="convoxel"
cmd+=" --group-mask-file group_mask_FA.nii.gz"
cmd+=" --cohort-file cohort_FA.csv"
cmd+=" --relative-root ${main_folder}"
cmd+=" --output-hdf5 FA.h5"

echo $cmd
$cmd
