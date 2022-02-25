#' @title Set R version for build and console
#'
#' @description Set R version in VSC settings.
#'
#' @param r_v character. R version.
#' If "3" or "4", then set to "3.6.3" or "4.1.2", respectively.
#' Otherwise must specify full version.
#' @param r_dir character. Path where "R-<version>/bin/R.exe" is.
#' @param nm character R\.set_vsc_setting-r_version.rvector.
#' VSC options to set R version for.
#' At present, must be options starting either
#' with \code{"r.rpath"} or \code{"r.term"}.
#' Default is \code{c("r.rpath.windows", "r.rterm.option")}.
#' @inheritParams .set_vsc_setting
#'
#' @return \code{invisible(TRUE)}. Side effect is that
#' JSON file with settings is updated.
#'
#' @aliases .srv srv
#'
#' @export
.set_r_version <- function(r_v = "",
                           nm = c("r.rpath.windows", "r.rterm.option"),
                           path_to_settings = here::here(".vscode/settings.json"), # nolint
                           r_dir = "C:\\Program Files\\R") {
  r_version <- switch(as.character(r_v),
    "3" = "3.6.3",
    "4" = "4.1.2",
    as.character(r_v)
  )

  if (nchar(r_version) != 5) {
    stop(
      paste0("r_version ", r_version, " does not have length 5")
    )
  }

  rpath_settings <- nm[grepl("^r.rpath", nm)]
  rterm_settings <- nm[grepl("^r.rterm", nm)]

  for (i in seq_along(rpath_settings)) {
    .set_vsc_setting(
      nm = rpath_settings[i],
      val_or_fn = .get_rpath,
      path_to_settings = path_to_settings,
      update = TRUE,
      create = TRUE,
      r_version = r_version,
      r_dir = r_dir
    )
  }

  for (i in seq_along(rterm_settings)) {
    .set_vsc_setting(
      nm = rterm_settings[i],
      val_or_fn = .get_rterm,
      path_to_settings = path_to_settings,
      update = TRUE,
      create = TRUE,
      r_version = r_version,
      r_dir = r_dir
    )
  }

  invisible(TRUE)
}

#' @rdname dot-set_r_version
#' @export
.srv <- .set_r_version

.get_rpath <- function(setting_old, r_version, r_dir) {
  if (identical(setting_old, "~~unset~~")) {
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
    return(path_r)
  }

  .update_r_version_ind(setting_old = setting_old, r_version = r_version)
}

.get_rterm <- function(setting_old, r_version, r_dir) {
  if (identical(setting_old, "~~unset~~")) {
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
    return(
      c(paste0("--r-binary=", path_r), "--no-save", "--no-restore", "radian")
    )
  }

  vapply(
    setting_old, .update_r_version_ind,
    r_version = r_version, character(1)
  ) %>%
    setNames(NULL)
}

.update_r_version_ind <- function(setting_old, r_version) {
  if (!grepl("R-\\d\\.\\d\\.\\d", setting_old)) {
    return(setting_old)
  }
  char_loc <- regexpr("R-\\d\\.\\d\\.\\d", setting_old)
  ind_start <- char_loc
  attributes(ind_start) <- NULL
  ind_end <- ind_start + attr(char_loc, "match.length") - 1
  r_v_current <- substr(setting_old, ind_start, ind_end)
  path_out <- sub(
    pattern = r_v_current,
    replacement = paste0("R-", r_version),
    x = setting_old
  )

  path_out
}
