# This is to prepare a CSV file for testing ConVoxel.
# This is accompanied to toy voxel-wise data.

rm(list=ls())

set.seed(1)    # fix seed

n.subj <- 20
scalar_name <- "FA"
main.folder <- "/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/ConFixel/tests/data_voxel_toy"

# subject ID:
subject_id_chars <- sprintf("%02d", 1:n.subj)   # 01,02,...20
subject_id_vec <- paste("sub-", subject_id_chars, sep="")
df <- data.frame(subject_id_vec)
colnames(df) <- list("subject_id")

# age:
df[["age"]] <- sample(10:20, n.subj, replace=T)

# sex:
df[["sex"]] <- sample(0:1, n.subj, replace=T)

# scalar_name:
df[["scalar_name"]] <- rep(scalar_name, n.subj)

# source_file:
df[["source_file"]] <- paste(scalar_name, "/sub-", subject_id_chars, "_", scalar_name, ".nii.gz",
                             sep="")
# source_mask_file:
df["source_mask_file"] <- paste("individual_masks/sub-", subject_id_chars, "_", scalar_name, "_mask.nii.gz",
                                sep="")

# save:
fn.csv <- file.path(main.folder, "cohort_FA.csv")
write.csv(df, fn.csv, row.names = FALSE)
