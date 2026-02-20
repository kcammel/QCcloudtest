process sturgeon {
    label 'sturgeon_classifier'
    label 'high_resource'
    //Docker container is currently changed to random public, as sturgeon is not public at the moment
    //container 'kcammel/sturgeon:v2.1.0' //Make this dynamic? 
    container 'hello-world:latest'
    containerOptions "--entrypoint /usr/bin/env -u 0:0 "


    input:
    path(input)
    val(outdir)
    val(barcode)
    path(model)

    output:
    path("mock_run.txt"), emit: main_output
    //path("${outdir}/*"), emit: main_output
    
    script:
    """
    echo "This would run the following command:" > mock_run.txt
    echo "SturgeonLivePrediction \\
    --input ${input} \\
    --output ${outdir} \\
    --barcode ${barcode} \\
    --model ${model} \\
    --live_run False" >> mock_run.txt

    """
}