#' @export
.dl <- function() {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    message("installing devtools")
    utils::install.packages("devtools")
  }
  devtools::load_all(here::here())
  invisible(TRUE)
}
#' @export
.dd <- function() {
  if (file.exists("NAMESPACE")) {
    x <- read.table("NAMESPACE", comment.char = "", nrows = 1)
    if (!identical(as.character(x$V1), "#")) file.remove("NAMESPACE")
  }
  if (!requireNamespace("devtools", quietly = TRUE)) {
    message("installing devtools")
    utils::install.packages("devtools")
  }
  devtools::document()
  invisible(TRUE)
}
#' @export
.dt <- function() {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    message("installing devtools")
    utils::install.packages("devtools")
  }
  devtools::test()
  invisible(TRUE)
}

#' @export
.di <- function() {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    message("installing devtools")
    utils::install.packages("devtools")
  }
  .dd()
  devtools::install(upgrade = "never")
  invisible(TRUE)
}

#' @export
.dl <- function() {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    message("installing devtools")
    utils::install.packages("devtools")
  }
  devtools::load_all()
  invisible(TRUE)
}
