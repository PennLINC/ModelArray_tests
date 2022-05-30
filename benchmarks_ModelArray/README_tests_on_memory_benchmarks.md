This is the README file on tests on memory benchmarking.

# MRtrix fixelcfestats
## Confirm there is only one process and there is no child process
* which scripts:
    * `bash wrapper_benchmark_fixelcfestats_ifAnyChildProcess.sh -S 30 -h 100 -t 4 -f TRUE -F FALSE -n FALSE -w vmware -M TRUE -s 1`
    * uses [wrapper_benchmark_fixelcfestats_ifAnyChildProcess.sh](wrapper_benchmark_fixelcfestats_ifAnyChildProcess.sh)
    * which calls [benchmark_fixelcfestats_ifAnyChildProcess.sh](benchmark_fixelcfestats_ifAnyChildProcess.sh)
    * which calls [myMemoryProfiler_fortests.sh](myMemoryProfiler_fortests.sh)
        * When parent process is still running, detect if there is any child process by checking the first element's length in returned child process array - see table below
* version: ModelArray_tests commit SHA = f0ea072
* results: 
    * In folder: 
        * MAPsha-2c69570.nsubj-30.nthreads-4.ftests.nshuffles-100.vmware.runMemProfiler.s-1sec.20220527-180730
        * Main folder: /home/chenying/Desktop/fixel_project/data/data_from_josiane/for_fixelcfestats/stats_FDC
    * output message: parent process is no longer running. Stop detecting child processes.
    * therefore, by parent process finished, no child process detected
* conclusion: no child processes detected when running `fixelcfestats`


## How the child process(es) is detected:
* script:
    * [myMemoryProfiler_fortests.sh](myMemoryProfiler_fortests.sh); 
    * testing out see [test_detect_childProcess.sh](test_detect_childProcess.sh)
* Main points:
    * getting `child_id_list_wn` by: `pgrep -P ${parent_id}`
    * `$ readarray -t child_id_list <<<"$child_id_list_wn"`    # remove "\n"
    * #The first string's length and use this is determine whether there is really a child process:
    * `$ child_id_list_element0=${child_id_list[0]}`
    * Now:

| what's for                | command               | child_id_list=() | child_id_list from fixelcfestats | child_id_list from ModelArray.lm() when n_cores = 4
| ------ | ----------- | ----------- | ----------- |----------- |
| length of child_id_list  | `${#child_id_list[@]}`    | 0       | 1 (i.e., there is something hidden but not real) | 4 |
| length of the first string in child_id_list | `${#child_id_list_element0}`   | 0        | 0 | e.g., 5 (just because the pid is 5-digit) |

This table tells us that length of child_id_list `${#child_id_list[@]}` is not accurate if there is no actual child process. Better use length of the first string in child_id_list `${#child_id_list_element0}` 

## The theory
[MRtrix fixelcfestats](https://mrtrix.readthedocs.io/en/latest/reference/commands/fixelcfestats.html) says if `nthreads` is not 0, it's a "multi-threaded applications".

Based on multi-threads def: https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/

A thread is the unit of execution within a process. A process can have anywhere from just one thread to many threads.

^^^ therefore, multi-threads should only use one process and not expect child process