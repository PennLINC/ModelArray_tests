#!/bin/bash

parent_id="121194"
num_cores=1

child_id_list=()
child_id_list_wn=`pgrep -P ${parent_id}`
echo "child id list with \n: ${child_id_list_wn}"
#readarray -t child_id_list <<<"$child_id_list_wn"    # remove "\n"

echo $child_id_list_wn
echo ${#child_id_list_wn[@]}
echo ${child_id_list_wn[0]}

# if ((${#child_id_list_wn[@]})); then
#     echo "found some child process"
# fi

if [[ ${child_id_list_wn[0]} == "\n" ]]; then
    echo "is \n"
fi

# if ((${#child_id_list[@]})); then
#     echo "found some child process"
# fi


if [  ${#child_id_list[@]} -eq ${num_cores} ]; then    # if length matches number of requested cores
            
    echo "found all child(ren)'s id(s): ${child_id_list[@]}"

fi