% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set_vsc_setting.r
\name{.set_vsc_setting}
\alias{.set_vsc_setting}
\title{Set VSC workspace settings}
\usage{
.set_vsc_setting(
  nm,
  val_or_fn,
  path_to_settings = here::here(".vscode/settings.json"),
  update = TRUE,
  create = TRUE,
  ...
)
}
\arguments{
\item{nm}{character vector.
Elements in JSON file to adjust.}

\item{val_or_fn}{what to change the element to.
If anything other than a function,
then the list element simply changes to this.
If a function, then it is the function to apply
to matching elements.
For functions passed to
elements with pre-existing values,
the first argument
takes that pre-existing value.}

\item{update}{logical.
If \code{TRUE}, then elements whose names
match \code{nm} are changed.
Default is \code{TRUE}.}

\item{create}{logical.
If \code{TRUE}, then if there is
no pre-existing element with a given
element of \code{nm},
then an element with that name is added.
Default is \code{TRUE}.}

\item{...}{Passed on to fn.}

\item{character}{file.
Path to the VSC settings file to edit.
Default is \code{here::here(".vscode/settings.json")}.}
}
\description{
Set VSC workspace settings
}
