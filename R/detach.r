#' @title Detach a package
#'
#' @description
#' Wrapper function around library and detach
#' to detach packages.
#'
#' @param x character vector.
#' Names of packages to detach.
#'
#' @export
.detach_pkg <- function(x) {
  for (xx in x) {
    library(xx, character.only = TRUE)
    args_list <- list(
      name = paste0("package:", xx),
      unload = TRUE,
      character.only = TRUE
    )
    do.call(
      what = "detach",
      args = args_list
    )
  }
  invisible(TRUE)
}
