

addEvent <- function(payload) {
    url_event <- "http://209.61.231.45:8082/dhis/api/events"


    res <- POST(url = url_event,
                body = payload ,
                encode = "json")
    res <- content(res, mime = "application/json")


     if(res$status != "OK") {

        #is this a conflict
        if(res$httpStatus == "Conflict") {

         # we should return the current Id
         import_message <- res$response[["importSummaries"]][[1]]$description

          stop("Conflict while adding Event.",import_message)

        }
        # return error adding failed
        stop("Adding Event.",res$message)
     }

    eventId <- res$response$importSummaries[[1]]$reference

    return(eventId)
}
