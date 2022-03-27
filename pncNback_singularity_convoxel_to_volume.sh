#!/bin/bash
# This is to use singularity image of ModelArray + ConFixel to convert
# singularity image was pulled from: chenyingzhao/modelarray_confixel:test0.0.0
# Ref: pncNback_convoxel_to_volume.sh

# +++++++++++++++++++++++++++++
date_hdf5="20220325-183056"
# +++++++++++++++++++++++++++++

# for Kristin's fMRI n-back project, on cubic:
filename_hdf5_woext="pncNback_nvoxels-0_wResults_${date_hdf5}"
fn_singularity="/cbica/projects/fixel_db/modelarray_confixel_test0.0.0.sif"

cmd="singularity run --cleanenv ${fn_singularity}"
cmd+=" volumestats_write --group-mask-file n1601_NbackCoverageMask_20170427.nii.gz"
cmd+=" --cohort-file pncNback_phenotypes.csv"
cmd+=" --relative-root /cbica/projects/fixel_db/data/data_voxel_kristin_nback"  # cubic
cmd+=" --analysis_name lm_fullOutputs"
cmd+=" --input-hdf5 ${filename_hdf5_woext}.h5"  
cmd+=" --output-dir ${filename_hdf5_woext}"
cmd+=" --output-ext .nii.gz"


echo $cmd
$cmd