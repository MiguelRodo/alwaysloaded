os <- function() {
  path <- file.path(
    "C:/Users/migue/Work/Learning/slipbox",
    "_book",
    "index.html"
  )
  utils::browseURL(path)
  invisible(path)
}
