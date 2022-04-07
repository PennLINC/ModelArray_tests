#!/bin/bash

# this is to confirm that there is no other processes going on during ModelArray stat analysis (ModelArray.lm())
# How to use:
    # run this bash script first, it will detect if there is any [R] --no-save
        # if there is, it will use wss to profile its memory usage which is saved to ${folder_main}
    # Then start the ModelArray profiling command (see ModelArray_paper/benchmark/run_wrapper_benchmark_ModelArray.sh)
    # after R finishes, check the last detected [R] --no-save ends before ModelArray.lm() begins
        # time it takes before last [R] --no-save ends: end time in wss profiling - this profiling job start time (see folder name)
        # time it takes before ModelArray.lm() begins: see Routput.txt
        # and the latter time should be > formar time
    # now you can manually stop this bash script
# this script can detect three [R] --no-save sequentially


source config.txt   # for flag_where
sample_sec=1
folder_main="/home/chenying/Desktop/fixel_project/FixelArray_benchmark/_process_R_nosave"


if [[ "${flag_where}" == "vmware"   ]]; then
    cmd_wss="/home/chenying/Desktop/Apps/wss-master/wss.pl"
elif [[ "${flag_where}" == "cubic"  ]]; then
    cmd_wss="/cbica/projects/fixel_db/Apps/wss/wss.pl"
fi


function detect_r_nosave {
    while :
    do
        pid_r=`ps -aux | grep "[R] --no-save" | awk '{print $2}'`     # [R] is to remove result of grep search; "awk" is to return pid only
        # pid_r=`ps -aux | grep "[R] --no-save"`   # print the full process information     
        if [[ ! (-z "$pid_r") ]]; then    # after there is no R running
            echo $pid_r
            date

            printf -v date '%(%Y%m%d-%H%M%S)T' -1   # $date, in YYYYmmdd-HHMMSS
            #echo "date variable: ${date}"

            break
        fi

    done

    # start wss:
    echo ${folder_main}/${date}_${pid_r}
    ${cmd_wss} -C ${pid_r} ${sample_sec} > ${folder_main}/${date}_${pid_r} 2>&1 &

}

detect_r_nosave
sleep 6
date
detect_r_nosave
sleep 6
date
detect_r_nosave
sleep 5
date
detect_r_nosave