#' @title Check class of an object
#'
#' @description
#' Meant to not be run interactively,
#' but added to code without
#' adding depenencies, and so is not
#' exported.
#'
#' @param x object. Object whose class is assessed.
#' @param y character vector. Expected classes of \code{x}.
#'
assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
        paste0(y, collapse = ", "),
        call. = FALSE
      )
    }
  }
}