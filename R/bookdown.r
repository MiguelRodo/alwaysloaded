#' @title Knit book
#'
#' @description
#' \code{kbt} is a wrapper around
#' \code{kb} with \code{inc_ext = TRUE}.
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
#' @param add_missing logical. If \code{TRUE}, then any rmd's that
#' are not in either \code{_bookdown.yaml} or
#' \code{ext_rmd_order.yaml} are included (though those
#' in \code{ext_rmd_order.yml} are included only
#' if \code{inc_ext == TRUE}).
#' Otherwise no rmd's not explicitly included are included.
#' Default is \code{TRUE}.
#'
#' @export
.kb <- function(input = NULL,
                exact = FALSE,
                inc_ext = FALSE,
                add_missing = FALSE) {
  if (!requireNamespace("bookdown", quietly = TRUE)) {
    if ("renv:shims" %in% search()) {
      install_pkg <- renv::install
    } else {
      install_pkg <- utils::install.packages
    }
    install_pkg("bookdown")
  }
  alwaysloaded:::adj_yaml(
    inc_ext = inc_ext,
    add_missing = add_missing
  )

  if (is.null(input)) {
    message("render beginning")
    sink(file.path(tempdir(), "bd.txt"))
    suppressMessages(
      bookdown::render_book(quiet = TRUE)
    )
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

    message("render complete")
  }

  suppressWarnings(sink(NULL))
  suppressWarnings(sink(NULL))

  .ob()

  suppressWarnings(sink(NULL))
  suppressWarnings(sink(NULL))

  invisible(TRUE)
}

#' @export
#' @rdname dot-kb
.kbt <- function(add_missing = FALSE) {
  kb(
    inc_ext = TRUE,
    add_missing = add_missing
  )
}

#' @title Include or exclude non-work Rmds from _bookdown.yml
adj_yaml <- function(inc_ext = FALSE, add_missing) {
  yml <- yaml::read_yaml("_bookdown.yml")
  rmd_vec <- yml$rmd_files
  rmd_vec <- rmd_vec[!grepl("^ext/", rmd_vec)]

  rmd_vec <- rmd_vec[rmd_vec != ""]
  rmd_vec <- rmd_vec[file.exists(rmd_vec)]
  if (add_missing) {
    rmd_vec_add <- setdiff(list.files(here::here(), ".Rmd$"), rmd_vec)
    rmd_vec_add <- rmd_vec_add[rmd_vec_add != ""]
    rmd_vec_add <- rmd_vec_add[file.exists(rmd_vec_add)]
    if (length(rmd_vec_add) > 0) {
      rmd_vec <- unique(
        c(rmd_vec, rmd_vec_add)
      )
      yml$rmd_files <- rmd_vec
      yaml::write_yaml(
        yml,
        file = "_bookdown.yml"
      )
    }
  }

  paper_vec <- rmd_vec[grepl("^zz-", rmd_vec)]
  topic_vec <- setdiff(rmd_vec, paper_vec)
  bib_vec <- paper_vec[grepl("zz-zz-", paper_vec)]
  paper_vec <- setdiff(paper_vec, bib_vec)
  meetings_vec <- topic_vec[grepl("zx-", topic_vec)]
  topic_vec <- setdiff(topic_vec, meetings_vec)


  if (inc_ext) {
    yml_ext <- yaml::read_yaml("ext_rmd_order.yml")
    rmd_vec_ext <- yml_ext$rmd_files
    rmd_vec_ext <- rmd_vec_ext[grepl("^ext/", rmd_vec_ext)]
    rmd_vec_ext <- rmd_vec_ext[rmd_vec != ""]
    rmd_vec_ext <- rmd_vec_ext[file.exists(rmd_vec_ext)]
    yml_ext$rmd_files <- rmd_vec_ext
    yaml::write_yaml(
      yml_ext,
      file = "ext_rmd_order.yml"
    )

    if (add_missing) {
      rmd_vec_ext_add <- setdiff(
        paste0("ext/", list.files(here::here("ext"), ".Rmd$")),
        rmd_vec_ext
      )
      rmd_vec_ext_add <- rmd_vec_ext_add[rmd_vec_ext_add != ""]
      rmd_vec_ext_add <- rmd_vec_ext_add[file.exists(rmd_vec_ext_add)]
      if (length(rmd_vec_ext_add) > 0) {
        rmd_vec_ext <- unique(
          c(rmd_vec_ext, rmd_vec_ext_add)
        )
        yml_ext$rmd_files <- rmd_vec_ext
        yaml::write_yaml(
          yml_ext,
          file = "ext_rmd_order.yml"
        )
      }
    }

    if (length(rmd_vec_ext) > 0) {
      paper_vec_ext <- rmd_vec_ext[grepl("^ext/zz-", rmd_vec_ext)]
      topic_vec_ext <- setdiff(rmd_vec_ext, paper_vec_ext)
      bib_vec_ext <- paper_vec_ext[grepl("ext/zz-zz-", paper_vec_ext)]
      meetings_vec_ext <- topic_vec_ext[grepl("ext/zx-", topic_vec_ext)]
      paper_vec_ext <- setdiff(paper_vec_ext, bib_vec)

      topic_vec <- c(
        topic_vec,
        topic_vec_ext
      )
      meetings_vec <- c(
        meetings_vec,
        meetings_vec_ext
      )
      paper_vec <- c(
        paper_vec,
        paper_vec_ext
      )
      bib_vec <- c(
        bib_vec,
        bib_vec_ext
      )
    }
  }

  rmd_vec <- c(
    topic_vec,
    meetings_vec,
    paper_vec,
    bib_vec
  )

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
.ob <- function(exact = FALSE, ind = 1) {
  bd_settings_list <- yaml::read_yaml(here::here("_bookdown.yml"))

  path_book <- file.path(
    here::here(), bd_settings_list$output_dir, "index.html"
  )
  utils::browseURL(path_book)
  invisible(path_book)
}
