
loadSiteMapping <- function() {
    # facility maping : The file contains site name and site code in the legacy database , site name in dhis2 tracker
    df_site_mapping <-
        as.data.frame(read_tsv( file = system.file("input/site_mapping.txt",
                                                   package = "Rdhis2PresepiMigration"), col_names = T),
                      stringsAsFactors = FALSE)
    df_site_mapping
}
