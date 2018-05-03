
## Get a programStage -------------------------------------------------------
# http://209.61.231.45:8082/dhis/api/programStages/Li8CKAWWS1q
# mapping each programStage with his dataelement


getPresePiProgramStage <- function(ProgramStageId) {

    base_url <- "http://209.61.231.45:8082/dhis/api/programStages/"
    #http://209.61.231.45:8082/dhis/api/programStages/Li8CKAWWS1q.json?fields=id,name,programStageDataElements[id]

    #how does map work, map_df, do.call vs lapply
    # how to return a dataframe

    programStageDataElements_list <- map(ProgramStageId, function(x) {
        stage <- x
        url_stage <- paste0(base_url, stage, ".xml")

        rootNodeStage <- queryURL(url_stage)
        programStageDataElements <-
            rootNodeStage[["programStageDataElements"]]

        if( !is.null(programStageDataElements)) {

        dataElementId <- as.list(xmlSApply(programStageDataElements,
                                           function(x) {
                                               xmlGetAttr(x[["dataElement"]], "id")
                                           }))

          s <- list(programStage = stage, dataElement = dataElementId)
        as.data.frame(do.call(rbind, lapply(s$dataElement, cbind, s$programStage)))
        }


    })


    df_programStageDataElement <-
        as.data.frame(do.call(rbind, programStageDataElements_list))
    names(df_programStageDataElement) <- c("dataElement", "programStage")



    df_programStageDataElement

}
