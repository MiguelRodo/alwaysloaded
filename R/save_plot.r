#' @title Save plot in multiple formats using cowplot::save_plot
#'
#' @description Wrapper around \code{cowplot::save_plot} to save plots
#' in multiple formats.
#'
#' @param filename character. Name of plot (including directory, if
#' not to save in working directory).
#' @param plot gg object. Output from either ggplot2::ggplot
#' or cowplot::plot_grid.
#' @param device character vector. Devices to save in (i.e. plot format).
#' Default is \code(c("png", "pdf")).
#'
#' @details
#' This function should be copied to another package/report rather than
#' run from alwaysloaded, as alwaysloaded is simply a convenience package.
#'
#' @return \code{invisible(filename)}.
save_plot <- function(filename, plot, device = c("png", "pdf"), ...) {

  if (!requireNamespace("cowplot", quietly = TRUE)) {
      install.packages("cowplot", quiet = TRUE)
  }

  filename_orig <- filename
  if (grepl(".png", filename)) {
      filename <- gsub(".png$", "", filename)
  } else if (grepl(".pdf", filename)) {
      filename <- gsub(".pdf$", "", filename)
  }
  for (x in device) {
    cowplot::save_plot(
      filename = paste0(filename, ".", x),
      plot = plot,
      ...
    )
  }
  invisible(filename_orig)
}
