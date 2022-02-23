
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
devtools::install_github("MiguelRodo/alwaysloaded")
```

## Usage

### Loading standard options via .RProfile

The primary function is `run_std()`. Adding the code below to .RProfile
(access this easily using `usethis::edit_r_profile()`)) will ensure that
standard actions are performed each time R is loaded, without causing
unnecessary issues if `alwaysloaded` isn’t installed:

``` r
if (interactive()) {
  pkg_vec_installed <- utils::installed.packages()[, "Package"]
  if (!"alwaysloaded" %in% pkg_vec_installed) {
    if (!"remotes" %in% pkg_vec_installed) {
      try(utils::install.packages("remotes"))
    }
    if ("remotes" %in% utils::installed.packages()[, "Package"]) {
      try(remotes::install_github("MiguelRodo/alwaysloaded"))
      try(alwaysloaded::run_std())
      try(library(alwaysloaded))
    }
  } else {
    try(alwaysloaded::run_std())
    try(library(alwaysloaded))
  }
}
```

### `run_std()`

#### Attached CRAN package

It attaches `ggplot2`(invisibly).

#### R options

-   Sets the CRAN repository to
    `https://packagemanager.rstudio.com/all/latest`.
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
