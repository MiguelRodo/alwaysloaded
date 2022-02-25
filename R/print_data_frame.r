#' @rdname dataframe_utils
#' @title Print data frame like head
#'
#' @param df dataframe.
#'
#' @export
print.data.frame <- function(df) {
  if (nrow(df) > 10) {
    base::print.data.frame(head(df, 5))
    cat("----\n")
    base::print.data.frame(tail(df, 5))
  } else {
    base::print.data.frame(df)
  }
}

#' @title Print head and tail
#'
#' @param d dataframe.
.ht <- function(d) rbind(head(d, 10), tail(d, 10))

#' @title Show first five rows and columns
#'
#' @param d dataframe
#' @export
.hh <- function(d) d[seq_len(min(5, nrow(d))), seq_len(min(ncol(d), 5))]
