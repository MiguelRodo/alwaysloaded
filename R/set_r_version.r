#' @title Set R version in VSC workspace settings
#'
#' @description Set R version in VSC workspace settings.
#'
#' @param r_v character. R version.
#' If "3" or "4", then set to "3.6.3" or "4.1.2", respectively.
#' Otherwise must specify full version.
#' @param r_dir character. Path where "R-<version>/bin/R.exe" is.
#' @param ws_settings character. VS Code workspace settings to set.
#'
#' @return \code{invisible(TRUE)}.
#' @export
.srv <- function(r_v = "",
                 r_dir = "C:\\Program Files\\R", # nolint
                 ws_settings = c("r.rpath.windows", "r.rterm.option")) {



  r_version <- switch(
    as.character(r_v),
    "3" = "3.6.3",
    "4" = "4.1.2",
    as.character(r_v)
  )

  if (nchar(r_version) != 5) stop(
    paste0("r_version ", r_version, " does not have length 5")
  )

  # install required packages
  if (!requireNamespace("rjson")) {
    install.packages("rjson", quiet = TRUE)
  }
  if (!requireNamespace("here")) {
    install.packages("here", quiet = TRUE)
  }

  # load settings, or create them
  path_ws_settings <- here::here(".vscode/settings.json")
  path_ws_settings <- normalizePath(path_ws_settings)
  if (file.exists(path_ws_settings)) {
    ws_settings_json <- rjson::fromJSON(file = path_ws_settings)
  } else ws_settings_json <- list()

  # get indices of settings that are affected
  ind_replace_lgl <- vapply(
    ws_settings,
    function(x) {
      x %in% names(ws_settings_json)
    },
    logical(1)
    )
  ws_settings_replace <- ws_settings[ind_replace_lgl]
  ws_settings_create <- ws_settings[!ind_replace_lgl]

  ws_settings_json_orig <- ws_settings_json

  # replace pre-existing settings
  # ------------------------
  for (i in seq_along(ws_settings_replace)) {

    # get name of setting
    x <- ws_settings_replace[i]
    # get which index in original settings has this name
    x_ind <- which(
      vapply(
        names(ws_settings_json),
        function(y) grepl(paste0("^", x, "$"), y),
        logical(1)
      )
    )
    # replace this setting's value
    ws_settings_json[[x]] <- .set_r_version(
      ws_settings_json[[i]],
      r_version = r_version
      )
  }

  # create new settings
  # ------------------------
  for (i in seq_along(ws_settings_create)) {

    # get name of setting
    x <- ws_settings_create[i]

    path_r <- normalizePath(file.path(
      r_dir,
      paste0("R-", r_version),
      "bin",
      "r.exe"
    ))

    if (!file.exists(path_r)) {
      stop(paste0(
        "path ", path_r, " does not exist"
      ))
    }

    new_setting <- switch(
      as.character(x),
      "r.rterm.option" = c(
        paste0("--r-binary=", path_r), "--no-save", "--no-restore", "radian"
        ),
      path_r
      )

    extra_list <- setNames(list(new_setting), x)
    ws_settings_json <- ws_settings_json %>% append(extra_list)
  }

  # save settings
  # note that formatting of sub-lists doesn't work so well,
  # so don't save if nothing has changed
  if (identical(ws_settings_json_orig, ws_settings_json)) {
    return(invisible(TRUE))
  }
  ws_settings_json <- rjson::toJSON(ws_settings_json, indent = 2)
  write(ws_settings_json, file = here::here(".vscode/settings.json"))

  invisible(TRUE)

}

.set_r_version <- function(setting_orig, r_version) {

  if (!identical(class(setting_orig), "character")) return(setting_orig)

  switch(
    as.character(is.list(setting_orig)),
    "TRUE" = lapply(setting_orig, .set_r_version_ind, r_version = r_version) %>%
      setNames(NULL),
    "FALSE" = vapply(
      setting_orig, .set_r_version_ind, r_version = r_version, character(1)
    ) %>%
      setNames(NULL)
  )
}


.set_r_version_ind <- function(x, r_version) {
  if (!grepl("R-\\d\\.\\d\\.\\d", x)) return(x)
  char_loc <- regexpr("R-\\d\\.\\d\\.\\d", x)
  ind_start <- char_loc
  attributes(ind_start) <- NULL
  ind_end <- ind_start + attr(char_loc, "match.length") - 1
  r_v_current <- substr(x, ind_start, ind_end)
  path_out <- sub(
    pattern = r_v_current,
    replacement = paste0("R-", r_version),
    x = x
    )

  path_out
}

#' @title Remove R version specification from VSC workspace
#'
#' @description Unset R version from being fixed by VSC workspace settings.
#' This function just removes the JSON elements
#' specified by \code{ws_settings} if they're there, and does nothing otherwise.
#'
#' @param ws_settings character vector. names of VSC workspace
#' settings that should be removed to unset R version.
#'
#' @return \code{invisible(TRUE)}.
#' @export
.urv <- function(ws_settings = c("r.rpath.windows", "r.rterm.option")) {

  # install required packages
  if (!requireNamespace("rjson", quietly = TRUE)) {
    install.packages("rjson", quiet = TRUE)
  }
  if (!requireNamespace("here", quietly = TRUE)) {
    install.packages("here", quiet = TRUE)
  }

  # load settings, or create them
  path_ws_settings <- here::here(".vscode/settings.json")
  path_ws_settings <- normalizePath(path_ws_settings)
  if (file.exists(path_ws_settings)) {
    ws_settings_json <- rjson::fromJSON(file = path_ws_settings)
  } else return(invisible(TRUE))

  if (!any(names(ws_settings_json) %in% ws_settings)) return(invisible(TRUE))

  ws_settings_json <- ws_settings_json[
    !names(ws_settings_json) %in% ws_settings
    ]

  ws_settings_json <- rjson::toJSON(ws_settings_json, indent = 2)
  if (!dir.exists(dirname(here::here(".vscode")))) dir.create(
    here::here(".vscode"), recursive = TRUE
    )
  write(ws_settings_json, file = here::here(".vscode/settings.json"))

  invisible(TRUE)
}