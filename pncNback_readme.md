# Using ConVoxel + ModelArray to replicate Murtha, Kristin et al., 2022 results of PNC fMRI n-back adversity

## where is the data:

* CUBIC fixel_db project = /cbica/projects/fixel_db/data/data_voxel_kristin_nback
* Chenying's local computer vmware = /home/chenying/Desktop/fixel_project/data/data_voxel_kristin_nback

## input data:
* copied from Kristin's CUBIC project: /cbica/projects/Kristin_CBF/nback_adversity/
    * details see slack channel fixel_analysis

## Prepare phenotypes.csv:
* code: pncNback_prep4convoxel.R

## ConVoxel: .nii.gz --> .h5

* code: pncNback_convoxel_to_h5.sh
* run on CUBIC
* where: CUBIC fixel_db project

## ModelArray: linear model

* code:
    * pncNback_call_modelarrayR.sh
    * pncNback_run_modelarray.R
* ModelArray version: PennLINC/ModelArray@9e735b9
* run on Chenying's local computer vmware
* linear model: contrast ~ ageAtScan1 + sex + nbackRelMeanRMSMotion + parental_ed + envSES
* number of subjects = 1150
* number of voxels = 151,227
* number of CPU requested = 4
* took ~1h (other applications were running too)


## ConVoxel: .h5 stat results --> .nii.gz

* code: 
    * pncNback_convoxel_to_volume.sh   
    * note: at that time corresponding CLI command was not set up; so directly run voxels.py in ConFixel
* run on Chenying's local computer vmware
* output: pncNback_nvoxels-0_wResults_20220317-162937.h5

## Generate FSL outputs for comparison

* code: 
    * pncNback_fsl_flameo_wrapper.sh
    * pncNback_fsl_flameo.sh
* Chenying rerun FSL flameo with OLS (wihtout supplying varcode)
* run on CUBIC
* where is the data: CUBIC fixel_db project: /cbica/projects/fixel_db/data/data_voxel_kristin_nback
    * output data are in folder `revision_flameo_ols++`

## Compare to FSL:

* code: pncNback_compare.py
* run on Chenying's local computer vmware



