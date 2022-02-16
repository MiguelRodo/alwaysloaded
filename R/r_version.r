#' Print R version
#' @export
.rv <- function() {
    si <- utils::sessionInfo()
    print(paste0(si$R.version$major, ".", si$R.version$minor))
}
