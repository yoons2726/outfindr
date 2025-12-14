#' @title Flag Outliers using a User-Specified Range
#'
#' @description Identifies outliers that fall strictly outside a manually specified numerical interval.
#'
#' @param data A data frame containing the variable of interest.
#' @param var A character string specifying the column name in `data` to analyze.
#' @param range A numeric vector of length 2 (e.g., `c(min, max)`). Values smaller than
#'   `range[1]` or larger than `range[2]` are flagged as outliers.
#'
#' @return A logical vector of the same length as the input column, where `TRUE` indicates an outlier.
#'   Returns an error if `range` is not a valid two-element numeric vector.
#'
#' @keywords internal

# function flagging user specified outlier
range_outlier_flags <- function(data, var, range,na.rm=na.rm) {
  # check if range is not null and is numeric and is a two-element vector
  if(is.null(range) | !is.numeric(range) | length(range) != 2) {
    stop("Please specify a valid range.")
  }
  # handle NAs
  x <- data[[var]]
  if (na.rm) {
    keep <- !is.na(x)
    x_clean <- x[keep]
  } else {
    x_clean <- x
    keep <- rep(TRUE, length(x))
  }


  lower <- range[1]
  upper <- range[2]

  # Identify outliers
  x < lower | x > upper
}

