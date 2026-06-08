#' Return the biostatlabdata dataset registry
#'
#' @return A data frame with one row per packaged dataset.
#' @export
dataset_registry <- function() {
  biostatlab_registry
}

#' List available datasets
#'
#' @return A character vector of dataset object names.
#' @export
available_datasets <- function() {
  biostatlab_registry$name
}

#' Filter datasets by benchmark task
#'
#' @param task One of `"survival"`, `"classification"`, or `"regression"`.
#' @return A data frame containing datasets registered for `task`.
#' @export
datasets_by_task <- function(task) {
  valid_tasks <- c("survival", "classification", "regression")
  if (!is.character(task) || length(task) != 1L || !task %in% valid_tasks) {
    stop("`task` must be one of: ", paste(valid_tasks, collapse = ", "), call. = FALSE)
  }

  biostatlab_registry[biostatlab_registry$task == task, , drop = FALSE]
}

#' Load a packaged dataset by registry name
#'
#' @param name Dataset object name from [available_datasets()].
#' @param envir Environment where the object should be loaded.
#' @return The requested data frame.
#' @export
load_dataset <- function(name, envir = parent.frame()) {
  if (!is.character(name) || length(name) != 1L) {
    stop("`name` must be a single dataset name.", call. = FALSE)
  }
  if (!name %in% biostatlab_registry$name) {
    stop("Unknown dataset `", name, "`. Use available_datasets() to list names.", call. = FALSE)
  }

  data(list = name, package = "biostatlabdata", envir = envir)
  get(name, envir = envir, inherits = FALSE)
}
