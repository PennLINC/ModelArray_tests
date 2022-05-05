# This is to debug why the saved volume images have decimals in images e.g. nobs (should be integer)

import os
import os.path as op
from collections import defaultdict
import nibabel as nb
import pandas as pd
import numpy as np
from collections import defaultdict
from tqdm import tqdm
import h5py

folder_main = "/home/chenying/Desktop/fixel_project/data/data_voxel_grmpy"
filename_h5_woext = "GRMPY_meanCBF_n209_indmask_nvoxels-0_wResults_20220504-180709"
#filename_results = "lm_fullOutputs_model.nobs.nii.gz"
#filename_results = "lm_fullOutputs_model.p.value.nii.gz"
filename_results = "lm_fullOutputs_model.1m.p.value.nii.gz"   # 1-p.value

filename_mask = "tpl-MNI152NLin6Asym_res-02_desc-brain_mask.nii.gz"

print("filename of the result: " + filename_results)

folder_results = os.path.join(folder_main, filename_h5_woext)
fn_results = os.path.join(folder_results, filename_results)

fn_mask = os.path.join(folder_main, filename_mask)

img = nb.load(fn_results)
header = img.header
print(header.get_data_dtype())

data = img.get_fdata()
print(data.shape)
print(data[47,30,31])   # max nobs
print(data[47,75,25])   # not max nobs
print(data[19,37,12])   # known NaN

print("the slope and the intercept of the scaling:")   # https://nipy.org/nibabel/nifti_images.html
print(header['scl_slope'])
print(header['scl_inter'])

print("")

img_mask = nb.load(fn_mask)
header_mask = img_mask.header
print("the data type of mask image: ")
print(header_mask.get_data_dtype())


print("")