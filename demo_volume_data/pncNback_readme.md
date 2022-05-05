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
    * pncNback_run_modelarray.R    # make sure to change the input h5 filename (filename_orig_h5)!
* ModelArray version: PennLINC/ModelArray@9e735b9
* run on Chenying's local computer vmware
* linear model: contrast ~ ageAtScan1 + sex + nbackRelMeanRMSMotion + parental_ed + envSES
* number of subjects = 1150
* number of voxels = 151,227
* number of CPU requested = 4
* took ~1h (other applications were running too)
* output filename: pncNback_nvoxels-0_wResults_20220317-162937.h5


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

## Compare to ground truth FSL:

* code: pncNback_compare.py
* run on Chenying's local computer vmware
* result: compared matched stats for parentEdu: 
    * below is before updating ConVoxel:
        * tstat's max absolute difference = 5.36788172134095e-07
        * beta estimation (coefficient)'s max absolute difference = 3.4550028349400463e-07
    * below is after updating ConVoxel --> volume data data type to float32, though seems did not change much:
        * tstat max abs diff = 4.76837158203125e-07
        * beta estimation max abs diff = 4.76837158203125e-07

## Use singularity image to replicate the results
* singularity image: chenyingzhao/modelarray_confixel:test0.0.0
* how to set it up: pull it from DockerHub by: 
    * $ singularity pull docker://chenyingzhao/modelarray_confixel:test0.0.0
    * where to run this command: e.g. the root directory of cubic project folder
    * After this is done, there should be a .sif file named "modelarray_confixel_test0.0.0.sif" 

For the following steps:
* where: CUBIC fixel_db project
* output files are in folder: /cbica/projects/fixel_db/data/data_voxel_kristin_nback/
### ConVoxel: .nii.gz --> .h5
* code: pncNback_singularity_convoxel_to_h5.sh
* output h5 file: pncNback_bySingularity.h5
* where: cubic-sattertt interactive node
* Depending on the performance of interactive node, took about 3min or about 7min, including launch time of singularity image

### ModelArray linear regression
* code: 
    * qsub to cubic compute node: pncNback_qsub_call_modelarrayR.sh
    * bash file to call R script:   pncNback_call_modelarrayR.sh
    * R code: pncNback_run_modelarray.R   # make sure to change the input h5 filename (filename_orig_h5)!
* run where: cubic compute node
* note: 
    * The singularity command generated in `pncNback_call_modelarrayR.sh` can be on interactive node of cubic-sattertt (at least for first 10 elements; did not test full run of all elements).
    * Memory requirement may be able to reduced and smaller than the one in pncNback_qsub_call_modelarrayR.sh: h_vmem=30G (full run was successful with this amount of memory)
* output file: 
    * pncNback_nvoxels-0_wResults_20220325-183056.h5
* took 2h51min on cubic compute node, with 4 CPUs requested

### ConVoxel: .h5 stat results --> .nii.gz
* code: pncNback_singularity_convoxel_to_volume.sh
* run where: cubic-sattertt interactive node
* took several minutes (about 3min-5min)
* output file: pncNback_nvoxels-0_wResults_20220325-183056/*


### Comparison with ground truth FSL:
* code: pncNback_compare.py
* note: remember to change the variables folder_main and folder_modelarray
* compared matched stats for parentEdu: (below is before updating ConVoxel --> volume data data type to float32, though probably won't affect much)
    * tstat max abs diff = 5.367881747986303e-07
    * beta estimation max abs diff = 3.455002861585399e-07
* also visually compared for envSES (tstat and beta estimation) - consistent in several random sampled voxels at least to 4th decimal digits
* Therefore, using singularity image of ModelArray + ConFixel did replicate the results from FSL.
