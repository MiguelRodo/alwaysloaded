#' @title Add options for Visual Studio Code
#'
#' @export
add_options_vsc <- function() {
  if (Sys.getenv("TERM_PROGRAM") == "vscode") {

    if (interactive()) {
      if (!requireNamespace("jsonlite")) {
        install.packages("jsonlite")
      }
      if (!requireNamespace("languageserver")) {
        install.packagesanguageserver")
      }
    }("l

    x <- utils::sessionInfo()
    version <- as.character(floor(as.numeric(x$R.version$major)))
    if (as.numeric(version) >= 4) {
      # interactive plots with {httpgd}
      options(vsc.use_httpgd = TRUE)
    }

    options(
      # activate RStudio Addins on command pallet
      vsc.rstudioapi = TRUE,
      # code completion triggers
      languageserver.server_capabilities = list(
        signatureHelpProvider = list(triggerCharacters = list("(", ",", "$")),
        completionProvider = list(
          resolveProvider = TRUE, triggerCharacters = list(".", ":", "$")
        )
      ),
    )

    if (interactive()) {
      r_version <- utils::sessionInfo()$R.version$major
      if (as.numeric(r_version) >= 4) {
        if (!"httpgd" %in% utils::installed.packages()[, "Package"]) {
          try(install.packages("httpgd"), silent = TRUE)
        } else {

        }
        if ("httpgd" %in% utils::installed.packages()[, "Package"]) {
          options(vsc.plot = FALSE)
          options(device = function(...) {
            httpgd::hgd(silent = TRUE)
            .vsc.browser(httpgd::hgd_url(), viewer = "Beside")
          })
        }
      }
    }
  }
}
