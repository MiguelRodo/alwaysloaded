#' @export
.dl <- function(...) {

  if ("renv:shims" %in% search()) {
    install_pkg <- renv::install
  } else {
    install_pkg <- utils::install.packages
  }
  if (!requireNamespace("devtools", quietly = TRUE)) {
    message("installing devtools")
    install_pkg("devtools")
  }
  devtools::load_all(...)
  invisible(TRUE)
}
#' @export
.dd <- function(...) {
  if (file.exists("NAMESPACE")) {
    x <- read.table("NAMESPACE", comment.char = "", nrows = 1)
    if (!identical(as.character(x$V1), "#")) file.remove("NAMESPACE")
  }
  if (!requireNamespace("devtools", quietly = TRUE)) {
    if ("renv:shims" %in% search()) {
      install_pkg <- renv::install
    } else {
      install_pkg <- utils::install.packages
    }
    message("installing devtools")
    install_pkg("devtools")
  }
  devtools::document(...)
  invisible(TRUE)
}
#' @export
.dt <- function(...) {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    if ("renv:shims" %in% search()) {
      install_pkg <- renv::install
    } else {
      install_pkg <- utils::install.packages
    }
    message("installing devtools")
    install_pkg("devtools")
  }
  devtools::test(...)
  invisible(TRUE)
}

#' @export
.di <- function(upgrade = "never", ...) {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    if ("renv:shims" %in% search()) {
      install_pkg <- renv::install
    } else {
      install_pkg <- utils::install.packages
    }
    message("installing devtools")
    install_pkg("devtools")
  }
  .dd()
  devtools::install(upgrade = upgrade, ...)
  invisible(TRUE)
}

#' @export
.dl <- function(...) {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    if ("renv:shims" %in% search()) {
      install_pkg <- renv::install
    } else {
      install_pkg <- utils::install.packages
    }
    message("installing devtools")
    install_pkg("devtools")
  }
  devtools::load_all(...)
  invisible(TRUE)
}
