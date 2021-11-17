
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

``` r
library(alwaysloaded)
```

The primary function is `run_std()`, which does all the following. Place
`alwaysloaded::run_std()` at the start of an .Rprofile file to make all
the below happen.

### `run_std()`

It attaches the `magrittr` pipe operator `%>%`, and attaches `ggplot2`
and `stringr` (invisibly).

Sets the CRAN repository to `https://cran.mirror.ac.za/`

Open File Explorer in a specified directory (or simply the current
location given by `here::here()` if unspecified).

``` r
od()
```

Open slipbox (html) from anywhere.

``` r
os()
```

Add VS Code-specific options, if running R in VS code.

``` r
add_options_vsc()
```

Adds convenience functions regarding the current R version.

``` r
# check R version
r_v()
# print text to run in PowerShell to load R in a given version
r_pst()
```

Adds convenience functions for working with `bookdown`.

``` r
# open pre-compiled book at `_book/index.html`
ob()
# knit a book and open immediately afterwards
kb()
```

Adds convenience functions for working with `devtools` (useful when
working outside RStudio).

``` r
# run devtools::document()
dd()
# run devtools::tests()
.dt()
# run devtools::load_all()
dl()
```
