#!/bin/bash
# This is to use singularity image of ModelArray+ConFixel to run ConVoxel: .nii.gz --> .h5
# singularity image was pulled from: chenyingzhao/modelarray_confixel:test0.0.0
# Ref: pncNback_convoxel_to_h5.sh

fn_singularity="/cbica/projects/fixel_db/modelarray_confixel_test0.0.0.sif"

cmd="singularity run --cleanenv ${fn_singularity}"
cmd+=" convoxel"
cmd+=" --group-mask-file n1601_NbackCoverageMask_20170427.nii.gz"
cmd+=" --cohort-file pncNback_phenotypes.csv"
cmd+=" --relative-root /cbica/projects/fixel_db/data/data_voxel_kristin_nback"
# cmd+=" --output-hdf5 test_singularity/pncNback.h5"
cmd+=" --output-hdf5 pncNback_bySingularity.h5"

echo $cmd
$cmd