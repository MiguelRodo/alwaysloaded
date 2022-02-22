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
      # either  `"emacs"` (default) or `"vi"`.
      radian.editing_mode = "vi",
      # show vi mode state when radian.editing_mode is `vi`
      radian.show_vi_mode_prompt = TRUE,
      radian.vi_mode_prompt = "\033[0;34m[{}]\033[0m ",
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
      radian.auto_identation = TRUE,
      # pop up completion while typing
      radian.complete_while_typing = TRUE,
      # the minimum length of prefix to trigger auto completions
      radian.completion_prefix_length = 2,
      radian.completion_adding_spaces_around_equals = TRUE,
      # enable reticulate prompt and trigger `~`
      radian.enable_reticulate_prompt = TRUE
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
