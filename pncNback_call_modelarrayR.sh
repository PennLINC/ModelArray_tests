#!/bin/bash
# this is to call .R (or .Rmd) file of running ModelArray

# +++++++++++++++++++++++++ VARIABLES TO CHANGE: ++++++++++++++++++++++++++++++++++++++++++++
folder_main="/home/chenying/Desktop/fixel_project/data/data_voxel_kristin_nback"  # local vmware
filename_Rscript="pncNback_run_modelarray.R"

num_voxels=0   # 0 if requesting all voxels
num_cores=4    # number of CPU cores; the more the faster

flag_use_singularity="FALSE"
#fn_rstudio_singularity="/cbica/projects/GRMPY/software/rstudio_4.1.sif"
#fn_rstudio_singularity="/cbica/projects/GRMPY/software/myr_r4.1.0forFixelArray.sif"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

printf -v date '%(%Y%m%d-%H%M%S)T' -1   # $date, in YYYYmmdd-HHMMSS
echo "date variable: ${date}"

filename_output_body="pncNback_nvoxels-${num_voxels}_wResults_${date}"
fn_R_output="${folder_main}/${filename_output_body}.txt"


if [[  $flag_use_singularity == "FALSE"  ]]; then
    cmd="Rscript ./${filename_Rscript} ${num_voxels} ${num_cores} ${folder_main} ${filename_output_body} > ${fn_R_output} 2>&1 &"
    echo $cmd
    # copy the $cmd here manually (otherwise there might be issues with output $fn_R_output):
    Rscript ./${filename_Rscript} ${num_voxels} ${num_cores} ${folder_main} ${filename_output_body} > ${fn_R_output} 2>&1 &

elif [[  $flag_use_singularity == "TRUE"  ]]; then
    cmd="singularity run --cleanenv ${fn_rstudio_singularity} Rscript ./${filename_Rscript} ${num_voxels} ${num_cores} ${folder_main} ${filename_output_body} > ${fn_R_output} 2>&1 &"
    echo $cmd
    # copy the $cmd here manually (otherwise there might be issues with output $fn_R_output):
    singularity run --cleanenv ${fn_rstudio_singularity} Rscript ./${filename_Rscript} ${num_voxels} ${num_cores} ${folder_main} ${filename_output_body} > ${fn_R_output} 2>&1 &
fi

#date
