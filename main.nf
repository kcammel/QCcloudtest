//#!/usr/bin/env nextflow

nextflow.enable.dsl=2


include { validateParameters; paramsSummaryLog; samplesheetToList } from 'plugin/nf-schema'
include { STURGEON } from './workflows/SturgeonClassifier'

workflow {
    validateParameters()
    //Moet die nextflow_schema.json maken en dan even nadenken over hoe alle parameters er precies uit komen te zien
    model = "/Users/k.v.cammel/Developer/public_repos/sturgeon/sturgeon/include/models/general.zip"
    input = "gs://pmc-bdc-dev-nextflow-results/sturgeon_dev/raw_data/20250819_0924_P2I-00332-A_PBE94195_a524b9c1/"
    output = "sturgeon_classifier_"
    barcode = 5
    //Moet de input parameters er netjes in zetten
    STURGEON(input, output,barcode,model)

}
