

# POST trackedEntityInstances
# Return Instances Id if success and error if not
addTrackedEntityInstance <- function(payload) {
    url <- "http://209.61.231.45:8082/dhis/api/trackedEntityInstances"
    #payload <- data[[1]]

    res <- POST(url = url,
                body = body ,
                encode = "json")
    res <- content(res, mime = "application/json")

    if(res$status != "OK") {

        #is this a conflict
        if(res$httpStatus == "Conflict") {

         # we should return the current Id
         import_message <- res$response[["importSummaries"]][[1]]$conflicts[[1]]$value
         patientId <- payload$attributes[[3]]$value
         tei <- try(getTrackedEntityInstanceId(patientId,payload$orgUnit), silent = TRUE)

         if(!is.error(tei)) {
            ## we could update
            return(tei)
         }


          stop("Conflict while adding Tracked entity.",import_message)

        }
        # return error adding failed
        stop("Adding Tracked entity failed.",res$message)
    }

    tei <- res$response$importSummaries[[1]]$reference
    return(tei)

}
