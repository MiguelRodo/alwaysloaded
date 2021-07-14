#' @title Begin radian terminal with specific R version
#'
#' @export
rv <- function(version = "4") {
  version <- switch(as.character(version),
    "3" = "3.6.3",
    "4" = "4.1.0"
  )
  # cat(
  paste0(
    "radian.exe --r-binary='C:/Program Files/R/R-",
    version,
    "/bin/R.exe'"
  )
  path_r <- paste0(
    "C:/Program Files/R/R-",
    version,
    "/bin/R.exe"
  )
  path_r <- normalizePath(path_r)
  system_cmd <- paste0(
    "powershell ",
    "radian.exe --r-binary='",
    path_r,
    "'"
  )
  system(system_cmd)
  normalizePath(
    paste0(
      "radian.exe --r-binary='C:/Program Files/R/R-",
      version,
      "/bin/R.exe'"
    )
  )

}

#' @title Open a specified R Version in terminal
#' 
#' @details Only seems to work when opening current version.
#' Therefore only r_r is exported. 
r_ov <- function(version) {
  version <- switch(as.character(version),
    "3" = "3.6.3",
    "4" = "4.1.0"
  )

  path_r <- paste0(
    "C:/Program Files/R/R-",
    version,
    "/bin/R.exe"
  )

  path_r <- normalizePath(path_r)

  system_cmd <- paste0(
    "powershell ",
    "radian.exe --r-binary='",
    path_r,
    "'"
  )

  system(system_cmd)
  invisible(TRUE)
}

#' @title Restart R
r_r <- function() {
  x <- sessionInfo()
  version <- gsub("R version ", "", x$R.version$version.string)
  version <- stringr::str_sub(
    version,
    end = stringr::str_locate(version, "\\s")[, 1][[1]] - 1
  )
  version <- stringr::str_sub(version, end = 1)

  r_ov(version = version)
  invisible(TRUE)
}


#' @title Change R terminal version between 3.6.3 and 4.1.0
#'
#' Does not seem to work properly - seems to still use old libraries
r_cv <- function(version = NULL) {

  x <- sessionInfo()
  version <- gsub("R version ", "", x$R.version$version.string)
  version <- stringr::str_sub(
    version,
    end = stringr::str_locate(version, "\\s")[, 1][[1]] - 1
  )
  version <- setdiff(c("3.6.3", "4.1.0"), version)
  version <- stringr::str_sub(version, end = 1)

  r_ov(version = version)
  invisible(TRUE)

}

#' @title Create text for changing version in PowerShell
r_pst <- function(version = NULL) {

  version <- "4.1.0"
  cat(
    paste0(
      "radian.exe --r-binary='C:/Program Files/R/R-",
      version,
      "/bin/R.exe'"
    )
  )
}
