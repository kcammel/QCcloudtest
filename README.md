# Princess Máxima Center Nanopore Nextflow Pipelines

This repository is a mono-repository containing Nextflow pipelines developed for the analysis of Oxford Nanopore sequencing data.

## Getting Started

### Prerequisites
- Nextflow
- Docker, Singularity, or Conda

### Executing the Pipeline (Local)
1. Create your input samplesheet following the requirements above.
2. Run the pipeline using the `-profile` flag and specifying your input and output directory:

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


---

## Cloud Deployment

Pipelines in this repository can be deployed to Google Cloud Platform (GCP) using the [nflaunch](https://bitbucket.org/princessmaximacenter/nextflow-launcher/) tool.

See [Running Pipelines on Google Cloud](./docs/cloud_deployment.md) for full documentation of GCP usage for nextflow pipelines



## Contributors
- Karlijn Cammel
- Rodrigo Jara Calogeropulos

## Version History

## TO-DO

See [Nanopore Analysis Development](https://prinsesmaximacentrum.atlassian.net/browse/GCDEV-4050) for planned development for nanopore nextflow pipelines