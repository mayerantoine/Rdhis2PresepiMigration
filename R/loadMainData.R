

loadMainData <- function() {
    # main_data table
    df_main_data <-
        read_tsv(file = system.file("input/main_data_final.txt",
                                    package = "Rdhis2PresepiMigration"), col_names = T)

    df_main_completed <-
        read_tsv( file = system.file("input/main_completed.txt",
                                     package = "Rdhis2PresepiMigration"), col_names = T)

    df_main_vaccinal <-
        read_tsv( file = system.file("input/main_status_vaccinal.txt",
                                     package = "Rdhis2PresepiMigration"), col_names = T)


    df_main_completed$PTID <- toupper(df_main_completed$PTID)

    df_main_vaccinal$PTID <- toupper(df_main_vaccinal$PTID)


    df_main_completed <- df_main_completed %>%
        select(-DateAj, -DateFrm, -DOB, -DeptVive, -AbxDiar)

    df_main_vaccinal <- df_main_vaccinal %>%
        select(
            -DateAj,
            -DateFrm,
            -VD1rota,
            -VacPEV,
            -VD3rota,
            -VacRota,-VD2rota,
            -VsrcRota,
            -VacChol,
            -VNDChol,
            -VD1Chol,
            -VNDrota,-VD2Chol,
            -VD3Chol,
            -VsrcChol,-VacMeng,
            -VNDMeng,
            -VD1Meng,
            -VD2Meng,
            -VD3Meng,
            -VsrcMeng,-VacPent,
            -VNDPent,
            -VD1Pent,
            -VD2Pent,
            -VD3Pent,
            -VsrcPent,
            -VacCopie
        )

    df_main_data <-
        df_main_data %>% left_join(df_main_completed, by = c("PTID" = "PTID"))

    df_main_data <-
        df_main_data %>% left_join(df_main_vaccinal, by = c("PTID" = "PTID"))

    # cleaning
    df_main_data <-

        df_main_data %>%
        # remove site with no code
        filter(!is.na(SiteCode)) %>%

        # remove DateFrm NA
        filter(!is.na(DateFrm)) %>%

        # include presepi dhis2 site name
        left_join(df_site_mapping, by = c("SiteCode" = "SiteCode")) %>%

        #include presepi dhis2 siteId
        left_join(df_orgunits, by = c("site_dhis2" = "name")) %>%

        ## year and Date
        mutate(
            new_DateFrm = mdy(DateFrm),
            year_case = year(new_DateFrm),
            month_case = month(new_DateFrm)
        ) %>%

        ## AntibioticAdmin
        mutate(AntibioticAdmin = if_else(Doxy == -1, 1,
                                         if_else(
                                             Azithrom == -1, 1,
                                             if_else(Erythrom == -1, 1,
                                                     if_else(
                                                         Tetracyc == -1, 1,
                                                         if_else(Amox == -1, 1,
                                                                 if_else(
                                                                     Cipro == -1, 1,
                                                                     if_else(TmpSmx == -1, 1, 0)
                                                                 ))
                                                     ))
                                         ))) %>%


        ## EtatdesSelles
        mutate(EtatdesSelles = if_else(DiarAqus != 0, 1,
                                       if_else(
                                           DiarSang !=  0, 1,
                                           if_else(DiarGlar != 0, 1,
                                                   if_else(DiarAcun != 0, 1, 0))
                                       ))) %>%

        #PlanTraitHydratation
        mutate(PlanTraitHydratation = if_else(is.na(PlanTrait), 0, 1)) %>%
        #PlanA
        mutate(PlanA = if_else(PlanTrait == 0, 1, 0)) %>%
        #PlanB
        mutate(PlanB = if_else(PlanTrait == 1, 1, 0)) %>%
        #PlanC
        mutate(PlanC = if_else(PlanTrait == 2, 1, 0)) %>%
        #syndromeDiar
        mutate(SyndDiar = if_else(Syndrome == 1 ||
                                      SyndDiar == -1, 1, 0)) %>%
        #syndromeFeb
        mutate(SyndFebrile = if_else(Syndrome == 2 ||
                                         SyndFebrile == -1, 1, 0)) %>%
        #syndromeInfRes
        mutate(SyndInfResp = if_else(Syndrome == 3 ||
                                         SyndInfResp == -1, 1, 0))



    return(df_main_data)
    # main data complement table
    # meningitis table ?? for meningitis will do a different script

}
