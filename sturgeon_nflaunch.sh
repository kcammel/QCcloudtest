#!/usr/bin/env bash

nflaunch \
  --base-bucket pmc-bdc-dev-nextflow-wd \
  --backend gcp-batch \
  --pipeline-name /Users/k.v.cammel/Documents/Projects/Nanopore_Nextflow/Sturgeon_Nextflow \
  --pipeline-version 0.1.0 \
  --params-file /Users/k.v.cammel/Documents/Projects/Nanopore_Nextflow/Sturgeon_Nextflow/sturgeon_params.yml \
  --project-id pmc-gcp-bdc-d-pip-nextflow \
  --region europe-west4 \
  --service-account-email sa-nextflow-runner@pmc-gcp-bdc-d-pip-nextflow.iam.gserviceaccount.com \
  --network projects/pmc-vpc-res-private-20gx/global/networks/shared-vpc-res-priv-dev \
  --subnetwork projects/pmc-vpc-res-private-20gx/regions/europe-west4/subnetworks/subnet-res-priv-dev \
  --labels '{"env": "dev", "samples_group": "sturgeon", "feature": "local-dir", "tool": "nflaunch"}'
  $1