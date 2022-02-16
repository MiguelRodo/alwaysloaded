#' @export
.dl <- function() {
  if (!require("devtools")) {
    message("installing devtools")
    install.packages("devtools")
  }
  devtools::load_all(here::here())
  invisible(TRUE)
}
#' @export
.dd <- function() {
  if (!require("devtools")) {
    message("installing devtools")
    install.packages("devtools")
  }
  devtools::document()
  invisible(TRUE)
}
#' @export
.dt <- function() {
  if (!require("devtools")) {
    message("installing devtools")
    install.packages("devtools")
  }
  devtools::test()
  invisible(TRUE)
}

#' @export
.di <- function() {
  if (!require("devtools")) {
    message("installing devtools")
    install.packages("devtools")
  }
  devtools::install(upgrade = "never")
  invisible(TRUE)
}

#' @export
.dl <- function() {
  if (!require("devtools")) {
    message("installing devtools")
    install.packages("devtools")
  }
  devtools::load_all()
  invisible(TRUE)
}