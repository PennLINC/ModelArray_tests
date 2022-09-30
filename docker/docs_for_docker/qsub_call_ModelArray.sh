#!/bin/bash
# This is to submit the job to cubic compute node for running singularity image of ModelArray (+ConFixel)
# Assume this script is in the same folder as the R script.

h_vmem=30G
num_cores=4   # MAKE SURE IT'S CONSISTENT WITH pncNback_call_modelarrayR.sh!!!

cmd="qsub -l h_vmem=${h_vmem} -pe threaded ${num_cores} call_ModelArray.sh"
echo $cmd
#$cmd
