import sys
import os
import os.path as op
import numpy as np
import pandas as pd
import nibabel as nb
from scipy.stats import pearsonr
from plotnine import ggplot, aes, geom_point, geom_text
import seaborn as sns
import matplotlib.pyplot as plt

def load_img(fn, group_mask_matrix):
    scalar_img = nb.load(fn)
    scalar_matrix = scalar_img.get_fdata()

    flattened_inmask = scalar_matrix[group_mask_matrix].squeeze()

    return flattened_inmask


folder_main = "/home/chenying/Desktop/fixel_project/data/data_voxel_kristin_nback"
folder_modelarray = op.join(folder_main, "pncNback_nvoxels-0_wResults_20220317-162937")
folder_fsl = op.join(folder_main, "revision_flameo_ols++")

group_mask_fn = op.join(folder_main, "n1601_NbackCoverageMask_20170427.nii.gz")
group_mask_img = nb.load(group_mask_fn)
group_mask_matrix = group_mask_img.get_fdata() > 0

# tstat:
tstat_parentEd_modelarray_fn = op.join(folder_modelarray, "lm_fullOutputs_parental_ed.statistic.nii.gz")
tstat_parentEd_modelarray = load_img(tstat_parentEd_modelarray_fn, group_mask_matrix)

tstat_parentEd_fsl_fn = op.join(folder_fsl, "tstat5.nii.gz")
tstat_parentEd_fsl = load_img(tstat_parentEd_fsl_fn, group_mask_matrix)

# estimate:
estimate_parentEd_modelarray_fn = op.join(folder_modelarray, "lm_fullOutputs_parental_ed.estimate.nii.gz")
estimate_parentEd_modelarray = load_img(estimate_parentEd_modelarray_fn, group_mask_matrix)

estimate_parentEd_fsl_fn = op.join(folder_fsl, "pe5.nii.gz")
estimate_parentEd_fsl = load_img(estimate_parentEd_fsl_fn, group_mask_matrix)

# tstat_envSES_modelarray_fn = op.join(folder_modelarray, "lm_fullOutputs_envSES.statistic.nii.gz")
# tstat_envSES_modelarray_fn = nb.load(tstat_envSES_modelarray_fn)

diffabsmax = max(abs(tstat_parentEd_modelarray - tstat_parentEd_fsl))
print(diffabsmax)

diffabsmax = max(abs(estimate_parentEd_modelarray - estimate_parentEd_fsl))
print(diffabsmax)

# r = pearsonr(tstat_parentEd_modelarray, 
#         tstat_parentEd_fsl)


d = {'tstat_parentEd_modelarray':   tstat_parentEd_modelarray,
     'tstat_parentEd_fsl':          tstat_parentEd_fsl,
     "estimate_parentEd_fsl":       estimate_parentEd_fsl,
     "estimate_parentEd_modelarray": estimate_parentEd_modelarray} 

df = pd.DataFrame(data=d)



f1 = plt.figure("tstat parentEd")
sns.scatterplot(data=d, x="tstat_parentEd_fsl", y="tstat_parentEd_modelarray",
                 alpha=0.05)
plt.xlim(-6, 6)
plt.ylim(-6, 6)
r = pearsonr(tstat_parentEd_modelarray, tstat_parentEd_fsl)[0]
str_title = "tstat parentEd, corr=" + str(round(r, 4))
plt.title(str_title, size=16)
#plt.plot([-6,-6], [6,6], linewidth=2)
#plt.xlabel(fontsize=14)
#plt.ylabel(fontsize=14)


f2 = plt.figure("estimate parentEd")
sns.scatterplot(data=d, x="estimate_parentEd_fsl", y="estimate_parentEd_modelarray",
                 alpha=0.05)
plt.xlim(-6, 6)
plt.ylim(-6, 6)
r = pearsonr(estimate_parentEd_modelarray, estimate_parentEd_fsl)[0]
str_title = "estimate parentEd, corr=" + str(round(r, 4))
plt.title(str_title, size=16)
#plt.plot([-6,-6], [6,6], linewidth=2)
#plt.xlabel(fontsize=14)
#plt.ylabel(fontsize=14)


plt.show()
print()
