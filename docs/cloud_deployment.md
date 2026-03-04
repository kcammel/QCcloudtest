# Running nextflow pipelines on the Google Cloud
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
PBE82257,tumor,,gs://<BASE_BUCKET>/sequencing-data//input.bam,gs://<BASE_BUCKET>/sequencing-data//input.bam.bai
```

**Example nflaunch command:**
```
#!/usr/bin/env bash

nflaunch \
  --base-bucket BASE_BUCKET \
  --backend gcp-batch \
  --pipeline-name . \
  --pipeline-version 0.0.1 \
  --samplesheet qc_pipeline/qc_gcp_samplesheet.csv \
  --params-file qc_pipeline/qc_params.yml \
  --project-id PROJECT_ID \
  --region REGION \
  --service-account-email SERVICE_ACCOUNT \
  --network NETWORK \
  --subnetwork SUBNETWORK \
  --profile qc \
  --labels '{"env": "dev", "samples_group": "qc", "feature": "local-dir", "tool": "nflaunch"}' \
  --dry-run
  $1
```

**Example qc_params.yaml for nflaunch deployment:**
```

outdir: "gs://<BASE_BUCKET>/QC_results/"
input: /etc/nextflow/qc_gcp_samplesheet.csv
```
---