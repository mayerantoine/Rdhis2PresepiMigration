

generateFile <- function() {
    import_group <-  df_main_data %>%
        filter(!is.na(DateFrm),!is.na(orgunitsId)) %>%
        group_by(SiteCode, year_case, month_case) %>%
        summarise(n = n())  %>%
        arrange(SiteCode, desc(year_case), month_case)

    code <- "HSD"
    year_c <- 2017
    month_c <- 10

    tr_main_data_test <- df_main_data %>%
        filter(!is.na(DateFrm)) %>%
        # test one site
        filter(SiteCode == code, year_case == year_c, month_case == month_c) %>%
        # transpose to list
        transpose()

    batch_list <- getDataList(tr_main_data_test)
    batch_json <- toJSON(batch_list, pretty = T)

    filename <- paste(code, year_c, month_c, sep = "_")

    dirfile <- paste0("processed_data/output/", filename, ".json")
    write(batch_json, dirfile)


    # import_group_tr <- import_group %>% transpose()
    #
    # map(import_group_tr, function(x){
    #
    #     code <- x[["SiteCode"]]
    #     year_c <- x[["year_case"]]
    #     month_c <- x[["month_case"]]
    #
    #
    #    tr_main_data_test <- df_main_data %>%
    #    filter(!is.na(DateFrm)) %>%
    #    # test one site
    #    #filter(SiteCode == code,year_case == year_c, month_case == month_c) %>%
    #    filter(SiteCode == "HSD",year_case == 2017, month_case == 9) %>%
    #    # transpose to list
    #    transpose()
    #
    #     batch_list <- getDataList(tr_main_data_test)
    #     batch_json <- toJSON(batch_list,pretty = T)
    #
    #     filename <- paste(code,year_c,month_c, sep = "_")
    #     dirfile <- paste0("processed_data/output/",filename,".json")
    #     write_json(batch_json,dirfile)
    #
    #
    # })
}
