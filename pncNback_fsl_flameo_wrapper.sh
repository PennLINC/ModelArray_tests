#!/bin/bash
# this is the wrapper.sh for submitting script to cubic compute node
# configurations were based on what Kristin used: h_vmem=20G, s_vmem=25G

h_vmem="30G"
s_vmem="25G"
#cmd="qsub -l h_vmem=${h_vmem} s_vmem=${s_vmem} pncNback_fsl_flameo.sh"  # however there is no option of s_vmem???
cmd="qsub -l h_vmem=${h_vmem} pncNback_fsl_flameo.sh"
echo $cmd
$cmd