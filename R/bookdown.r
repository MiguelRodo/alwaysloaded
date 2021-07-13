#' @title Knit book
#'
#' @param input character vector. If not \code{NULL}, then files
#' that match to elements in here
#' are knitted.
#' If \code{NULL}, thena all files are knitted.
#' Default is \code{NULL}.
#' @param exact logical.
#' If \code{FALSE}, then partial matches for \code{input} are accepted.
#' Default is \code{FALSE}.
#' @param inc_non_work logical.
#' If \code{TRUE}, then files in \code{non_work/} are included.
#' Default is \code{FALSE}.
#' @export
kb <- function(input = NULL,
                exact = FALSE,
                inc_non_work = FALSE) {

  alwaysloaded:::adj_yaml_non_work(inc_non_work = inc_non_work)

  if (is.null(input)) {
    message("render beginning")
    sink(file.path(tempdir(), "bd.txt"))
    suppressMessages(
      bookdown::render_book(quiet = TRUE)
    )
    sink()
    message("render complete")
  } else {
    yml <- yaml::read_yaml("_bookdown.yml")
    rmd_vec <- yml$rmd_files
    rmd_vec_match <- purrr::map(input, function(x) {
      rmd_vec <- yml$rmd_files
      pattern <- ifelse(
        exact,
        paste0("^", input, ".Rmd$"),
        input
      )
      rmd_vec[grepl(pattern, rmd_vec)]
    })

    rmd_vec_match <- purrr::compact(rmd_vec_match)
    rmd_vec_match <- unlist(rmd_vec_match)
    rmd_vec_match <- unique(rmd_vec_match)

    rmd_vec <- rmd_vec[rmd_vec %in% rmd_vec_match]

    message("render beginning")
    sink(file.path(tempdir(), "bd.txt"))
    suppressMessages(bookdown::render_book(
      input = rmd_vec,
      quiet = TRUE,
      preview = TRUE
    ))
    sink()
    message("render complete")
  }

  ob()
  invisible(TRUE)
}

#' @title Include or exclude non-work Rmds from _bookdown.yml
adj_yaml_non_work <- function(inc_non_work = FALSE) {

  # include or exclude non-work Rmds
  # --------------------

  rmd_vec_non_work <- c(
    "the_message.Rmd",
    "theology.Rmd",
    "theology-relationships.Rmd",
    "theology-the_church.Rmd",
    "theology-the_cross.Rmd",
    "management.Rmd"
  )
  rmd_vec_non_work <- paste0(
    "non_work/",
    rmd_vec_non_work
  )

  yml <- yaml::read_yaml("_bookdown.yml")

  if (inc_non_work) {
    rmd_vec <- yml$rmd_files
    paper_vec <- rmd_vec[grepl("^zz-", rmd_vec)]
    non_paper_vec <- rmd_vec[!grepl("^zz-", rmd_vec)]
    paper_vec_non_work <- rmd_vec_non_work[grepl(
      "^non-work/zz-",
      rmd_vec_non_work
    )]
    non_paper_vec_non_work <- rmd_vec_non_work[!grepl(
      "^non-work/zz-",
      rmd_vec_non_work
    )]
    rmd_vec <- c(
      non_paper_vec,
      non_paper_vec_non_work,
      paper_vec,
      paper_vec_non_work
    )
    yml$rmd_files <- unique(rmd_vec)
  } else {
    rmd_vec <- yml$rmd_files
    rmd_vec <- rmd_vec[!grepl("^non_work", rmd_vec)]
    yml$rmd_files <- unique(rmd_vec)
  }

  yaml::write_yaml(
    yml,
    file = "_bookdown.yml"
  )
}

#' @title Open book
#' 
#' @export
ob <- function(chapter = NULL, exact = FALSE, ind = 1) {
  if (!is.null(chapter)) {
    if (!exact) {
      chapter <- stringr::str_trim(chapter)
      chapter <- stringr::str_replace_all(
        chapter,
        "\\s|_",
        "-"
      )
      html_vec <- list.files(file.path(here::here(), "_book"),
        pattern = "html$"
      )
      html_vec <- html_vec[stringr::str_detect(html_vec, chapter)]
      html <- html_vec[ind]
    } else {
      if (!stringr::str_sub(chapter, end = -4) == "html") {
        html <- paste0(chapter, ".html")
      } else {
        html <- chapter
      }
    }
  } else {
    html <- "index.html"
  }
  path_book <- file.path(here::here(), "_book", html)
  text_command <- paste0("powershell Invoke-Expression ", path_book)
  system(text_command)
  invisible(text_command)
}