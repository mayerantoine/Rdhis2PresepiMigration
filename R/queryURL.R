

queryURL <- function(urlstring){

    url_id <- urlstring

    uid <- Sys.getenv("uid")
    pwd <- Sys.getenv("pwd")
    userpwd <- paste(uid,pwd,sep = ":")
    entity_response <-
        getURL(
            url_id,
            userpwd = userpwd,
            httpauth = 1L,
            header = FALSE,
            ssl.verifypeer = FALSE,
            encoding = "utf-8"
        )

    if(is.null(entity_response)){

        stop("Cannot connect")

    }
    doc_id <- xmlTreeParse(entity_response, useInternalNodes = T)
    root_id <- xmlRoot(doc_id)

}
