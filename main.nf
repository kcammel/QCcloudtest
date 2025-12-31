#!/usr/bin/env nextflow

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    princessmaximacenter/nextflow_pipeline/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Bitbucket : https://bitbucket.org/princessmaximacenter/nextflow_pipeline/
----------------------------------------------------------------------------------------
*/


nextflow.enable.dsl=2


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT FUNCTIONS / MODULES / SUBWORKFLOWS / WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
include {QC_ANALYSIS} from "${projectDir}/workflows/qc/main.nf"
include {STURGEON} from "${projectDir}/workflows/sturgeon/main.nf"

include { paramsHelp } from 'plugin/nf-schema'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ORCHESTRATOR WORKFLOW FOR RUNNING SPECIFIED ANALYSIS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

//
// WORKFLOW: Run main analysis pipeline depending on specified profile
//


workflow  {


    switch (params.pipeline) {
        case 'qc':
            log.info "Starting QC Pipeline - Version: ${params.version}"
            QC_ANALYSIS()
            break
        case 'sturgeon':
            def input_ch = file(params.input, checkIfExists: true)
            log.info "Starting Sturgeon Pipeline - Version: ${params.version}"
            STURGEON(
                input_ch,
                params.outdir,
                params.barcode,
                params.model
            )
            break
        default:
            error "Unknown pipeline: '${params.pipeline}. Avalaible: qc, sturgeon"

    }

}


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/