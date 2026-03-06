// Calculate enrichment of mosdepth coverage for adaptive sampling

process CALCULATE_ENRICHMENT {
    tag "${meta.sample_id}"
    label 'process_low'

    input:
    tuple val(meta), path(summary_txt)

    output:
    path "*.yaml", emit: multiqc

    script:
    """
    # Step 1: Calculate the enrichment from the mosdepth summary file
    enrichment=\$(awk -v target="total_region" -v bg="total" '
    NR==1 {
                for (i=1; i<=NF; i++) {
                    if (\$i == "mean") {
                        mean_col = i
                        break
                    }
                }
            }
            
            # 2. Process Data Lines using the dynamic column index
            # We check if mean_col was found to avoid errors
            mean_col > 0 && \$1 == bg     { background = \$mean_col }
            mean_col > 0 && \$1 == target { target_depth = \$mean_col }

            # 3. Calculate Final Ratio
            END { 
                if (background > 0) print target_depth / background;
                else print 0; 
            }
        ' ${summary_txt})

     # Step 2: Create custom MultiQC YAML file.   
     cat <<EOF > ${meta.sample_id}_enrichment_mqc.yaml
    id: 'Enrichment target regions'
    plot_type: "generalstats"
    pconfig:
       - enrichment_score:
           title: 'Enrichment Targeted Regions Adaptive Sampling'
           namespace: 'Mosdepth'
           description: 'Fold enrichment of target region mean depth compared to total mean depth'
           suffix: 'x'
           format: '{:,.2f}'
           scale: 'RdYlGn'
    data:
        ${meta.sample_id}_adaptive:
            enrichment_score: \${enrichment}
    EOF
    """
}