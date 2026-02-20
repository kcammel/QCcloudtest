# Nanopore nextflow pipelines repository
## Introduction

This repository contains all the basic requirements for running different nextflow pipelines, created for analyzing Oxford Nanopore sequencing data. All pipelines are/will be compatible with the Google Cloud Platform, through the [nflaunch tool](https://bitbucket.org/princessmaximacenter/nextflow-launcher/src/main/)


## Repository under development
At the moment the branch "CDEV-4082" is mainly for establishing the structure of the repository. No actual analyses can be run with this branch

## Current pipelines

- Sturgeon: CNS Classifier

### Pipelines to be added in the future

- NanoQC: Pipeline for sequencing quality assesment
- Leukemia: Pipeline for methylation classification and genomic subtyping of leukemia samples

## Getting Started

### Requirements
- nextflow (development was done on version 25.04.6, but all newer versions should work as well)
- java (version 17 or later)

### Executing program

* Deployment will be possibe both locally and through the Google Cloud
```
Local deployment can be done through:
nextflow run main.nf --help

For pipeline specific help:
nextflow run main.nf -profile sturgeon --help
```
* For running pipelines with Google Cloud, they must be run through the [nf-launch platform](https://bitbucket.org/princessmaximacenter/nextflow-launcher/)

```
Install the nextflow launcher and activate the venv
Create the nflaunch.sh script and run as:
./sturgeon_nflaunch.sh
```
#### For now the sturgeon_nflaunch.sh script can be used for testing (only in the dev branch)
  

## Help

Any advise for common problems or issues.

## Contributors

- Karlijn Cammel

## Version History

## TO-DO

- [ ] Create different profiles for running different pipelines
- [ ] Send email upon completion? 
- [ ] Unit testing