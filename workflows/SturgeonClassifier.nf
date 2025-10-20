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
    //Zou ik gewoon ook die lock en shutdown geven en dan als standaard params doen? Dan kan je aanpassen als je wil

    main:
    sturgeon_metadata = Channel.empty

    sturgeon(
        bam_input_directory,
        output_dir_name,
        barcode,
        model
    )
     

}