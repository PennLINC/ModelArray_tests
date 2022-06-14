# This is a temporary test file for debugging GAM's expected values
# can be used both locally and when ssh into circle ci

# load all necessary stuff:
devtools::load_all()
options(digits=15)

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
formula <- FD ~ s(age, fx=TRUE) + sex   
#formula <- FD ~ oSex + s(age,k=4, fx=TRUE) + s(age, by=oSex, fx=TRUE) + factorB 

### directly call mgcv, instead of using ModelArray: #####

value <- scalars(modelarray)[[scalar_name]][idx.fixel.gam, ]
data <- phenotypes
data[[scalar_name]] <- value

onemodel <- mgcv::gam(formula = formula, data = data)
onemodel.summary <- summary(onemodel)

onemodel.summary
onemodel.summary$s.table   # the table for the smooth term such as age

# this means that the mgcv::gam() results are already different!
