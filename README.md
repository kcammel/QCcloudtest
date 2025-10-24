# Nanopore nextflow pipelines repository

This repo contains the nextflow pipelines created for analyzing Oxford Nanopore sequencing data.

## Description

Current pipelines

- Sturgeon: CNS Classifier

## Getting Started

### Executing program

* Deployment is currently only on Google Cloud
* Pipelines must be run through the [nf-launch platform](https://bitbucket.org/princessmaximacenter/nextflow-launcher/)

```
Install the nextflow launcher and activate the venv
Create the nflaunch.sh script and run as:
./nflaunch.sh
```
#### For now the sturgeon_nflaunch.sh script can be used for testing
  

## Help

Any advise for common problems or issues.

## Contributors

- Karlijn Cammel
- Rodrigo Jara Calogeropulos

## Version History

## TO-DO

- [ ] Test deployment on HPC 
- [ ] Input parameters through yml/json file 
- [ ] Clean up setting of parameters 
- [ ] Edit wrapper script to handle better shutdown triggering in nextflow/cloud integration 
- [ ] Consider ways to host multiple pipelines in one repository 
- [ ] Send email upon completion? 