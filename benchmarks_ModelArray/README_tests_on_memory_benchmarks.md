This is the README file on tests on memory benchmarking.

# MRtrix
## Confirm there is only one process and there is no child process
* How to detect: see [test_detect_childProcess.sh](test_detect_childProcess.sh)
    * Main points:
    * $ child_id_list_wn=`pgrep -P ${parent_id}`
    * $ readarray -t child_id_list <<<"$child_id_list_wn"    # remove "\n"
    * #The first string's length:
    * $ child_id_list_element0=${child_id_list[0]}
    * Now:

| what's for                | command               | child_id_list=() | child_id_list from fixelcfestats | child_id_list from ModelArray.lm()
| ------ | ----------- | ----------- | ----------- |
| length of child_id_list  | ${#child_id_list[@]}    | 0       | 1 (i.e., there is something hidden but not real) | ??? |
| length of the first string in child_id_list | ${#child_id_list_element0}   | 0        | 0 | ??? |



    * Now, even if child_id_list is actually empty (i.e. there is no real child process), the length of it (`${#child_id_list[@]}`) is 1

* using myMemoryProfiler_fortests.sh
* cd to benchmarks folder; then call: (run_wrapper)_benchmark_fixelcfestats.sh

If "-c 1", i.e. trying to detect one child process, even though there is no child process (i.e. $child_id_list is empty), the "${#child_id_list[@]}" in myMemoryProfiler_fortests.sh (i.e. the length of this list) will still 1. So it actually did not detect child process.

Based on multi-threads def: https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
A thread is the unit of execution within a process. A process can have anywhere from just one thread to many threads.
^^^ therefore, multi-threads use one process. So it's fine that directly specify "-c 1". Also the results across multiple threads are as expected (increase with # of threads)