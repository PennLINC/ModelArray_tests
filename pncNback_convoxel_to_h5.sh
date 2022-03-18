#!/bin/bash
# TO PREPARE:
# phenotypes.csv: besides the scalar_name and source_file columns, you also need to provide source_mask_file column!!

# TO SETUP:
# git clone <repo>
# cd ConFixel
# pip install -e .

# for Kristin's fMRI n-back project, on cubic:
cmd="convoxel --group-mask-file n1601_NbackCoverageMask_20170427.nii.gz"
cmd+=" --cohort-file pncNback_phenotypes.csv"
cmd+=" --relative-root /cbica/projects/fixel_db/data/data_voxel_kristin_nback"
cmd+=" --output-hdf5 pncNback.h5"


echo $cmd
$cmd