#!/bin/bash

# this is copied from ModelArray_paper/benchmarks/wrapper_benchmark_ModelArray.lm.sh
# this version is for testing purpose. It will call `benchmark_ModelArray.lm_testing.sh`

# example command:
# bash wrapper_benchmark_ModelArray.lm_testing.sh -s 1 -D josiane -f 0 -S 100 -c 4 -w vmware -M TRUE

source ../../ModelArray_paper/config_global.txt  # flag_where and ModelArray_commitSHA, etc
unset flag_where 

# activate the appropriate conda env:
source ${conda_sh_file}    # !!! have to source it before running "conda activate <name>"
conda activate ${conda_env}
current_conda_env=`echo $CONDA_DEFAULT_ENV`   # get the current conda enviroment's name
echo "current conda environment: ${current_conda_env}"


while getopts s:D:f:S:c:w:O:M: flag
do
        case "${flag}" in
                s) sample_sec=${OPTARG};;
                # d) d_memrec=${OPTARG};;
                D) dataset_name=${OPTARG};;
                f) num_fixels=${OPTARG};;   # 0 as full
                S) num_subj=${OPTARG};;
                c) num_cores=${OPTARG};;
                w) run_where=${OPTARG};;    # "sge" or "interactive" or "vmware"
                O) overwrite=${OPTARG};;   # "TRUE"
                M) run_memoryProfiler=${OPTARG};;   # "TRUE" or "FALSE"
        esac
done

echo "JOB_ID = ${JOB_ID}"

printf -v date '%(%Y%m%d-%H%M%S)T' -1   # $date, in YYYYmmdd-HHMMSS
echo "date variable: ${date}"

ModelArray_commitSHA_short=${ModelArray_commitSHA:0:7}  # first 7 characters in SHA

ModelArrayPaper_commitSHA=`git rev-parse HEAD`
ModelArrayPaper_commitSHA_short=${ModelArrayPaper_commitSHA:0:7}  # first 7 characters in SHA

foldername_jobid="MAsha-${ModelArray_commitSHA_short}.MAPsha-${ModelArrayPaper_commitSHA_short}."
foldername_jobid+="lm.${dataset_name}.nfixel-${num_fixels}.nsubj-${num_subj}.ncore-${num_cores}.${run_where}"

if [[ "$run_memoryProfiler" == "TRUE"  ]]; then
        foldername_jobid="${foldername_jobid}.runMemProfiler"  
else 
        foldername_jobid="${foldername_jobid}.noMemProfiler"
fi

# add ${sample_sec} to the foldername:
foldername_jobid="${foldername_jobid}.s-${sample_sec}sec"

if [  "$run_where" = "sge" ]; then
        folder_benchmark="/cbica/projects/fixel_db/FixelArray_benchmark"
        
        echo "adding JOB_ID to foldername"
        foldername_jobid="${foldername_jobid}.${JOB_ID}"

elif [[ "$run_where" == "interactive"   ]]; then
        folder_benchmark="/cbica/projects/fixel_db/FixelArray_benchmark"

elif [[ "$run_where" == "vmware"   ]]; then
        folder_benchmark="/home/chenying/Desktop/fixel_project/ModelArray_benchmark"

        echo "adding date to foldername"
        foldername_jobid="${foldername_jobid}.${date}"
fi

folder_jobid="${folder_benchmark}/${foldername_jobid}"
# echo "folder_jobid: ${folder_jobid}"


if [ -d ${folder_jobid} ] && [ "${overwrite}" = "TRUE" ]
then
        echo "removing existing folder:   ${folder_jobid}"
        rm -r ${folder_jobid}
fi
mkdir ${folder_jobid}
echo "output folder:   ${folder_jobid}"
# echo "output foldername for this job: foldername_jobid"

fn_output_txt="${folder_jobid}/output.txt"
# echo "fn_output_txt: ${fn_output_txt}"

# call:
# for wss:
bash benchmark_ModelArray.lm_testing.sh -s $sample_sec -D $dataset_name -f $num_fixels -S $num_subj -c $num_cores -w $run_where -o ${folder_jobid} -M ${run_memoryProfiler} -A ${ModelArray_commitSHA} -a ${ModelArrayPaper_commitSHA} > $fn_output_txt 2>&1