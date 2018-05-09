#' Download the Presepi Program Id
#'
#'
#'
#' @return DHIS2 Id for the Presepi Program
getProgramId <- function() {

    url_program <-
        "http://209.61.231.45:8082/dhis/api/programs.xml?fields=id,name&links=false&paging=false"
        root_id <- queryURL(url_program)

    programId <- xmlSApply(root_id[["programs"]], xmlGetAttr, "id")
    programName <- xmlSApply(root_id[["programs"]], xmlGetAttr, "name")
    df_program <-
        do.call(rbind, Map(data.frame, Id = programId, name = programName))

    PresePiId <- as.character(programId[[3]])


}
