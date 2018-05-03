
enrollInProgram <- function(payload) {
    url_enrol <- "http://209.61.231.45:8082/dhis/api/enrollments"

    res <- POST(url = url_enrol,
                body = payload ,
                encode = "json")
    res <- content(res, mime = "application/json")

     if(res$status != "OK") {

        #is this a conflict
        if(res$httpStatus == "Conflict") {

         # we should return the current Id
         import_message <- res$response[["importSummaries"]][[1]]$description

         tei <- payload$trackedEntityInstance
         enroll_id <- try(getEnrollmentId(tei,payload$orgUnit), silent = TRUE)
         if(!is.error(enroll_id)) {

             ##update ?? No need to update
             return(enroll_id)
         }
          stop("Conflict enrolling entity in program.",import_message)

        }
        # return error adding failed
        stop("Enrolling in program failed.",res$message)
    }

    enrollId <- res$response$importSummaries[[1]]$reference
    return(enrollId)


}
