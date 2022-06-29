# Generate data for CircleCI tests
## generate significant data
This is to test that the ModelArray's results are as expected. We simulated significant results to do so.

* generate significant data and inject into .h5 file:
    * [generate_data_significant.Rmd](generate_data_significant.Rmd)
* NOT TO BE USED ANYMORE: calculate expected statistical results but without using ModelArray:
    * [expected_results.Rmd](expected_results.Rmd)
    * ^^^ has been moved to `ModelArray` repo, which will be calculated within the `testthat` and circle ci (i.e., when testing, first, generate the expected results; then, compare ModelArray's results with the expected results, using the same environment and dependent packages versions).
* Some notes on the reproducibility of `mgcv::gam` stat results:
    * Found discrepancy (but relatively small) between expected values calculate locally vs ModelArray results by circle ci, mostly in smooth term's stat or p.value
    * However the values can be fully replicated by running another time locally - so it's reliable given the same environment
    * For more: 
        * see slack on 6/14/22
        * see https://github.com/PennLINC/ModelArray/issues/65


## data for testing NaN etc:

* [prep_voxeldata_wNAs.Rmd](prep_voxeldata_wNAs.Rmd)
