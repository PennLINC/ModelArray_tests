#!/bin/bash
# this is to (re-) run fsl flameo for Kristin's PNC fMRI n-back data. 
# Originally for her study, she used --runmode=flame1 and supplied varcode maps; However ModelArray only uses cope maps
# So now, this script is to re-run fsl flameo, with --runmode=ols and not to supply varcode maps
# this script is modified upon Kristin's script: /cbica/projects/Kristin_CBF/nback_adversity/revision/revision_flameo.sh
# input data are also from this "revision" folder, or folder above. The data has been copied to cubic fixel_db project and will be run there.

export FSLOUTPUTTYPE=NIFTI_GZ

folder_main="/cbica/projects/fixel_db/data/data_voxel_kristin_nback"
folder_input="${folder_main}/revision"
folder_output="${folder_main}/revision_flameo_ols"

cope_4Dimg="${folder_main}/4Dnback_revision_contrast.nii.gz"
mask="${folder_main}/n1601_NbackCoverageMask_20170427.nii.gz"
design="${folder_input}/design.mat"
contrast="${folder_input}/contrast.con"
group="${folder_input}/grp.grp"
logdir="${folder_output}"

cmd="flameo"
cmd+=" --cope=${cope_4Dimg}"
cmd+=" --mask=$mask"
cmd+=" --dm=${design}"
cmd+=" --tc=${contrast}"   # an ASCII matrix specifying the t contrasts
cmd+=" --cs=${group}"
cmd+=" --runmode=ols"
cmd+=" --ld=${logdir}"

echo $cmd
$cmd

date
