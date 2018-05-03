


## Use transpose main data,df_mapping, and df_programStage
getDataList <-  function(tr_main_data)   {
    main_list <-  map(tr_main_data, function(x) {
        instance <-
            list(
                instance_attribute = list(orgunit = as.character(x[["orgunitsId"]]),
                                          enrollmentdate = x[["DateFrm"]]),
                attributes = list(),
                ProgramStages = list()
            )

        tr_mapping_attr <- df_mapping %>%
            filter(tracker_type == "Attribute") %>%
            select(VariableName, Id) %>%
            transpose()

        instance[["attributes"]] <-
            map(tr_mapping_attr, function(y) {
                var_name <- y[["VariableName"]]
                attribute <-
                    list(id = y[["Id"]],
                         value = x[[var_name]],
                         name = y[["VariableName"]])

            })

        tr_programStage <- df_programStages %>%
            filter(
                name %in% c(
                    "QUESTIONNAIRE DESTINÉ AU PATIENT",
                    "RESULTAT POUR SELLES",
                    "RESULTAT POUR SERUM",
                    "RESULTAT POUR SECRETIONS OROPHARYNGEES OU NASOPHARYNGEES"
                )
            ) %>%
            select(name, Id) %>%
            transpose()

        instance[["ProgramStages"]] <-
            map(tr_programStage, function(v) {
                ProgramStage <- list(
                    program_stage_attribute =
                        list(id = v[["Id"]], name = v[["name"]]),
                    events =
                        list(attrs = list(), dataValues = list())
                )


                stageId <- v[["Id"]]
                # create stage data elements
                tr_mapping_dataElement <- df_mapping %>%
                    filter(tracker_type == "dataElement",
                           programStage == stageId) %>%
                    select(VariableName, Id) %>%
                    transpose()

                ProgramStage[["events"]][["attrs"]] <-
                    list(
                        program = presePiId,
                        orgunit = as.character(x[["orgunitsId"]]),
                        eventDate = x[["DateFrm"]]
                    )

                ProgramStage[["events"]][["dataValues"]] <-
                    map(tr_mapping_dataElement, function(s) {
                        dataElment_name <- s[["VariableName"]]
                        dataValue <-
                            list(id = s[["Id"]],
                                 value = x[[dataElment_name]],
                                 name = s[["VariableName"]])

                    })

                ProgramStage
            })

        instance


    })
}

