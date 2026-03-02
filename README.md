# Princess Máxima Center Nanopore Nextflow Pipelines

This repository is a mono-repository containing Nextflow pipelines developed for the analysis of Oxford Nanopore sequencing data.

## Pipeline Selection

You can select which pipeline to run using the `-profile` flag.

### Available Pipelines
- **qc**: NanoQC pipeline for sequencing quality control and visualization.
- **sturgeon**: CNS Classifier for nanopore sequencing data.

### Example Command
```bash
nextflow run princessmaximacenter/nextflow_pipeline -profile qc --input samplesheet.csv --outdir results
```

---

## QC Pipeline (NanoQC)

The NanoQC pipeline provides comprehensive quality control and visualization for Oxford Nanopore sequencing runs. It supports two main workflows depending on the input data:

- **Standard Flow**: General quality control for any nanopore sequencing run.
- **Adaptive Sampling Flow**: Specialized analysis for runs using adaptive sampling, including target region enrichment calculation.

### Samplesheet Requirements

The input samplesheet (`--input`) must be a CSV file with the following headers:

| Header | Description |
| --- | --- |
| `sample_id` | Unique identifier for the sample (no spaces). |
| `status` | Sample status, either `tumor` or `normal`. |
| `adaptive` | Path to a target regions BED file (required for adaptive sampling flow). |
| `bam` | Path to the BAM file. |
| `bai` | Path to the BAM index file. |
| `seq_sum` | Path to the sequencing summary TXT file. |

### Input Rules
- **Standard Flow**: Either a `bam` + `bai` pair **OR** a `seq_sum` file must be provided.
- **Adaptive Sampling Flow**: A `.bed` file must be supplied in the `adaptive` column. For this flow, a `bam` + `bai` pair is also required.

**Example samplesheet:**
```csv
sample_id,status,adaptive,bam,bai,seq_sum
PMBMABCD01,tumor,,/path/to/input.bam,/path/to/input.bam,bai
PMBMEFGH02,tumor,,,/path/to/sequencing_summary.txt
PMBMEFGH06,tumor,/path/to/adaptive_sampling.bed,/path/to/input.bam,/path/to/input.bam,bai
```
---

## Getting Started

### Prerequisites
- Nextflow
- Docker, Singularity, or Conda

### Executing the Pipeline (Local)
1. Create your input samplesheet following the requirements above.
2. Run the pipeline using the `-profile` flag and specifying your input and output directory:

```bash
nextflow run princessmaximacenter/nextflow_pipeline \
  -profile <pipeline_name>,<environment> \
  --input samplesheet.csv \
  --outdir <results_directory>
```
**Example QC command:**
```bash
nextflow run princessmaximacenter/nextflow/pipeline \
-profile qc,docker \
--input samplesheet.csv \
--outdir QC_results
```

---

## Cloud Deployment

Pipelines in this repository can be deployed to Google Cloud Platform (GCP) using the [nflaunch](https://bitbucket.org/princessmaximacenter/nextflow-launcher/) tool.

### Prerequisites
1.  Install the `nflaunch` tool and activate its virtual environment.
2.  Ensure you have the necessary permissions to run jobs on GCP Batch in the specified project.

### Executing the Pipeline (Cloud)
To launch a pipeline on the cloud, you can use the provided `*_nflaunch.sh` scripts as templates. These scripts are pre-configured with the necessary GCP parameters (project, region, network, etc.).

For example, to run the QC pipeline on GCP:
1.  Modify `qc_params.yml` and the samplesheet with your cloud-based file paths (e.g., `gs://...`).
2.  Execute the launch script:
    ```bash
    ./qc_nflaunch.sh
    ```

The `nflaunch` tool will handle the orchestration and submission of the Nextflow job to the cloud backend.

**Example samplesheet for google cloud:**

```csv
sample_id,status,adaptive,bam,bai,seq_sum
PBE82257,tumor,,gs://pmc-bdc-dev-nextflow-wd/sequencing-data/test_data/small-test-phased.bam,gs://pmc-bdc-dev-nextflow-wd/sequencing-data/test_data/small-test-phased.bam.bai
```

**Example nflaunch command:**
```
#!/usr/bin/env bash

nflaunch \
  --base-bucket pmc-bdc-dev-nextflow-wd \
  --backend gcp-batch \
  --pipeline-name . \
  --pipeline-version 0.0.1 \
  --samplesheet /Users/k.v.cammel/Documents/Projects/Nanopore_Nextflow/dev_tickets/GCDEV-4093_QC_pipeline/nextflow_pipeline/workflows/qc/samplesheet.csv \
  --params-file /Users/k.v.cammel/Documents/Projects/Nanopore_Nextflow/dev_tickets/GCDEV-4093_QC_pipeline/nextflow_pipeline/qc_params.yml \
  --project-id pmc-gcp-bdc-d-pip-nextflow \
  --region europe-west4 \
  --service-account-email sa-nextflow-runner@pmc-gcp-bdc-d-pip-nextflow.iam.gserviceaccount.com \
  --network projects/pmc-vpc-res-private-20gx/global/networks/shared-vpc-res-priv-dev \
  --subnetwork projects/pmc-vpc-res-private-20gx/regions/europe-west4/subnetworks/subnet-res-priv-dev \
  --profile qc \
  --labels '{"env": "dev", "samples_group": "qc", "feature": "local-dir", "tool": "nflaunch"}'
  $1
```

**Example params.yaml for nflaunch deployment:**
```

outdir: "gs://pmc-bdc-dev-nextflow-results/QC_test_results/"
input: /etc/nextflow/gcp_samplesheet.csv
```
---

## Contributors
- Karlijn Cammel
- Rodrigo Jara Calogeropulos

## Version History

## TO-DO

- [ ] Send email upon completion
- [ ] Create custom multiqc config file