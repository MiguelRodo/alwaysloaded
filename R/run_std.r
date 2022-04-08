#' @title Standard tasks for inside .Rprofile
#'
#' @export
run_std <- function(env = parent.frame(2)) {

  # set repo to RStudio Package Manager
  options(
    repos = c(REPO_NAME = "https://cloud.r-project.org")
  )

  alwaysloaded::add_options_vsc()



  # change prompt style, don't show more than four digits
  # and don't show significance stars
  options(prompt = "R> ", digits = 4, show.signif.stars = FALSE)

  # don't open  dialogye boxes, but rather print to console
  options(menu.graphics = FALSE)

  # make knitr::include_graphics use
  # pdf automatically when knitting to PDF
  # even when file name ends in png
  options("knitr.graphics.auto_pdf" = TRUE)

  options(stringsAsFactors = FALSE)

  # open libraries
  # keep "standard" libraries first
  library("datasets")
  library("utils")
  library("grDevices")
  library("graphics")
  library("stats")
  if (interactive()) {
    # if (!requireNamespace("ggplot2", quietly = TRUE)) {
    #  message("installing ggplot2")
    #  utils::install.packages("ggplot2")
    # }
    # suppressMessages(suppressWarnings(invisible(library(ggplot2))))

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
  }

  suppressWarnings(rm("pkg_vec_installed", envir = .GlobalEnv))

  invisible(TRUE)
}
