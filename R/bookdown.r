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
#' @param inc_ext logical.
#' If \code{TRUE}, then files in \code{ext/} are included.
#' Default is \code{FALSE}.
#' @export
kb <- function(input = NULL,
               exact = FALSE,
               inc_ext = FALSE) {

  alwaysloaded:::adj_yaml(inc_ext = inc_ext)

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

kbt <- function() kb(inc_ext = TRUE)

#' @title Include or exclude non-work Rmds from _bookdown.yml
adj_yaml <- function(inc_ext = FALSE) {

  yml <- yaml::read_yaml("_bookdown.yml")
  rmd_vec <- yml$rmd_files
  rmd_vec <- rmd_vec[!grepl("^ext/", rmd_vec)]
  rmd_vec_add <- setdiff(list.files(here::here(), ".Rmd$"),
                         rmd_vec)
  rmd_vec <- c(rmd_vec,
               rmd_vec_add)

  paper_vec <- rmd_vec[grepl("^zz-", rmd_vec)]
  topic_vec <- setdiff(rmd_vec, paper_vec)
  bib_vec <- paper_vec[grepl("zz-zz-", paper_vec)]
  paper_vec <- setdiff(paper_vec, bib_vec)
  meetings_vec <- topic_vec[grepl("zx-", topic_vec)]
  topic_vec <- setdiff(topic_vec, meetings_vec)


  if (inc_ext) {

    rmd_vec_ext <- yaml::read_yaml("ext_rmd_order.yml")$rmd_files
    rmd_vec_ext <- paste0(
      "ext/",
      c(
        rmd_vec_ext,
        list.files(file.path(here::here(), "ext"),
                   pattern = ".Rmd$")
      )
    )
    if (identical("ext/", rmd_vec_ext)) {
      rmd_vec_ext <- NULL
    }

    paper_vec_ext <- rmd_vec_ext[grepl("^ext/zz-", rmd_vec_ext)]
    topic_vec_ext <- setdiff(rmd_vec_ext, paper_vec_ext)
    bib_vec_ext <- paper_vec_ext[grepl("ext/zz-zz-", paper_vec_ext)]
    meetings_vec_ext <- topic_vec_ext[grepl("ext/zx-", topic_vec_ext)]
    paper_vec_ext <- setdiff(paper_vec_ext, bib_vec)

    rmd_vec <- c(
      topic_vec,
      topic_vec_ext,
      meetings_vec,
      meetings_vec_ext,
      paper_vec,
      paper_vec_ext,
      bib_vec,
      bib_vec_ext
    )

  } else {

    rmd_vec <- c(
      topic_vec,
      meetings_vec,
      paper_vec,
      bib_vec
    )

  }

  rmd_vec <- rmd_vec[file.exists(rmd_vec)]

  yml$rmd_files <- unique(rmd_vec)

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
