This is the README file on tests on memory benchmarking.

# MRtrix
## Confirm there is only one process and there is no child process
* using myMemoryProfiler_fortests.sh
* cd to benchmarks folder; then call: (run_wrapper)_benchmark_fixelcfestats.sh

If "-c 1", i.e. trying to detect one child process, even though there is no child process (i.e. $child_id_list is empty), the "${#child_id_list[@]}" in myMemoryProfiler_fortests.sh (i.e. the length of this list) will still 1. So it actually did not detect child process.

Based on multi-threads def: https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
A thread is the unit of execution within a process. A process can have anywhere from just one thread to many threads.
^^^ therefore, multi-threads use one process. So it's fine that directly specify "-c 1". Also the results across multiple threads are as expected (increase with # of threads)