#' @title Open File Explorer at a particular directory
od <- function(path = here::here()) {
  path <- normalizePath(path)
  text_command <- paste0("powershell explorer ", path)
  system(text_command)
  invisible(text_command)
}
