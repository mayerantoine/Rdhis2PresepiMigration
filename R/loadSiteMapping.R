#' Import site mapping data
#'
#' This function import a text file with site name and site code in the legacy database , site name in dhis2
#' tracker
#'
#' @return the site mapping table df_site_mapping

loadSiteMapping <- function() {

    df_site_mapping <-
        as.data.frame(read_tsv( file = system.file("input/site_mapping.txt",
                                                   package = "Rdhis2PresepiMigration"), col_names = T),
                      stringsAsFactors = FALSE)
    df_site_mapping
}
