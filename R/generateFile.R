

generateFile <- function(df_main_data,code = "HSD", year = 2017, month = 10) {


    tr_main_data_test <- df_main_data %>%
        filter(!is.na(DateFrm)) %>%
        # test one site
        filter(SiteCode == code, year_case == year, month_case == month) %>%
        # transpose to list
        transpose()

    batch_list <- getDataList(tr_main_data_test)
    batch_json <- toJSON(batch_list, pretty = T)

    filename <- paste(code, year, month, sep = "_")

    dirfile <- paste0(filename, ".json")
    write(batch_json,dirfile)

}


generateAllFile <- function(df_main_data){

  import_group <-  df_main_data %>%
        filter(!is.na(DateFrm),!is.na(orgunitsId)) %>%
        group_by(SiteCode, year_case, month_case) %>%
        summarise(n = n())  %>%
        arrange(SiteCode, desc(year_case), month_case)

  import_group_tr <- import_group %>% transpose()

    map(import_group_tr, function(x){

        code <- x[["SiteCode"]]
        year_c <- x[["year_case"]]
        month_c <- x[["month_case"]]

        generateFile(df_main_data,code,year_c,month_c)

     })

}
