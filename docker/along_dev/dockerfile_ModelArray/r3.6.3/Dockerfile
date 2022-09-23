# This is to build Docker image for a specific R version, so that we can test the installation of ModelArray
## Base image https://hub.docker.com/u/rocker/
#FROM rocker/verse:3.6.3     # <- already include some R packages!
FROM rocker/r-ver:3.6.3

## Install libraries in linux system:
# ref: .circleci/config.yml from ModelArray:
RUN apt-get update && apt-get install -y --no-install-recommends \
    libhdf5-dev \
    texlive-fonts-recommended


# HOW TO BUILD DOCKER IMAGE BASED ON THIS DOCKERFILE:
# $ docker build -t chenyingzhao/myr:r3.6.3forModelArray .
# $ docker push "chenyingzhao/myr:r3.6.3forModelArray"

# HOW TO RUN R FROM THIS DOCKER IMAGE:
# $ docker run --rm -it chenyingzhao/myr:r3.6.3forModelArray R
# in R:
# > library(devtools)   
# > devtools::install_github("PennLINC/ModelArray@<commitSHA>")  # should be commit SHA of branch circleci_rversion: 6f4684cf7dc608e3b3b2a862a6bc0f7db5d1808f