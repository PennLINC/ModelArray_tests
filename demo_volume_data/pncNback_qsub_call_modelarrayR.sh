#!/bin/bash
# This is to submit the job to cubic compute node for running singularity image of ModelArray (+ConFixel)

h_vmem=30G
num_cores=4   # MAKE SURE IT'S CONSISTENT WITH pncNback_call_modelarrayR.sh!!!

cmd="qsub -l h_vmem=${h_vmem} -pe threaded ${num_cores} pncNback_call_modelarrayR.sh"
echo $cmd
$cmd