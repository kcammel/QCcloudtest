#!/usr/bin/env nextflow

////////////////////////////////////////////////////
/* --          CONFIG FILES                    -- */
////////////////////////////////////////////////////





/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    NanoQC
    Run simple QC tools on nanopore reads to get information and visualization on sequencing run
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { validateParameters; paramsSummaryLog; samplesheetToList; paramsSummaryMap } from 'plugin/nf-schema'
include { CRAMINO as CRAMINO_FULL } from '../../modules/local/cramino/main'
include { CRAMINO as CRAMINO_ADAPTIVE } from '../../modules/local/cramino/main'
include { NANOPLOT  as NANOPLOT_FULL } from '../../modules/local/nanoplot/main'
include { NANOPLOT as NANOPLOT_SEQSUM } from '../../modules/local/nanoplot/main'
include { NANOPLOT  as NANOPLOT_ADAPTIVE } from '../../modules/local/nanoplot/main'
include { MOSDEPTH } from '../../modules/nf-core/mosdepth/main'
include {CALCULATE_ENRICHMENT} from '../../modules/local/calculate_enrichment/main'

include { MULTIQC } from '../../modules/nf-core/multiqc/main'

include { paramsSummaryMultiqc } from '../../subworkflows/nf-core/utils_nfcore_pipeline'
include { softwareVersionsToYAML } from '../../subworkflows/nf-core/utils_nfcore_pipeline'
include { BAM_SPLIT_BY_REGION } from '../../subworkflows/nf-core/bam_split_by_region/main'



workflow QC_ANALYSIS {

    validateParameters()

    ch_versions = Channel.empty()
    ch_multiqc_files = Channel.empty()
    //Parse samplesheet 
    Channel.fromList(samplesheetToList(params.input, "assets/QC_samplesheet_schema.json"))
        .branch {meta, bam, bai, seq_sum, bed ->
            //If bed does not exist and no sequencing summary is provided
            STD_BAM: !bed && !seq_sum
                return [meta,bam, bai]
            //If bed is not provided, but sequencing summary is
            STD_SEQSUM: !bed && seq_sum
                return [meta,seq_sum]
            //If bed does exist
            ADPT: bed
                return [meta,bam,bai,bed]    
        }
        .set { ch_input }


    // QC workflow for all sequencing (full BAM)
    CRAMINO_FULL( ch_input.STD_BAM.mix( 
        ch_input.ADPT.map { meta, bam, bai, bed -> [meta, bam, bai] } 
    ) 
)
    ch_versions = ch_versions.mix(CRAMINO_FULL.out.versions)

    NANOPLOT_FULL(CRAMINO_FULL.out.arrow)
    ch_versions = ch_versions.mix(NANOPLOT_FULL.out.versions)
    ch_multiqc_files = ch_multiqc_files.mix(NANOPLOT_FULL.out.multiqc.collect())

    NANOPLOT_SEQSUM(ch_input.STD_SEQSUM)
    ch_versions = ch_versions.mix(NANOPLOT_SEQSUM.out.versions)
    ch_multiqc_files = ch_multiqc_files.mix(NANOPLOT_SEQSUM.out.multiqc.collect())

    // Additional workflow for adaptive sampling

    MOSDEPTH(ch_input.ADPT)
    //Mosdepth calculate enrichment and make multiqc yaml

    //Calculation and sample name needs to be dynamic
    //Mosdepth to multiqc

    ch_mosdepth_for_multiqc = Channel.empty()
        .mix(MOSDEPTH.out.global_txt, MOSDEPTH.out.summary_txt, MOSDEPTH.out.regions_txt)
        .map { meta, file -> file }
    ch_multiqc_files = ch_multiqc_files.mix(ch_mosdepth_for_multiqc.collect())

    CALCULATE_ENRICHMENT(MOSDEPTH.out.summary_txt)
    ch_multiqc_files = ch_multiqc_files.mix(CALCULATE_ENRICHMENT.out.multiqc.collect())
    

    ch_adaptive_bam = ch_input.ADPT
        .map{
            meta, bam, bai, regions_file ->
            [meta, file(bam), file(bai), file(regions_file)]
        }
    BAM_SPLIT_BY_REGION(ch_adaptive_bam)

    CRAMINO_ADAPTIVE(BAM_SPLIT_BY_REGION.out.bam_bai)
    ch_versions = ch_versions.mix(CRAMINO_ADAPTIVE.out.versions)

    NANOPLOT_ADAPTIVE(CRAMINO_ADAPTIVE.out.arrow)
    ch_versions = ch_versions.mix(NANOPLOT_ADAPTIVE.out.versions)
    ch_multiqc_files = ch_multiqc_files.mix(NANOPLOT_ADAPTIVE.out.multiqc.collect())


    // Collate and save software versions
    //
    softwareVersionsToYAML(ch_versions)
        .collectFile(storeDir: "${params.outdir}/pipeline_info", name: 'maxima_nanopore_qc_software_mqc_versions.yml', sort: true, newLine: true)
        .set { ch_collated_versions }
    
    // Prepare the workflow summary
    ch_workflow_summary = Channel.value(
        paramsSummaryMultiqc(
            paramsSummaryMap(workflow, parameters_schema: "nextflow_schema.json")
        )
    ).collectFile(name: 'workflow_summary_mqc.yaml')

    ch_multiqc_files = ch_multiqc_files
        .mix(ch_workflow_summary)
        .mix(ch_collated_versions)

    ch_multiqc_files.view()
    MULTIQC (
        ch_multiqc_files.collect(),
        [],
        [],
        [],
        [],
        []
    )


}


