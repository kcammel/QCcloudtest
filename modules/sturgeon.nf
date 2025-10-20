process sturgeon {
    label 'sturgeon_classifier'
    container 'kcammel/development_gcp:v0.0.1'
    containerOptions "--entrypoint /usr/bin/env -u 0:0 "


    //Lock file is not getting removed (you also don't really need it for the GCP anyway...)
    // Need to make sure that the output directory becomes a val or params, so it does not get mounted or anything but can be set dynamically

    input:
    path(input)
    path(outdir)
    path(barcode)
    path(model)

    output:
    path("${outdir}/*"), emit: predictions
    path("sturgeon_output.log"), emit: log

    script:
    """
    SturgeonLivePrediction \
    --input ${input} \
    --output "${outdir}" \
    --lock ${params.lock} \
    --barcode 05 \
    --model ${model} \
    -sf ${params.shutdown_file} > sturgeon_output.log 2>&1
    """
}