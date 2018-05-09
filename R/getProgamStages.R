#' Download all program stages of the Presepi Program
#'
#'
#' @return the dataframe with program stages of the Presepi program df_programStage


getProgamStages <- function() {


    url <-
        "http://209.61.231.45:8082/dhis/api/programs/ybHHvBdo1ke.xml?fields=id,name,programTrackedEntityAttributes[id,name,code],organisationUnits[id,name],programStages[id,name]"

    rootNode <- queryURL(url)
    programStages <- rootNode[["programStages"]]

    #programStages
    ProgramStageId <- as.list(xmlSApply(programStages, xmlGetAttr, "id"))
    ProgramStageName <-
        as.list(xmlSApply(programStages, xmlGetAttr, "name"))
    df_programStage <-
        do.call(
            rbind,
            Map(
                data.frame,
                Id = ProgramStageId,
                name = ProgramStageName,
                stringsAsFactors = FALSE
            )
        )

      Encoding(df_programStage$name) <-"UTF-8"

      return(df_programStage)

}

