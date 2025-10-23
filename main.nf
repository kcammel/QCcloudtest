//#!/usr/bin/env nextflow

nextflow.enable.dsl=2


include { validateParameters; paramsSummaryLog; samplesheetToList } from 'plugin/nf-schema'
include { STURGEON } from './workflows/SturgeonClassifier'

workflow {
    validateParameters()
    STURGEON(params.input, params.outdir, params.barcode,params.model)

}
