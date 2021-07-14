#' @export
dl <- function() {
  devtools::load_all(here::here())
  invisible(TRUE)
}
#' @export
dd <- function() {
  devtools::document()
  invisible(TRUE)
}
#' @export
.dt <- function() {
  devtools::test()
  invisible(TRUE)
}

#' @export
bi <- function(version = NULL) {

  if (is.null(version)) {
    x <- sessionInfo()
    version <- gsub("R version ", "", x$R.version$version.string)
    version <- stringr::str_sub(
      version,
      end = stringr::str_locate(version, "\\s")[, 1][[1]] - 1
    )
  } else{
    stop("version cannot yet be specified.
    Need to figure out how to build to correct version's library.")
    version <- purrr::map_chr(version, function(x) {
      switch(as.character(x),
        "3" = "3.6.3",
        "4" = "4.1.0"
      )
    })
  }

  path_rcmd <- paste0(
    "C:\\Program Files\\R\\R-",
    version, "\\",
    "bin", "\\",
    "x64", "\\",
    "R.exe" # used to be Rcmd.exe, as RStudio uses
  )

  path_pkg <- here::here()
  path_pkg <- normalizePath(path_pkg)

  ps_cmd <- paste0(
    "&'", path_rcmd, "' ",
    "CMD INSTALL --no-multiarch --with-keep.source '",
    # remove CMD\\s above if using Rcmd.exe instead of R.exe
    path_pkg, "'"
  )

  system_cmd <- paste0(
    "powershell ",
    ps_cmd,
    ""
  )
  system(system_cmd)

  invisible(TRUE)
}
