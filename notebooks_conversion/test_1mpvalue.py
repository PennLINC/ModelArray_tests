# this is to test if the 1-pvalue worked as expected
# for fixel data

import sys
import os
import os.path as op

sys.path.append( os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "confixel"  ))
from confixel.fixels import *    # mif_to_nifti2

# +++++++++++++++++++++++++++++++++++++++++++
folder_main = "/home/chenying/Desktop/fixel_project/data/data_from_josiane/results"
foldername_orig = "ltn_FDC_n938_wResults_nfixels-0_20220204-140019_orig"   # previous version of ConFixel
foldername_new = "ltn_FDC_n938_wResults_nfixels-0_20220204-140019"   # current version of ConFixel, including 1m.p.values 

filename_main = "gam_allOutputs_s_Age.p.value.bonferroni"
filename_1mpvalue = filename_main.replace("p.value", "1m.p.value")
# +++++++++++++++++++++++++++++++++++++++++++

folder_orig = op.join(folder_main, foldername_orig)
folder_new = op.join(folder_main, foldername_new)

fn_orig = op.join(folder_orig, filename_main + ".mif")  # p.value in original folder
fn_new = op.join(folder_new, filename_main + ".mif")   # p.value in new folder
fn_1mpvalue = op.join(folder_new, filename_1mpvalue + ".mif")   # 1-p.value in the new folder

_, values_orig = mif_to_nifti2(fn_orig)
_, values_new = mif_to_nifti2(fn_new)
_, values_1mpvalue = mif_to_nifti2(fn_1mpvalue)

diff1 = max(abs(values_orig - values_new))
diff2 = max(abs(values_orig - (1 - values_1mpvalue)))
diff3 = max(abs(values_new - (1 - values_1mpvalue)))

print(diff1)
print(diff2)
print(diff3)