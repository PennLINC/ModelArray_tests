# This is to generate toy voxel-wise data (NIfTI) to be used by ConVoxel

import os
import os.path as op

import math
import numpy as np
import nibabel as nb


def create_fake_volume(num_voxel_onedim, dist2center_thr, band_thickness,
                       seed_idx):
    """
    This is to create toy, cubic NIfTI image that:
    1) center part (distance to center < `dist2center_thr`):
        has positive value between 0-1
    2) the band around center ball (within `band_thickness`): 
        may have positive value between 0-1 or 0
    Other voxels in the background are 0.

    Parameters:
    --------------
    num_voxel_onedim: int
        positive int, number of voxels in one dimension
    dist2center_thr: float or int
        if a voxel's distance to the center of image < `dist2center_thr`,
        it will have a value between 0-1
    band_thickness: float or int
        define the thickness of the sphere around the center ball
        In this band, voxels may have positive value between 0-1, or still 0
    seed_idx: int
        seed index for `np.random`. Can take 0.

    Notes:
    --------
    Tested and confirmed that the image generated will be fixed give `seed_idx`
    """

    # set the seed:
    np.random.seed(seed_idx)

    i_voxel_center = (num_voxel_onedim + 1)/2 - 1
    # num_voxel_onedim = 5 -> i_voxel_center = 2 (ranging 0-4)
    # num_voxel_onedim = 4 -> i_voxel_center = 1.5 (ranging 0-3)

    fake_data = np.zeros(
        (num_voxel_onedim, num_voxel_onedim, num_voxel_onedim))

    for i in range(0, num_voxel_onedim):
        for j in range(0, num_voxel_onedim):
            for k in range(0, num_voxel_onedim):
                dist2center = math.sqrt(
                    math.pow(i-i_voxel_center, 2) +
                    math.pow(j-i_voxel_center, 2) +
                    math.pow(k-i_voxel_center, 2)
                )
                if dist2center <= dist2center_thr:
                    # assign a random value to the center part of the volume:
                    fake_data[i, j, k] = np.random.rand()  # between 0-1
                elif (dist2center > dist2center_thr) & \
                        (dist2center <= dist2center_thr + band_thickness):
                    # around the center voxels:
                    #   sometimes non-zero value, sometimes zero:
                    temp = np.random.rand()  # between 0-1
                    if temp > 0.5:   # half of the chance:
                        fake_data[i, j, k] = np.random.rand()  # between 0-1
                    else:   # the other half of the chance:
                        fake_data[i, j, k] = 0

    return fake_data


def get_mask(fn_nifti):
    """Get the image mask

    Parameters:
    --------------
    fn_nifti: str
        path to the file of the image to get mask from
    """
    img = nb.load(fn_nifti)
    mask_matrix = img.get_fdata() > 0
    mask_data = mask_matrix.astype('int16')   # change from bool to int

    return mask_data


def generate_mask_basedOnDist(num_voxel_onedim, dist2center_thr):
    """
    This is to generate a mask based on the voxel distance to the center.
    Voxels with distance to center <= `dist2center_thr` will have value = 1;
    Elsewhere, value = 0.

    Parameters:
    ------------
    see `create_fake_volume()`
    """
    i_voxel_center = (num_voxel_onedim + 1)/2 - 1

    fake_group_mask_data = np.zeros(
        (num_voxel_onedim, num_voxel_onedim, num_voxel_onedim))
    for i in range(0, num_voxel_onedim):
        for j in range(0, num_voxel_onedim):
            for k in range(0, num_voxel_onedim):
                dist2center = math.sqrt(
                    math.pow(i-i_voxel_center, 2) +
                    math.pow(j-i_voxel_center, 2) +
                    math.pow(k-i_voxel_center, 2)
                )
                if dist2center <= dist2center_thr:
                    # assign 1:
                    fake_group_mask_data[i, j, k] = 1
    return fake_group_mask_data


def main():
    # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    num_voxel_onedim = 11   # number of voxels in one dimension
    dist2center_thr = 3
    band_thickness = 1
    affine = np.eye(4)

    num_total_subject = 20    # 20

    metric_name = "FA"
    folder_main = op.join("/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/"
                          "fixel_project/ConFixel/tests/data_voxel_toy")
    folder_metric = op.join(folder_main, metric_name)
    folder_mask = op.join(folder_main, "individual_masks")
    # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    if not op.exists(folder_main):
        raise Exception("The main folder does not exist! " + folder_main)
    if not op.exists(folder_metric):
        os.makedirs(folder_metric)
    if not op.exists(folder_mask):
        os.makedirs(folder_mask)

    # generate group mask:
    group_mask_data = generate_mask_basedOnDist(
        num_voxel_onedim, dist2center_thr+band_thickness)
    fn_group_mask_nifti = op.join(folder_main,
                                  "group_mask_" + metric_name + ".nii.gz")
    group_mask_nifti = nb.Nifti1Image(group_mask_data, affine)
    group_mask_nifti.to_filename(fn_group_mask_nifti)

    # generate another mask:
    #   voxels within the mask have values from all the subjects:
    core_mask_data = generate_mask_basedOnDist(
        num_voxel_onedim, dist2center_thr)   # only `dist2center_thr`
    fn_core_mask_nifti = op.join(folder_main,
                                 "core_mask_" + metric_name + ".nii.gz")
    core_mask_nifti = nb.Nifti1Image(core_mask_data, affine)
    core_mask_nifti.to_filename(fn_core_mask_nifti)

    for i_sub in range(0, num_total_subject):
        sub_id = "{:02d}".format(i_sub + 1)    # 2 char
        fn_nifti = op.join(folder_metric,
                           "sub-" + sub_id +
                           "_" + metric_name + ".nii.gz")
        fn_mask_nifti = op.join(folder_mask,
                                "sub-" + sub_id +
                                "_" + metric_name + "_mask.nii.gz")

        fake_data = \
            create_fake_volume(num_voxel_onedim, dist2center_thr,
                               band_thickness, i_sub)
        fake_nifti = nb.Nifti1Image(fake_data, affine)
        # save the image:
        fake_nifti.to_filename(fn_nifti)

        # get the mask:
        fake_mask = get_mask(fn_nifti)
        fake_mask_nifti = nb.Nifti1Image(fake_mask, affine)
        # save the mask:
        fake_mask_nifti.to_filename(fn_mask_nifti)


if __name__ == "__main__":
    main()
