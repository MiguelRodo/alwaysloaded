#' @title Open a dialogue box at selected folder
#'
#' @description Useful for easily opening a window in
#' which you can see all the files in a folder and open them using
#' \code{Open with...}.
#'
#' @param path character. The initial working directory,
#' from which the file dialog should begin browsing.
#' Defaults to \code{here::here()}.
#'
#' @return \code{invisible(<selected_file>/NULL)} (\code{NULL} if no file were
#'   selected).
#'
#' @export
#'
#' @examples
#' od()
od <- function(path = here::here()) {
  path <- normalizePath(path)
  utils::browseURL(path, browser = NULL)
  invisible(path)
}
