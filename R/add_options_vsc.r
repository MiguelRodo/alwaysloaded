#' @title Add options for Visual Studio Code
#'
#' @export
add_options_vsc <- function() {
  options(
    # activate RStudio Addins on command pallet
    vsc.rstudioapi = TRUE,
    # interactive plots with {httpgd}
    vsc.use_httpgd = TRUE,

    # code completion triggers
    languageserver.server_capabilities = list(
      signatureHelpProvider = list(triggerCharacters = list("(", ",", "$")),
      completionProvider = list(
        resolveProvider = TRUE, triggerCharacters = list(".", ":", "$")
      )
    ),
    radian.auto_match = TRUE,
    # radian highlight scheme (choose what suits you)
    radian.color_scheme = "native",
    radian.tab_size = 2,
    radian.completion_timeout = 0.05,
    radian.insert_new_line = FALSE,
    radian.highlight_matching_bracket = FALSE,
    radian.auto_identation = TRUE
  )
}