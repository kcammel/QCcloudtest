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
    input
    outdir
    barcode
    model

    main:

    validateParameters() 
    ch_versions = Channel.empty()

    sturgeon(
        input,
        outdir,
        barcode,
        model
    )

    // ──────────────────────────────────────────────────────────────────────
    // Collate and save software versions
    // UNDER DEVELOPMENT
    // ──────────────────────────────────────────────────────────────────────

    //ch_versions = ch_versions.mix(sturgeon.out.versions)

}