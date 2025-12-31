/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT MODULES / SUBWORKFLOWS / FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { sturgeon } from '../../modules/sturgeon'
include { validateParameters; paramsSummaryLog; samplesheetToList } from 'plugin/nf-schema'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow STURGEON{
    
    take:
    bam_input_directory
    output_directory
    barcode
    model

    main:

    validateParameters() 
    ch_versions = Channel.empty()

    sturgeon(
        bam_input_directory,
        output_directory,
        barcode,
        model
    )

    // ──────────────────────────────────────────────────────────────────────
    // Collate and save software versions
    // UNDER DEVELOPMENT
    // ──────────────────────────────────────────────────────────────────────

    //ch_versions = ch_versions.mix(sturgeon.out.versions)

}