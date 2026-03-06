<<<<<<< HEAD
# Princess Máxima Center Nanopore Nextflow Pipelines

This repository is a mono-repository containing Nextflow pipelines developed for the analysis of Oxford Nanopore sequencing data.
=======
# Nanopore nextflow pipelines repository
## Introduction

This repository contains all the basic requirements for running different nextflow pipelines, created for analyzing Oxford Nanopore sequencing data. All pipelines are/will be compatible with the Google Cloud Platform, through the [nflaunch tool](https://bitbucket.org/princessmaximacenter/nextflow-launcher/src/main/)


## Repository under development
At the moment the branch "CDEV-4082" is mainly for establishing the structure of the repository. No actual analyses can be run with this branch

## Current pipelines

- Sturgeon: CNS Classifier
>>>>>>> 3f20654417acc2ba451ba86c78e4cd93c5d97ae9

### Pipelines to be added in the future

- NanoQC: Pipeline for sequencing quality assesment
- Leukemia: Pipeline for methylation classification and genomic subtyping of leukemia samples

## Getting Started

<<<<<<< HEAD
### Prerequisites
- Nextflow
- Docker, Singularity, or Conda

### Executing the Pipeline (Local)
1. Create your input samplesheet following the requirements above.
2. Run the pipeline using the `-profile` flag and specifying your input and output directory:
=======
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
>>>>>>> 3f20654417acc2ba451ba86c78e4cd93c5d97ae9

---

## Pipeline Selection

You can select which pipeline to run using the `-profile` flag.

### Available Pipelines
- **qc**: NanoQC pipeline for sequencing quality control and visualization.

### Pipelines in development
- **Sturgeon**: Nextflow pipeline for CNS methylation-based classification

### Example Command
```bash
nextflow run princessmaximacenter/nextflow_pipeline --help
```

---

## QC Pipeline 
See [QC readme](./docs/QC.md) for full usage documentation of the QC pipeline

The NanoQC pipeline provides comprehensive quality control and visualization for Oxford Nanopore sequencing runs. It supports two main workflows depending on the input data:

- **Standard Flow**: General quality control for any nanopore sequencing run.
- **Adaptive Sampling Flow**: Specialized analysis for runs using adaptive sampling, including target region enrichment calculation.

See the help command with `-profile qc` for specific run requirements of the QC pipeline
```bash
nextflow run princessmaximacenter/nextflow_pipeline/main.nf \
-profile qc \
--help
```
<<<<<<< HEAD
=======
#### For now the sturgeon_nflaunch.sh script can be used for testing (only in the dev branch)
  
>>>>>>> 3f20654417acc2ba451ba86c78e4cd93c5d97ae9


---

## Cloud Deployment

Pipelines in this repository can be deployed to Google Cloud Platform (GCP) using the [nflaunch](https://bitbucket.org/princessmaximacenter/nextflow-launcher/) tool.

See [Running Pipelines on Google Cloud](./docs/cloud_deployment.md) for full documentation of GCP usage for nextflow pipelines



## Contributors
- Karlijn Cammel

## Version History

## TO-DO

<<<<<<< HEAD
See [Nanopore Analysis Development](https://prinsesmaximacentrum.atlassian.net/browse/GCDEV-4050) for planned development for nanopore nextflow pipelines
=======
- [ ] Create different profiles for running different pipelines
- [ ] Send email upon completion? 
- [ ] Unit testing
>>>>>>> 3f20654417acc2ba451ba86c78e4cd93c5d97ae9
