#!/bin/bash

# This is to figure out the command for building and deploying docker image of ModelArray (and ConFixel)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++
docker_tag="unstable"

folder_data_demo="/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/data/data_demo"
folder_data_demo_cubic="/cbica/projects/fixel_db/dropbox/data_demo"
mounted_dir="/mnt/mydata"

folder_sif_cubic="/cbica/projects/fixel_db/software/singularity_images"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++

## Build:
# !! command below must be run in folder `ModelArray`:
docker build -t pennlinc/modelarray_confixel:${docker_tag} \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    --build-arg VCS_REF=`git rev-parse HEAD` .
# ^^ this step will take ~3min to rerun (because COPY step in the Dockerfile will be run every time,
    # so does the steps following it, e.g., install ModelArray)

## Tests:
# test ModelArray:
docker run --rm -it pennlinc/modelarray_confixel:${docker_tag} R
    # now you're in an R env with ModelArray installed. Try:
    # > library(ModelArray)
    # > packageVersion("ModelArray")

# test ConFixel:   # ref: babs_tests/prep_toyBIDSApp.sh
    # !!! remember to mount all the folders you want
    # !!! and using `mounted_dir` for `--relative-root`!
docker run --rm -it \
    -v ${folder_data_demo}:${mounted_dir} \
    pennlinc/modelarray_confixel:${docker_tag} \
    confixel \
        --index-file FDC/index.mif \
        --directions-file FDC/directions.mif \
        --cohort-file cohort_FDC_n100.csv \
        --relative-root ${mounted_dir} \
        --output-hdf5 demo_FDC_n100.h5

## Push (Deploy):
# !!! if pushed from Mac M1, it cannot be run on cubic or linux system!!
docker push pennlinc/modelarray_confixel:${docker_tag}


## Test on CUBIC:
# run in ${folder_sif_cubic}:
singularity pull docker://pennlinc/modelarray_confixel:unstable
# run in ${folder_data_demo_cubic}:
singularity run --cleanenv \
    ${folder_sif_cubic}/modelarray_confixel_${docker_tag}.sif \
    R

singularity run --cleanenv -B ${folder_data_demo_cubic}:${mounted_dir} \
    ${folder_sif_cubic}/modelarray_confixel_${docker_tag}.sif \
    confixel \
    --index-file FDC/index.mif \
    --directions-file FDC/directions.mif \
    --cohort-file cohort_FDC_n100.csv \
    --relative-root ${mounted_dir} \
    --output-hdf5 demo_FDC_n100.h5
# `-B` = `--bind`, i.e., mounted dir for singularity