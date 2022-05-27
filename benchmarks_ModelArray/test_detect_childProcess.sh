#!/bin/bash
# this file is for testing purpose. 

parent_id="53657"
num_cores=4

child_id_list=()
child_id_list_wn=`pgrep -P ${parent_id}`
echo "child id list with \n:"
echo ${child_id_list_wn}
readarray -t child_id_list <<<"$child_id_list_wn"    # turn into an array and remove "\n"

echo "child_id_list_wn:"
echo $child_id_list_wn

echo "length of child_id_list_wn:"
echo ${#child_id_list_wn[@]}

echo "first element in child_id_list_wn:"
echo ${child_id_list_wn[0]}

echo "child_id_list:"
echo ${child_id_list[@]}

echo "length of child_id_list:"
echo "${#child_id_list[@]}"

echo "length of the first string element in child_id_list:"
child_id_list_element0=${child_id_list[0]}
len_child_id_list_element0=${#child_id_list_element0}
#echo "${#child_id_list_element0}"
echo ${len_child_id_list_element0}

if [[ ${len_child_id_list_element0} -gt 0 ]]; then
    echo "catched some child process(es)! So far they're ids are:"
    echo "${child_id_list[@]}"
fi

# if ((${#child_id_list_wn[@]})); then
#     echo "found some child process"
# fi

# if [[ ${child_id_list_wn[0]} == "\n" ]]; then
#     echo "is \n"
# fi

# # if ((${#child_id_list[@]})); then
# #     echo "found some child process"
# # fi


# if [  ${#child_id_list[@]} -eq ${num_cores} ]; then    # if length matches number of requested cores
            
#     echo "found all child(ren)'s id(s): ${child_id_list[@]}"

# fi
