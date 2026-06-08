\name{dataset_registry}
\alias{dataset_registry}
\alias{available_datasets}
\alias{datasets_by_task}
\alias{load_dataset}
\title{Dataset registry helpers}
\description{
Helpers for discovering and loading datasets included in biostatlabdata.
}
\usage{
dataset_registry()

available_datasets()

datasets_by_task(task)

load_dataset(name, envir = parent.frame())
}
\arguments{
\item{task}{One of \code{"survival"}, \code{"classification"}, or \code{"regression"}.}

\item{name}{Dataset object name from \code{available_datasets()}.}

\item{envir}{Environment where the object should be loaded.}
}
\value{
\code{dataset_registry()} and \code{datasets_by_task()} return data frames.
\code{available_datasets()} returns a character vector. \code{load_dataset()}
returns the requested data frame.
}
