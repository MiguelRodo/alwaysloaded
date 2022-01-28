#' @title Standard tasks for inside .Rprofile
#'
#' @export
run_std <- function(env = rlang::caller_env()) {

  add_options_vsc()

  # set repo to RStudio Package Manager
  options(
    repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/latest")
  )

  options(stringsAsFactors = FALSE)

  # open directory in File Explorer
  assign(
    "od",
    value = od,
    envir = env
  )

  # open slipbox
  assign(
    "os",
    value = os,
    envir = env
  )

  # open _book/index in current working dir
  assign(
    "ob",
    value = ob,
    envir = env
  )

  # knit book and don't add missing Rmds
  assign(
    "kb",
    value = kb,
    envir = env
  )

  # knit book and add missing Rmds
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
  if (!require("ggplot2")) {
    install.packages("ggplot2")
  }
  suppressMessages(suppressWarnings(invisible(library(ggplot2))))

  if (floor(as.numeric(sessionInfo()$R.version$major)) <= 3) {

    if (!require("magrittr")) install.packages("magrittr")

    assign("%>%",
      value = magrittr::`%>%`,
      envir = env
    )
  }

  invisible(TRUE)
}
