

loadJsonData <- function() {
    jsonData <- read_json("processed_data/output/HSD_2017_9.json")

    map(jsonData,  function(x) {
        orgunit <- x$instance_attribute$orgunit[[1]]
        enroll_date <-  x$instance_attribute$enrollmentdate[[1]]

        attributes <- map(x$attributes, function(atr) {
            list(attribute = atr$id[[1]] ,
                 value =  atr$value[[1]])
        })



        ## TrackedEntity Instances payload
        payload <- list(
            trackedEntity = "MCPQUTHX1Ze",
            orgUnit = orgunit,
            attributes = attributes
        )



        ## add TrackedEntity Instances
        ## use try or trycatch
        tei <-
            try(addTrackedEntityInstance(payload = payload), silent = TRUE)

        # If error add tracked entity instance not do anything
        if (!is.error(Id)) {
            ## enrollement payload
            enroll_load <- list(
                trackedEntityInstance  = tei,
                orgUnit = orgunit,
                program = "ybHHvBdo1ke",
                enrollmentDate = enroll_date,
                incidentDate = enroll_date
            )

            enroll_id <-
                try(enrollInProgram(enroll_load), silent = TRUE)


            if (!is.error(enroll_id)) {
                # Program Stages and event
                events_res <-  map(x$ProgramStages, function(stage) {
                    dataValues <- stage$events$dataValues
                    events <- map(dataValues, function(val) {
                        list(dataElement = val$id[[1]],
                             value = val$value[[1]])

                    })

                    programStage <- stage$program_stage_attribute$id[[1]]

                    event <- list(
                        program = "ybHHvBdo1ke",
                        orgUnit = orgunit,
                        eventDate =  enroll_date,
                        status = "COMPLETED",
                        storedBy = "mantoine",
                        enrollment = enroll_id,
                        programStage = programStage,
                        trackedEntityInstance =  tei,
                        dataValues = events
                    )


                    ## add event
                    addEvent(event)
                })

            }


        }



    })
}

