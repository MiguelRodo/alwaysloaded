#' @title Begin radian terminal with specific R version
#'
#' @export
rv <- function(version = "4") {
  version <- switch(as.character(version),
    "3" = "3.6.3",
    "4" = "4.1.0"
  )
  cat(
    paste0(
      "radian.exe --r-binary='C:/Program Files/R/R-",
      version,
      "/bin/R.exe'"
      )
  )
}
