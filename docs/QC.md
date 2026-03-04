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
PMBMABCD01,tumor,,/path/to/input.bam,/path/to/input.bam,bai
PMBMEFGH02,tumor,,,/path/to/sequencing_summary.txt
PMBMEFGH06,tumor,/path/to/adaptive_sampling.bed,/path/to/input.bam,/path/to/input.bam.bai
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
PMBMABCD01,tumor,/path/to/adaptive_sampling.bed,/path/to/input.bam,/path/to/input.bam,bai
```

```
QC_results
├── cramino
│   └── PMBMABCD01
│       ├── PMBMABCD01.arrow
│       ├── PMBMABCD01_adaptive.arrow
│       ├── PMBMABCD01_adaptive_cramino.txt
│       └── PMBMABCD01_cramino.txt
├── mosdepth
│   └── PMBMABCD01
│       ├── PMBMABCD01_adaptive.mosdepth.global.dist.txt
│       ├── PMBMABCD01_adaptive.mosdepth.region.dist.txt
│       ├── PMBMABCD01_adaptive.mosdepth.summary.txt
│       ├── PMBMABCD01_adaptive.per-base.bed.gz
│       ├── PMBMABCD01_adaptive.per-base.bed.gz.csi
│       ├── PMBMABCD01_adaptive.regions.bed.gz
│       ├── PMBMABCD01_adaptive.regions.bed.gz.csi
│       └── PMBMABCD01_enrichment_mqc.yaml
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
│   └── PMBMABCD01
│       ├── PMBMABCD01_NanoPlot-report.html
│       ├── PMBMABCD01_NanoStats.txt
│       ├── PMBMABCD01_Non_weightedHistogramReadlength.html
│       ├── PMBMABCD01_Non_weightedLogTransformed_HistogramReadlength.html
│       ├── PMBMABCD01_PercentIdentityHistogramDynamic_Histogram_percent_identity.html
│       ├── PMBMABCD01_PercentIdentityvsAlignedReadLength_dot.html
│       ├── PMBMABCD01_PercentIdentityvsAlignedReadLength_kde.html
│       ├── PMBMABCD01_WeightedHistogramReadlength.html
│       ├── PMBMABCD01_WeightedLogTransformed_HistogramReadlength.html
│       ├── PMBMABCD01_Yield_By_Length.html
│       ├── PMBMABCD01_adaptive_NanoPlot-report.html
│       ├── PMBMABCD01_adaptive_NanoStats.txt
│       ├── PMBMABCD01_adaptive_Non_weightedHistogramReadlength.html
│       ├── PMBMABCD01_adaptive_Non_weightedLogTransformed_HistogramReadlength.html
│       ├── PMBMABCD01_adaptive_PercentIdentityHistogramDynamic_Histogram_percent_identity.html
│       ├── PMBMABCD01_adaptive_PercentIdentityvsAlignedReadLength_dot.html
│       ├── PMBMABCD01_adaptive_PercentIdentityvsAlignedReadLength_kde.html
│       ├── PMBMABCD01_adaptive_WeightedHistogramReadlength.html
│       ├── PMBMABCD01_adaptive_WeightedLogTransformed_HistogramReadlength.html
│       └── PMBMABCD01_adaptive_Yield_By_Length.html
├── pipeline_info
│   ├── execution_report_yyyy-mm-dd_hh-mm-ss.html
│   ├── execution_timeline_yyyy-mm-dd_hh-mm-ss.html
│   ├── execution_trace_yyyy-mm-dd_hh-mm-ss.txt
│   ├── maxima_nanopore_qc_software_mqc_versions.yml
│   └── pipeline_dag_yyyy-mm-dd_hh-mm-ss.html
└── samtools
    └── PMBMABCD01
        ├── PMBMABCD01_{target_region}:{start-end}.bam
        └── PMBMABCD01_{target_region}:{start-end}.bam.bai
```