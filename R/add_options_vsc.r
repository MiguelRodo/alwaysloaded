#' @title Add options for Visual Studio Code
#'
#' @export
add_options_vsc <- function() {
  if (Sys.getenv("TERM_PROGRAM") == "vscode") {

    if ("renv:shims" %in% search()) {
      install_pkg <- renv::install
    } else {
      install_pkg <- utils::install.packages
    }

    if (interactive()) {
      if (!requireNamespace("jsonlite", quietly = TRUE)) {
        install_pkg("jsonlite")
      }
      if (!requireNamespace("rlang", quietly = TRUE)) {
        install_pkg("rlang")
      }
      if (!requireNamespace("languageserver", quietly = TRUE)) {
        install_pkg("languageserver")
      }
    }

    x <- utils::sessionInfo()
    version <- as.character(floor(as.numeric(x$R.version$major)))


    options(
      # activate RStudio Addins on command pallet
      vsc.rstudioapi = TRUE,
      # code completion triggers
      languageserver.server_capabilities = list(
        signatureHelpProvider = list(triggerCharacters = list("(", ",", "$")),
        completionProvider = list(
          resolveProvider = TRUE, triggerCharacters = list(".", ":", "$")
        )
      )
    )

    if (interactive()) {
      r_version <- utils::sessionInfo()$R.version$major
      if (as.numeric(r_version) >= 4) {
        if (!requireNamespace("httpgd", quietly = TRUE)) {
          try(install_pkg("httpgd"), silent = TRUE)
        }
        if (requireNamespace("httpgd", quietly = TRUE)) {
          options(vsc.plot = FALSE)
          options(device = function(...) {
            httpgd::hgd(silent = TRUE)
            .vsc.browser(httpgd::hgd_url(), viewer = "Beside")
          })
          if (as.numeric(version) >= 4) {
            # interactive plots with {httpgd}
            options(vsc.use_httpgd = TRUE)
          }
        }
      }
    }
  }
}
