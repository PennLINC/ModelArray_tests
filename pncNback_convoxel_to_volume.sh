# TO SETUP:

# conda activate test_confixel   # <- only do this when running on Chenying's local vmware!

# git clone <repo>
# cd ConFixel
# pip install -e .

# +++++++++++++++++++++++++++++
date_hdf5="20220317-162937"
# +++++++++++++++++++++++++++++

# for Kristin's fMRI n-back project, on local vmware:
filename_hdf5_woext="pncNback_nvoxels-0_wResults_${date_hdf5}"
cmd="volumestats_write --group-mask-file n1601_NbackCoverageMask_20170427.nii.gz"
cmd+=" --cohort-file pncNback_phenotypes.csv"
cmd+=" --relative-root /home/chenying/Desktop/fixel_project/data/data_voxel_kristin_nback"  # local vmware
cmd+=" --analysis_name lm_fullOutputs"
cmd+=" --input-hdf5 ${filename_hdf5_woext}.h5"  
cmd+=" --output-dir ${filename_hdf5_woext}"
cmd+=" --output-ext .nii.gz"


echo $cmd
$cmd