# Docker

## Prepare base image of ModelArray + ConFixel's docker image
* Dockerfile: [Dockerfile_build](Dockerfile_build)
* build & deploy: [build_and_deploy_prebuilt_Docker.sh](build_and_deploy_prebuilt_Docker.sh)

## Test out building & deploying ModelArray + ConFixel's docker image
* build & deploy: [build_and_deploy_docker.sh](build_and_deploy_docker.sh)
    * current version: see CircleCI of ModelArray GitHub repo
    * under trying and on roadmap: multi-arch build: [multiarch_build_docker](multiarch_build_docker)

## Write the doc for how to use Docker image and test out the scripts
* in folder `docs_for_docker`
* Run on CUBIC cluster:
    * setups (code except running ModelArray): [setups_cubic.sh](setups_cubic.sh)
    * run ModelArray:
        * R script: [run_ModelArray.R](run_ModelArray.R)
        * bash script to call this R script: [call_ModelArray.sh](call_ModelArray.sh)
        * qsub the job: [qsub_call_ModelArray.sh](qsub_call_ModelArray.sh)

The folder structure on cubic:
```{console}
/cbica/projects/fixel_db/dropbox/data_demo/myProject
├── code
│   ├── call_ModelArray_old.sh
│   ├── call_ModelArray.sh
│   ├── call_ModelArray.sh.e1804502
│   ├── call_ModelArray.sh.o1804502
│   ├── call_ModelArray.sh.pe1804502
│   ├── call_ModelArray.sh.po1804502
│   ├── printed_message_fullrun.txt
│   ├── printed_message_nfixels-100.txt
│   ├── printed_message.txt  # this is for testing out
│   └── run_ModelArray.R
└── data
    ├── cohort_FDC_n100.csv
    ├── demo_FDC_n100_backup.h5
    ├── demo_FDC_n100.h5
    ├── demo_FDC_n100_withLmResults.h5
    └── FDC   # this includes those input .mif files
```

### Details on a successful full run of `ModelArray.lm()`
* jobID = 1804502, done on 9/29/2022.
* Details:
    * `qacct -j 1804502`, took 1h40min, using 4 CPUs, on compute node
    * formula: `FDC ~ Age + sex + dti64MeanRelRMS`
    * maximal virtual memory (maxvmem)      2.653GB
    * mem is probably = the integral of mem * time
        * cpu          23562.082s
        * mem          12.822TBs
        * so I guess the max mem should be 12.822 * 1024 / (23562.082/4) = 2.229 GB
            * `/4` means there are 4 CPUs, and times of all cpus are added up
