////////////////////////////////////////////////////
/* --    IMPORT LOCAL MODULES/SUBWORKFLOWS     -- */
////////////////////////////////////////////////////

include { sturgeon } from '../modules/sturgeon'

workflow STURGEON{
    
    take:
    
    bam_input_directory
    output_dir_name
    barcode
    model

    main:
    sturgeon_metadata = Channel.empty()

    sturgeon(
        bam_input_directory,
        output_dir_name,
        barcode,
        model
    )
     

}