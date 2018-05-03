
getVariableMapping <- function() {
    # variables mapping table
    # This is the most important input for the data generation process, match presepi variable names, dhis names
    df_mapping <-
        read_csv("./data/presepi_mapping_v3.csv", col_names = T)

    ## clean the mapping ---------------------------------------------------------------------------

    # removing NA values and any trailing spaces at the end of dataelements
    # this exclude presepi variable that are not mapped in dhis2 those data will not be transfered
    # This clean the mapping keeping only variables in presepi that we can find in the data load
    # check and allow us to double check if the mapping file is in sync whith the data imported because
    # the mapping file was not done from the main_data file

    df_mapping <-  df_mapping %>%

        #trim data removing any trailing spaces at the end of dataelements
        mutate(dataelement = trimws(dataelement, which = c("right"))) %>%

        #exclude presepi variable that are not mapped in dhis2 those data will not be transfered
        filter(!is.na(code)) %>%

        #keeping only variables in presepi that we can find in the main data
        filter(VariableName %in% names(df_main_data)) %>%

        # adding dataelement Ids in the mapping dataframe
        left_join(df_metadata, by = c("dataelement" = "name")) %>%

        #exclude presepi variable that are not mapped??? remove element with no code
        filter(!is.na(Id)) %>%

        # add ProgramStageId in the mapping dataframe, indicates the stage  for each dataelement
        left_join(df_programStageDataElement, by = c("Id" = "dataElement")) %>%

        # convert to dataframe
        as.data.frame(stringsAsFactors = FALSE)



}
