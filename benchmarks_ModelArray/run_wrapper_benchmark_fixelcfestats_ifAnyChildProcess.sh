#!/bin/bash

# this script is to test whether there is any child process in fixelcfestats
# ref: ModelArray_paper/run_wrapper_benchmark_fixelcfestats.sh

bash ../../ModelArray_paper/benchmarks/myDropCaches.sh
cmd="bash wrapper_benchmark_fixelcfestats_ifAnyChildProcess.sh -S 30 -h 100 -t 4 -f TRUE -F FALSE -n FALSE -w vmware -M TRUE -s 1"
echo $cmd
$cmd