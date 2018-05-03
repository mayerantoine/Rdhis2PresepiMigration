
is.error <- function(x) inherits(x, "try-error")

login <- function() {
    uid <- Sys.getenv("uid")
    pwd <- Sys.getenv("pwd")

    set_config(authenticate(uid, pwd))

}
