
<!-- README.md is generated from README.Rmd. Please edit that file -->

# alwaysloaded

<!-- badges: start -->
<!-- badges: end -->

The goal of alwaysloaded is to provide function(s) that are attached
(via the .Rprofile file) every time R starts.

## Installation

You can install `alwaysloaded` from [GitHub](https://www.github.com)
with:

``` r
devtools::install_github("MiguelRodo/alwaysloaded")
```

## Open directory

The only function loaded at present opens a “file pane” (that’s really a
dialogue box, but can work the same way) at the present working
directory. It is a thin wrapper around `rstudioapi::selectFile` with
more useful defaults.

``` r
alwaysloaded::od()
```
