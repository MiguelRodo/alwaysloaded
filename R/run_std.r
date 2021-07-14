#' @title Standard tasks for inside .Rprofile
#'
#' @export
run_std <- function(env = rlang::caller_env()) {
  add_options_vsc()

  # open directories
  assign(
    "od",
    value = od,
    envir = env
  )

  # open directories
  assign(
    "rv",
    value = rv,
    envir = env
  )

  # open directories
  assign(
    "ob",
    value = ob,
    envir = env
  )

  # open directories
  assign(
    "kb",
    value = kb,
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
    "dt",
    value = dt,
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
    "dbi",
    value = dbi,
    envir = env
  )
}
