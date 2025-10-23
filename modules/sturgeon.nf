process sturgeon {
    label 'sturgeon_classifier'
    container 'kcammel/development_gcp:v0.0.1'
    containerOptions "--entrypoint /usr/bin/env -u 0:0 "


    input:
    path(input)
    val(outdir)
    val(barcode)
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
    -sf "${params.shutdown_file}" > "${outdir}/sturgeon_output.log" 2>&1 &

    #Logic below is to currently handle shutdown for a nextflow/cloud run
    STURGEON_PID=\$!

    sleep 5

    sleep ${params.sturgeon_timeout ?: 40}

    touch "${params.shutdown_file}"

    timeout 3000 bash -c "while kill -0 \$STURGEON_PID 2>/dev/null; do sleep 1; done" || true

    wait \$STURGEON_PID 2>/dev/null || true
    """
}