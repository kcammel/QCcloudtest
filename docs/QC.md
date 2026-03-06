# Princess Máxima Center Nanopore Nextflow QC pipeline
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
PMBBM000AAA,tumor,,/path/to/input.bam,/path/to/input.bam,bai
PMBBM000BBB,tumor,,,/path/to/sequencing_summary.txt
PMBBM000CCC,tumor,/path/to/adaptive_sampling.bed,/path/to/input.bam,/path/to/input.bam.bai
```


**Example QC command:**
```bash
nextflow run princessmaximacenter/nextflow_pipeline/main.nf \
-profile qc,docker \
--input samplesheet.csv \
--outdir QC_results
```

### Output structure 

Output structure for following samplesheet:
```csv
sample_id,status,adaptive,bam,bai,seq_sum
PMBBM000AAA,tumor,/path/to/adaptive_sampling.bed,/path/to/input.bam,/path/to/input.bam,bai
```

```
QC_results
├── cramino
│   └── PMBBM000AAA
│       ├── PMBBM000AAA.arrow
│       ├── PMBBM000AAA_adaptive.arrow
│       ├── PMBBM000AAA_adaptive_cramino.txt
│       └── PMBBM000AAA_cramino.txt
├── mosdepth
│   └── PMBBM000AAA
│       ├── PMBBM000AAA_adaptive.mosdepth.global.dist.txt
│       ├── PMBBM000AAA_adaptive.mosdepth.region.dist.txt
│       ├── PMBBM000AAA_adaptive.mosdepth.summary.txt
│       ├── PMBBM000AAA_adaptive.per-base.bed.gz
│       ├── PMBBM000AAA_adaptive.per-base.bed.gz.csi
│       ├── PMBBM000AAA_adaptive.regions.bed.gz
│       ├── PMBBM000AAA_adaptive.regions.bed.gz.csi
│       └── PMBBM000AAA_enrichment_mqc.yaml
├── multiqc
│   ├── multiqc_report.html
│   └── multiqc_report_data
│       ├── llms-full.txt
│       ├── mosdepth-coverage-per-contig-single.txt
│       ├── mosdepth-cumcoverage-dist-id.txt
│       ├── mosdepth_cov_dist.txt
│       ├── mosdepth_cumcov_dist.txt
│       ├── mosdepth_perchrom.txt
│       ├── multiqc.log
│       ├── multiqc.parquet
│       ├── multiqc_citations.txt
│       ├── multiqc_data.json
│       ├── multiqc_general_stats.txt
│       ├── multiqc_nanostat.txt
│       ├── multiqc_software_versions.txt
│       ├── multiqc_sources.txt
│       └── nanostat_fasta_stats_table.txt
├── nanoplot
│   └── PMBBM000AAA
│       ├── PMBBM000AAA_NanoPlot-report.html
│       ├── PMBBM000AAA_NanoStats.txt
│       ├── PMBBM000AAA_Non_weightedHistogramReadlength.html
│       ├── PMBBM000AAA_Non_weightedLogTransformed_HistogramReadlength.html
│       ├── PMBBM000AAA_PercentIdentityHistogramDynamic_Histogram_percent_identity.html
│       ├── PMBBM000AAA_PercentIdentityvsAlignedReadLength_dot.html
│       ├── PMBBM000AAA_PercentIdentityvsAlignedReadLength_kde.html
│       ├── PMBBM000AAA_WeightedHistogramReadlength.html
│       ├── PMBBM000AAA_WeightedLogTransformed_HistogramReadlength.html
│       ├── PMBBM000AAA_Yield_By_Length.html
│       ├── PMBBM000AAA_adaptive_NanoPlot-report.html
│       ├── PMBBM000AAA_adaptive_NanoStats.txt
│       ├── PMBBM000AAA_adaptive_Non_weightedHistogramReadlength.html
│       ├── PMBBM000AAA_adaptive_Non_weightedLogTransformed_HistogramReadlength.html
│       ├── PMBBM000AAA_adaptive_PercentIdentityHistogramDynamic_Histogram_percent_identity.html
│       ├── PMBBM000AAA_adaptive_PercentIdentityvsAlignedReadLength_dot.html
│       ├── PMBBM000AAA_adaptive_PercentIdentityvsAlignedReadLength_kde.html
│       ├── PMBBM000AAA_adaptive_WeightedHistogramReadlength.html
│       ├── PMBBM000AAA_adaptive_WeightedLogTransformed_HistogramReadlength.html
│       └── PMBBM000AAA_adaptive_Yield_By_Length.html
├── pipeline_info
│   ├── execution_report_yyyy-mm-dd_hh-mm-ss.html
│   ├── execution_timeline_yyyy-mm-dd_hh-mm-ss.html
│   ├── execution_trace_yyyy-mm-dd_hh-mm-ss.txt
│   ├── maxima_nanopore_qc_software_mqc_versions.yml
│   └── pipeline_dag_yyyy-mm-dd_hh-mm-ss.html
└── samtools
    └── PMBBM000AAA
        ├── PMBBM000AAA_{target_region}:{start-end}.bam
        └── PMBBM000AAA_{target_region}:{start-end}.bam.bai
```