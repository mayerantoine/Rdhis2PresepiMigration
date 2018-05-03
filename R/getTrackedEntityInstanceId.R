

getTrackedEntityInstanceId <- function(patientId,ou){

    url <- "http://209.61.231.45:8082/dhis/api/26/trackedEntityInstances.json?filter=RTIdYLyRN3M"
    patientId <- paste0(":EQ:",patientId)
    orgUnit <- paste0("&ou=",ou)

    url_get_id <- paste0(url,patientId,orgUnit)
    res <- GET(url_get_id)
    res <- content(res, mime = "application/json")

    if( !(length(res$trackedEntityInstance) > 0) ){
        stop("Failed to look up existing tracked entity instance")
    }


    tei <- res$trackedEntityInstances[[1]]$trackedEntityInstance
    return(tei)

}
