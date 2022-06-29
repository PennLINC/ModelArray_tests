# This is a temporary test file for debugging GAM's expected values
# can be used both locally and when ssh into circle ci

# load all necessary stuff:
rm(list=ls())
devtools::load_all()
options(digits=15)
#set.seed(1234)     # DO NOT RUN MULTIPLE TIMES!

### input data: ####
h5_path <- system.file("extdata", "n50_fixels.h5", package = "ModelArray")

scalar_name <- c("FD")
modelarray <- ModelArray(h5_path,
                         scalar_types = scalar_name,
                         analysis_names = c("my_analysis"))

csv_path <- system.file("extdata", "n50_cohort.csv", package = "ModelArray")

phenotypes <- read.csv(csv_path)
phenotypes$oSex <- ordered(phenotypes$sex, levels = c("F", "M"))  # ordered factor, "F" as reference group


### load expected results #####
idx.fixel.gam <- 11
fn.expected.results <- system.file("extdata",
                                   "n50_fixels_gam_expectedResults.RData",
                                   package="ModelArray")
load(fn.expected.results)  # variable name: expected.results



### for this case:
#formula <- FD ~ s(age, fx=TRUE) + sex   
formula <- FD ~ ti(age, fx=TRUE) + ti(factorB, fx=TRUE) + ti(age, factorB, fx=TRUE) + factorA
#formula <- FD ~ oSex + s(age,k=4, fx=TRUE) + s(age, by=oSex, fx=TRUE) + factorB 

### directly call mgcv, instead of using ModelArray: #####

value <- scalars(modelarray)[[scalar_name]][idx.fixel.gam, ]
data <- phenotypes
data[[scalar_name]] <- value

onemodel <- mgcv::gam(formula = formula, data = data)
onemodel.summary <- summary(onemodel)

onemodel.summary
onemodel.summary$s.table   # the table for the smooth term such as age

# # re.test = FALSE does not change the results:
# set.seed(1)
# onemodel.summary.retestFALSE <- summary(onemodel, re.test=FALSE)
# onemodel.summary.retestFALSE$s.table

# this means that the mgcv::gam() results are already different!


### use ModelArray to calculate:
#element.subset <- idx.fixel.gam %>% as.integer()
element.subset <- 1:20
results.run1 <- ModelArray.gam(formula, data = modelarray, phenotypes = phenotypes, scalar = scalar_name, element.subset = element.subset,
                                               n_cores = 4, pbar = FALSE, full.outputs = TRUE)
results.run2 <- ModelArray.gam(formula, data = modelarray, phenotypes = phenotypes, scalar = scalar_name, element.subset = element.subset,
                               n_cores = 4, pbar = FALSE, full.outputs = TRUE)
testthat::expect_equal(results.run1, 
                       results.run2)
testthat::expect_identical(results.run1, 
                       results.run2)
