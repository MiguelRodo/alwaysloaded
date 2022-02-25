#' @title Print head and tail
#'
#' @param df dataframe.
#'
#' @export
.ht <- function(df, n = 10) {
  if (nrow(df) > n) {
    per_end <- round(n / 2)
    base::print.data.frame(head(df, per_end))
    cat("----\n")
    base::print.data.frame(tail(df, per_end))
  } else {
    base::print.data.frame(df)
  }
}

#' @title Print head
#'
#' @param df dataframe.
#'
#' @export
.hh <- function(df, n = 10) {
  base::print.data.frame(head(df, n))
}

#' @title Print head
#'
#' @param df dataframe.
#'
#' @export
.tt <- function(df, n = 10) {
  base::print.data.frame(head(df, n))
}