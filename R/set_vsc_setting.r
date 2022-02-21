#' @title Set VSC workspace settings
#' 
#' @param update logical. 
#' If \code{TRUE}, then elements whose names
#' match \code{nm} are changed.
#' Default is \code{TRUE}.
#' @param create logical.
#' If \code{TRUE}, then if there is
#' no pre-existing element with a given
#' element of \code{nm},
#' then an element with that name is added.
#' Default is \code{TRUE}.
#' @param character file.
#' Path to the VSC settings file to edit.
#' Default is \code{here::here(".vscode/settings.json")}.
#' @param nm character vector.
#' Elements in JSON file to adjust.
#' @param val_or_fn what to change the element to.
#' If anything other than a function,
#' then the list element simply changes to this.
#' If a function, then it is the function to apply
#' to matching elements.
#' For functions passed to
#' elements with pre-existing values,
#' the first argument
#' takes that pre-existing value.
#' @param ... Passed on to fn.
.set_vsc_setting <- function(nm,
                              val_or_fn,
                              path_to_settings = here::here(".vscode/settings.json"), # no lint
                              update = TRUE,
                              create = TRUE,
                              ...) {

  # install required packages
  if (!requireNamespace("rjson", quietly = TRUE)) {
    install.packages("rjson", quiet = TRUE)
  }
  if (!requireNamespace("here", quietly = TRUE)) {
    install.packages("here", quiet = TRUE)
  }

  # load settings, or create them
  if (file.exists(path_to_settings)) {
    settings_orig <- rjson::fromJSON(file = path_to_settings)
  } else settings_orig <- list()

  # get indices of settings that are affected
  settings <- settings_orig
  ind_replace_lgl <- vapply(
    nm,
    function(x) {
      x %in% names(settings)
    },
    logical(1)
    )
  nm_replace <- nm[ind_replace_lgl]
  nm_create <- nm[!ind_replace_lgl]

  if (update) {
    for (i in seq_along(nm_replace)) {
      x <- nm_replace[i]
      ind_x <- which(identical(names(settings), x))
      settings[ind_x] <- switch(
        as.character(identical(class(val_or_fn), "function")),
        "FALSE" = val_or_fn,
        "TRUE" = val_or_fn(...)
      )
    }
  }

  if (create) {
    for (i in seq_along(nm_create)) {
      x <- nm_create[i]
      val <- switch(
        as.character(identical(class(val_or_fn), "function")),
        "FALSE" = val_or_fn,
        "TRUE" = val_or_fn(...)
      )
      settings <- append(settings, setNames(list(val), x))
    }
  }

  # save settings
  # note that formatting of sub-lists doesn't work so well,
  # so don't save if nothing has changed
  if (identical(settings_orig, settings)) {
    return(invisible(TRUE))
  }
  settings_json <- rjson::toJSON(settings, indent = 2)
  if (!dir.exists(dirname(path_to_settings))) dir.create(
    dirname(path_to_settings), recursive = TRUE
  )
  write(settings_json, file = path_to_settings)

  invisible(TRUE)
}

#' @title Set VSC Rmd settings
#' 
#' @description Set typical VSC settings with respect to RMarkdown documents.
.set_vsc_setting_rmd <- function(editor.wordWrap = "on",
                                 editor.quickSuggestions = FALSE,
                                 editor.formatOnType = FALSE,
                                 path_to_settings = here::here(".vscode/settings.json")) { # no lint
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