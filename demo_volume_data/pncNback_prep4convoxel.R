# This file is for preparing data and files for running ConVoxel for PNC fMRI n-back data and replicate Murtha, Kristin et al., 2022 results.

library("testthat")

### prepare .csv for ConVoxel #####
folder <- "/home/chenying/Desktop/fixel_project/data/data_voxel_kristin_nback" # vmware
fn.csv.orig <- file.path(folder, "model.csv")
fn.csv.updated <- file.path(folder, "pncNback_phenotypes.csv")
fn.filelist <- file.path(folder, "list_filenames_pncNback.txt")  # the list of .nii.gz image filenames

t <- read.csv(fn.csv.orig)
nrow <- nrow(t)

t.filelist <- read.table(fn.filelist)
filelist <- t.filelist$V1   # number of files: 1462
# add columns: scalar_name and source_file:

t$scalar_name <- "contrast"
t$source_file <- NA

counts_moreThanOneFile <- 0
counts_noMatchedFile <- 0
for (i in 1:nrow) {
  
  bblid <- t$bblid[i]
  
  # Kristin: extracted the images that match with those 1150 bblid
  # ref: https://github.com/PennLINC/Murtha_Nback_Adversity/blob/main/run_flameo.sh
  
  # TODO: find out the corresponding image filename: find "xxx_"; check if there is any >1 or only 0 images for a bblid
  temp <- grep(paste0(bblid, "_"), 
               filelist, fixed=TRUE) # returns the id
  if (length(temp) >1) {
    warning(paste0("#", toString(i), " bblid=",bblid, " has more than one matched file!"))
    counts_moreThanOneFile <- counts_moreThanOneFile + 1
  }
  if (length(temp) <1) {
    warning(paste0("#", toString(i), " bblid=",bblid, " does not have any matched file!"))
    counts_noMatchedFile <- counts_noMatchedFile + 1
  }
  
  filename.temp <- filelist[temp]
  filename.temp <- substr(filename.temp, 
                          1, nchar(filename.temp)-1)   # remove the last "*"
  
  # check the last several characters: should be ".nii.gz":
  last_7_char <- substr(filename.temp,nchar(filename.temp)-6,nchar(filename.temp))
  if (! last_7_char==".nii.gz") {
    stop("extension is not .nii.gz!")
  }
  
  fn.temp <- paste0("n1601_voxelwiseMaps_cope/", filename.temp)
  
  t$source_file[i] <- fn.temp
}
if (counts_moreThanOneFile > 0) {
  warning(paste0("-- in total, there are ", toString(counts_moreThanOneFile)," subjects with more than one matched file!"))
}
if (counts_noMatchedFile > 0) {
  warning(paste0("-- in total, there are ", toString(counts_noMatchedFile)," subjects without any matched file!"))
}

# sanity check: there is no repeated source_file in that column:
unique.filelist.used <- unique(t$source_file)
expect_equal(length(unique.filelist.used),
             nrow)

# mask file list:
t$source_mask_file <- "n1601_NbackCoverageMask_20170427.nii.gz"   # there is no subject-specific masks for PNC fMRI n-back

# save updated t:
write.table(t, file=fn.csv.updated, sep=",", row.names=FALSE, col.names=TRUE, quote = FALSE)  

### compare with existing file from Kristin #####
t <- read.csv(fn.csv.updated)

fn.kristin.filelist <- file.path(folder, "revision","2b0bcontrast_list.csv")
kristin.filelist <- read.table(fn.kristin.filelist)
kristin.filelist <- kristin.filelist$V1
kristin.filelist <- gsub("/cbica/projects/Kristin_CBF/nback_adversity/", "", 
                         kristin.filelist)     
expect_equal(t$source_file,
             kristin.filelist)
