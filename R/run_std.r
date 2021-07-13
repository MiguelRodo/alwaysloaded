#' @title Standard tasks for inside .Rprofile
#'
#' @export
run_std <- function() {
  add_options_vsc()

  # open directories
  assign(
    "od",
    value = od,
    envir = rlang::caller_env()
  )

  # open directories
  assign(
    "ob",
    value = ob,
    envir = rlang::caller_env()
  )

  # open directories
  assign(
    "kb",
    value = kb,
    envir = rlang::caller_env()
  )
}
