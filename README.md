
# alwaysloaded

<!-- badges: start -->
<!-- badges: end -->

The goal of alwaysloaded is to attach frequently-used packages and
custom R functions and set desired R options. By placing these in a
package rather than in a system- or user-wide `.Rprofile` file, these
can easily be placed into any project-specific `.Rprofile` files and
automatically updated whenever `alwaysloaded` is changed and
re-installed.

## Installation

You can install `alwaysloaded` from [GitHub](https://www.github.com)
with:

``` r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("MiguelRodo/alwaysloaded")
```

## Usage

### Loading standard options via .RProfile

The primary function is `run_std()`. Adding the code below to .RProfile
(access this easily using `usethis::edit_r_profile()`)) will ensure that
standard actions are performed each time R is loaded, without causing
unnecessary issues if `alwaysloaded` isn’t installed:

``` r
if (interactive()) {
  if (!requireNamespace("alwaysloaded", quietly = TRUE)) {
    if ("renv:shims" %in% search()) {
      install_pkg <- renv::install
    } else {
      if (!requireNamespace("remotes", quietly = TRUE)) {
        try(utils::install.packages("remotes"))
      }
      install_pkg <- remotes::install_github
    }
    install_pkg("MiguelRodo/alwaysloaded")
    rm("install_pkg")
  } 
  try(alwaysloaded::run_std())
  try(library(alwaysloaded))
}
```

### `run_std()`

#### R options

-   Sets the CRAN repository to `https://cloud.r-project.org`.
-   It sets `stringsAsFactors = FALSE`,
-   If the IDE is VS Code, then see `alwaysloaded::add_options_vsc` for
    the (many) options set there.

#### Functions added to global environment

-   It attaches the `magrittr` pipe operator `%>%` for R versions before
    4.0.0.
-   It attaches various convenience functions:
    -   `devtools`-associated functions
    -   `.kb` and `.ob` to knit and open `bookdown` output.
    -   `.od` to open a File Explorer pane at a specified directory.
    -   `.rv` to print the current R version.
    -   And several others.
