process NanoPlot {
    label 'NanoPlot'

    conda "/hpc/pmc_gen/kcammel/nextflow/nanoQC/work/conda/env-d9778174fe96c820758aed8719c6e200"



    input:
    tuple val(samplename), path(arrow)

    output:
    tuple val(samplename), path("*.png"), emit: plots
    tuple val(samplename), path("*NanoStats.txt"), emit: stats
    path "versions.yml"             , emit: versions
    
    script:

    """
    NanoPlot \\
        --threads 2 \\
        --arrow ${samplename}.arrow \\
        --prefix "${samplename}_" \\
        --plots hex dot kde \\
        --tsv_stats

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        NanoPlot: \$(echo \$(NanoPlot -v) | sed 's/NanoPlot //' )
    END_VERSIONS

    """ 
}
