


getDataElement <- function() {

    dataelement_url <-
        "http://209.61.231.45:8082/dhis/api/dataElements.xml?fields=id,name,domainType,code&links=false&paging=false&filter=code:!eq:null"


    rootNode_data <- queryURL(dataelement_url)
    dataElements <- rootNode_data[["dataElements"]]

    dataElementId <- xmlSApply(dataElements, xmlGetAttr, "id")
    dataElementName <- xmlSApply(dataElements, xmlGetAttr, "name")
    dataElementCode <- xmlSApply(dataElements, xmlGetAttr, "code")

    tb_dataElement <-
        do.call(
            rbind,
            Map(
                data.frame,
                Id = dataElementId,
                name = dataElementName,
                code = dataElementCode
            )
        )

    return(tb_dataElement)
}
