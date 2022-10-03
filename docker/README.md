# Docker

## Prepare base image of ModelArray + ConFixel's docker image
* Dockerfile: [Dockerfile_build](Dockerfile_build)
* build & deploy: [build_and_deploy_prebuilt_Docker.sh](build_and_deploy_prebuilt_Docker.sh)

## Test out building & deploying ModelArray + ConFixel's docker image
* build & deploy: [build_and_deploy_docker.sh](build_and_deploy_docker.sh)
    * current version: see CircleCI of ModelArray GitHub repo
    * under trying and on roadmap: multi-arch build: [multiarch_build_docker.sh](multiarch_build_docker.sh)

## Write the doc for how to use Docker image and test out the scripts
* in folder `docs_for_docker`
* Run on CUBIC cluster:
    * setups (code except running ModelArray): [setups_on_cubic.sh](docs_for_docker/setups_on_cubic.sh)
    * run ModelArray:
        * R script: [run_ModelArray.R](docs_for_docker/run_ModelArray.R)
        * bash script to call this R script: [call_ModelArray.sh](docs_for_docker/call_ModelArray.sh)
        * qsub the job: [qsub_call_ModelArray.sh](docs_for_docker/qsub_call_ModelArray.sh)

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
    * highest instance memory use during the execution of the job (maxvmem)      2.653GB
    * mem = the integral of mem * time; according to cubic's manual, "is not useful in specifying memory requirements"
    * I requested `h_vmem=30G`
    * printed message: `printed_message_fullrun_hvmem-30G.txt`
    * results: `demo_FDC_n100_withLmResults.h5`

* later tested with `h_vmem=10G` (jobID = 1810504, 10/3/22)
    * `maxvmem` is very close to above job
    * printed message: `printed_message_fullrun_hvmem-10G.txt`
    * results: `demo_FDC_n100_withLmResults_hvmem-10G.h5`
