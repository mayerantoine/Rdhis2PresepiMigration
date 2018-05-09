#' Download the Tracked Entity Id
#'
#'
#'
#' @return DHIS2 Id for the tracked Entity
getTrackedEntity <- function() {

    url_id <-
        "http://209.61.231.45:8082/dhis/api/trackedEntities.xml?fields=id,name&links=false&paging=false"


    root_id <- queryURL(url_id)

    trackedEntitiesId <-
        xmlSApply(root_id[["trackedEntities"]], xmlGetAttr, "id")
    trackedEntitiesName <-
        xmlSApply(root_id[["trackedEntities"]], xmlGetAttr, "name")

    trackedEntity <- trackedEntitiesId[[1]]
}
