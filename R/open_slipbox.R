os <- function() {
  path <- file.path(
    "C:/Users/migue/Work/Learning/slipbox",
    "_book",
    "index.html"
  )
  path <- normalizePath(path)
  text_command <- paste0("powershell Invoke-Expression ", path)
  suppressWarnings(suppressMessages(invisible(try(system(text_command)))))
  invisible(text_command)
}
