This folder includes scripts used for preparing test data for ConFixel software.

## For ConVoxel
* Preparation of the toy voxel-wise data:
    * Prepare voxel-wise data: [prep_voxeldata_4ConVoxel.py](prep_voxeldata_4ConVoxel.py)
        * Data has been saved to [ConFixel](https://github.com/PennLINC/ConFixel) GitHub repo.
        * Data description can be found there.
    * Prepare CSV file for it: [prep_csv_4ConVoxel.R](prep_csv_4ConVoxel.R)
* Apply ConVoxel --> h5:
    * [bash_voxel2h5_4ConVoxel.sh](bash_voxel2h5_4ConVoxel.sh)
* Apply ModelArray and run linear regression:
    * [ModelArray_voxel_4ConVoxel.Rmd](ModelArray_voxel_4ConVoxel.Rmd)
* Apply ConVoxel --> .nii.gz:
    * [bash_voxel2nifti_4ConVoxel.sh](bash_voxel2nifti_4ConVoxel.sh)

Confirmed:
* `_model.nobs.nii.gz`: voxels with nobs=20 (=number of subjects) = core mask (`core_mask_FA.nii.gz`), which defines the voxels which have values from all the subjects.
