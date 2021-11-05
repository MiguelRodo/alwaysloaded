#' @title Open a dialogue box at selected folder
#'
#' @description Useful for easily opening a window in
#' which you can see all the files in a folder and open them using
#' \code{Open with...}.
#'
#' @param path character. The initial working directory,
#' from which the file dialog should begin browsing.
#' Defaults to the current RStudio project directory.
#'
#' @return \code{invisible(<selected_file>/NULL)} (\code{NULL} if no file were
#'   selected).
#'
#' @details
#' Only works in Windows, at it calls PowerShell (unless
#' PowerShell can work on multiple OS's).
#'
#' @export
#'
#' @examples
#' od()
od <- function(path = here::here()) {
  path <- normalizePath(path)
  text_command <- paste0("powershell explorer ", path)
  system(text_command)
  invisible(text_command)
}
