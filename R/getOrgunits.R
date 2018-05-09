#' Download all orgunits of the Presepi Program
#'
#'
#' @return the dataframe with orgunits of the Presepi program df_orgunits

getOrgunits <- function(){

        url <-
        "http://209.61.231.45:8082/dhis/api/programs/ybHHvBdo1ke.xml?fields=id,name,programTrackedEntityAttributes[id,name,code],organisationUnits[id,name],programStages[id,name]"

    rootNode <- queryURL(url)
    orgunits <- rootNode[["organisationUnits"]]


    #orgunits
    orgunitsId <- as.list(xmlSApply(orgunits, xmlGetAttr, "id"))
    orgunitsName <- as.list(xmlSApply(orgunits, xmlGetAttr, "name"))
    df_orgunits <-
        do.call(rbind,
                Map(
                    data.frame,
                    orgunitsId = orgunitsId,
                    name = orgunitsName,
                    stringsAsFactors = FALSE
                ))

    Encoding(df_orgunits$name) <- "UTF-8"

    return(df_orgunits)


}
