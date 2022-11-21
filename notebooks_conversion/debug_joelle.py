# Debugging for Joelle's case
# Nov 18, 2022

# How to run this file:
#   1. move this file to `ConFixel/notebooks/` folder
#   1. add necessary args into `launch.json`: see `fixelstats_write` below

import sys
import os
import os.path as op
# import subprocess

#sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "confixel"))
from confixel.fixels import h5_to_fixels

# Joelle's data:
folder_main = "/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/data/data_from_joelle"
filename_h5 = "TDI.h5"

h5_to_fixels()

"""
fixelstats_write \
                --index-file index.mif \
                --directions-file directions.mif \
                --cohort-file cohort_TDI.csv \
                --relative-root /Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/data/data_from_joelle \
                --analysis-name TDI_thres \
                --input-hdf5 TDI.h5 \
                --output-dir TDI_thres_confixel_python3p8
"""



print("")