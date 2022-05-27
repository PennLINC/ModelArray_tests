#!/bin/bash

# this is to test whether a process is still running

pid=$1
#temp=`ps -p ${pid}`

# below: tested, good
if ps -p $pid > /dev/null
then
   echo "$pid is running"
   # Do something knowing the pid exists, i.e. the process with $PID is running
else
    echo "$pid is NOT running"
fi

# below: tested, good
# if ! ps -p $pid > /dev/null
# then
#    echo "$pid is NOT running"
# else
#     echo "$pid is running"
# fi


# while ps -p $pid > /dev/null
# do
#    echo "$pid is running"
# done

#if [[ $temp > /dev/null ]]; then  # does not work?...
# temp=`kill -0 $pid`
# echo $temp
# if [[ `kill -0 $pid` ]]; then
#     echo "this process exists"
# else
#     echo "this process does not exist"
# fi

# temp=`ps -p ${pid} | awk '{print $2}'`     # [R] is to remove result of grep search; "awk" is to return pid only`
# echo $temp[1]
# if [ -z "$temp" ]; then    
#     echo "this process does not exist"
# else 
#     echo "this process exists"
# fi

# parent_id=$1
# max_num_child=$2
# short_name=$3

# child_id_list_wn=`pgrep -P ${parent_id}`
# readarray -t child_id_list <<<"$child_id_list_wn"    # turn into an array and remove "\n"

# # echo "child_id_list:"
# # echo ${child_id_list[@]}

# # echo "length of child_id_list:"
# # echo "${#child_id_list[@]}"

# echo "length of the first string element in child_id_list:"
# child_id_list_element0=${child_id_list[0]}
# len_child_id_list_element0=${#child_id_list_element0}
# #echo ${len_child_id_list_element0}

# if [[ ${len_child_id_list_element0} -gt 0 ]]; then
#     echo "catched some child process(es)! So far they're ids are:"
#     echo "${child_id_list[@]}"
# fi