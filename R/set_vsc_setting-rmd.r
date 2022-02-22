#' @title Set VSC Rmd settings
#'
#' @description Set typical VSC settings with respect to RMarkdown documents.
#' @export
.set_vsc_setting_rmd <- function(editor.wordWrap = "on", # nolint
                                 editor.quickSuggestions = FALSE, # nolint
                                 editor.formatOnType = FALSE, # nolint
                                 path_to_settings = here::here(
                                   ".vscode/settings.json"
                                 )) {
  .set_vsc_setting(
    nm = "[rmd]",
    val_or_fn = list(
      editor.wordWrap = editor.wordWrap,
      editor.quickSuggestions = editor.quickSuggestions,
      editor.formatOnType = editor.formatOnType
    ),
    path_to_settings,
    update = TRUE,
    create = TRUE
  )
  invisible(TRUE)
}
