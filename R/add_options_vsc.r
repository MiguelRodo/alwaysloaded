#' @title Add options for Visual Studio Code
#'
#' @export
add_options_vsc <- function() {

  if (Sys.getenv("TERM_PROGRAM") == "vscode") {

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
      radian.auto_match = FALSE,
      # radian highlight scheme (choose what suits you)
      radian.color_scheme = "native",
      radian.tab_size = 2,
      radian.completion_timeout = 0.05,
      radian.insert_new_line = FALSE,
      # see https://github.com/randy3k/radian/issues/324 re above
      radian.highlight_matching_bracket = FALSE,
      radian.auto_identation = TRUE
    )

    if (interactive()) {
      if ("httpgd" %in% .packages(all.available = TRUE)) {
        options(vsc.plot = FALSE)
        options(device = function(...) {
          httpgd::hgd(silent = TRUE)
          .vsc.browser(httpgd::hgd_url(), viewer = "Beside")
        })
      }
    }
  }
}
