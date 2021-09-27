#' @title Standard tasks for inside .Rprofile
#'
#' @export
run_std <- function(env = rlang::caller_env()) {
  add_options_vsc()

  # set repo
  options(
    repos = c(CRAN = "https://cran.mirror.ac.za/")
  )

  # open directories
  assign(
    "od",
    value = od,
    envir = env
  )

  # open directories
  assign(
    "os",
    value = os,
    envir = env
  )

  # print powershell text
  assign(
    "r_pst",
    value = r_pst,
    envir = env
  )

  assign(
    "r_v",
    value = r_v,
    envir = env
  )

  # open directories
  assign(
    "ob",
    value = ob,
    envir = env
  )

  # open directories
  assign(
    "kb",
    value = kb,
    envir = env
  )

  # open directories
  assign(
    "kbt",
    value = kbt,
    envir = env
  )

  # add devtools::document
  assign(
    "dd",
    value = dd,
    envir = env
  )
  # open directories
  assign(
    ".dt",
    value = .dt,
    envir = env
  )
  # open directories
  assign(
    "dl",
    value = dl,
    envir = env
  )

  # open directories
  assign(
    "bi",
    value = bi,
    envir = env
  )

  # open libraries
  suppressMessages(suppressWarnings(invisible(library(ggplot2))))
  assign("%>%",
         value = magrittr::`%>%`,
         envir = env)
  suppressMessages(suppressWarnings(invisible(library(stringr))))

  invisible(TRUE)
}
