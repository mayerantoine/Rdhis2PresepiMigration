


#' verify if object of type try-error
#'
is.error <- function(x) inherits(x, "try-error")

#' authentication function to dhis2 using httr
#'
login <- function() {
    uid <- Sys.getenv("uid")
    pwd <- Sys.getenv("pwd")

    set_config(authenticate(uid, pwd))

}
