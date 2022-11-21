# Useful commands for debugging HDF5 file
Recommend: create an Rmd file for debugging.

## load libraries:
```
library(ModelArray)
library(rhdf5)
```
## Set up the filenames of h5 and csv files
using `file.path()` to join directories/folders

## investigate hdf5 file
```
h5ls(fn_h5)
h5f = H5Fopen(fn_h5)
h5f$results$<your_results_name>
```

## investigate csv file
```
csv = read.csv(fn_csv)
head(csv)
```

## Finish
```
H5Fclose(h5f)   # if not closed, ConFixel cannot open it
```
