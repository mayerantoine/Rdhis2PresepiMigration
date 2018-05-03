
getEnrollmentId <- function(tei,ou){

    url <- "http://209.61.231.45:8082/dhis/api/26/enrollments.json?"
    orgUnit <- paste0("ou=",ou)
    tei <- paste0("&trackedEntityInstance=",tei)

    url_get_id <- paste0(url,orgUnit,tei)
    res <- GET(url_get_id)
    res <- content(res, mime = "application/json")


    if( !(length(res$enrollments) > 0) ){
        stop("Failed to look up existing enrollment")
    }

    enroll_id <- res$enrollments[[1]]$enrollment
    return(enroll_id)
}
