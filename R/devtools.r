#' @export
dl <- function() {
  devtools::load_all(here::here())
  invisible(TRUE)
}
#' @export
dd <- function() {
  devtools::document()
  invisible(TRUE)
}
#' @export
.dt <- function() {
  devtools::test()
  invisible(TRUE)
}