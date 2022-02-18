#' @title Standard tasks for inside .Rprofile
#'
#' @export
run_std <- function(env = rlang::caller_env()) {

  alwaysloaded::add_options_vsc()

  # set repo to RStudio Package Manager
  options(
    repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/latest")
  )

  # make knitr::include_graphics use
  # pdf automatically when knitting to PDF
  # even when file name ends in png
  options("knitr.graphics.auto_pdf" = TRUE)

  options(stringsAsFactors = FALSE)

  # open directory in File Explorer
  assign(
    ".od",
    value = .od,
    envir = env
  )

  # open slipbox
  assign(
    ".os",
    value = .os,
    envir = env
  )

  # open _book/index in current working dir
  assign(
    ".ob",
    value = .ob,
    envir = env
  )

  # knit book and don't add missing Rmds
  assign(
    ".kb",
    value = .kb,
    envir = env
  )

  # knit book and add missing Rmds
  assign(
    ".kbt",
    value = .kbt,
    envir = env
  )

  # add devtools::document
  assign(
    ".dd",
    value = .dd,
    envir = env
  )

  # add devtools::test()
  assign(
    ".dt",
    value = .dt,
    envir = env
  )

  # add devtools::load_all
  assign(
    ".dl",
    value = .dl,
    envir = env
  )

  # add devtools::install
  assign(
    ".di",
    value = .di,
    envir = env
  )

  # add .rv to print R version
  assign(
    ".rv",
    value = .rv,
    envir = env
  )

  # detach package(s)
  assign(
    ".detach_pkg",
    value = .detach_pkg,
    envir = env
  )


  # open libraries
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    message("installing ggplot2")
    utils::install.packages("ggplot2")
  }
  suppressMessages(suppressWarnings(invisible(library(ggplot2))))

  if (floor(as.numeric(utils::sessionInfo()$R.version$major)) <= 3) {

    if (!requireNamespace("magrittr", quietly = TRUE)) {
      message("installing magrittr")
      utils::install.packages("magrittr")
    }

    try(assign("%>%",
      value = magrittr::`%>%`,
      envir = env
    ))
  }

  invisible(TRUE)
}
