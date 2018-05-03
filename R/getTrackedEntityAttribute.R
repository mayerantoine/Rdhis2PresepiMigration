
getTrackedEntityAttribute <- function(){
        url <-
        "http://209.61.231.45:8082/dhis/api/programs/ybHHvBdo1ke.xml?fields=id,name,programTrackedEntityAttributes,organisationUnits[id,name],programStages[id,name]"



    rootNode <- queryURL(url)
    programTrackedEntityAttribute <- rootNode[["programTrackedEntityAttributes"]]

    xmlChildren(programTrackedEntityAttribute[[1]])$trackedEntityAttribute
    map(xmlChildren(programTrackedEntityAttribute), function(x){

            child <- xmlChildren(x)[["trackedEntityAttribute"]]

            trId <- xmlGetAttr(child,"id")
        })


        #programTrackedEntity
    TrackedEntityAttributeId <-
        map(xmlChildren(programTrackedEntityAttribute), function(x){

            child <- xmlChildren(x)[["trackedEntityAttribute"]]

            trId <- xmlGetAttr(child,"id")
        })
    programTrackedEntityAttributeName <-
        as.list(xmlSApply(programTrackedEntityAttribute, xmlGetAttr, "name"))

    df_TrackedEntityAttribute <-
        do.call(
            rbind,
            Map(
                data.frame,
                Id = TrackedEntityAttributeId,
                name = programTrackedEntityAttributeName,
                stringsAsFactors = FALSE
            )
        )


    return(df_TrackedEntityAttribute)


}
