#' @title Flag Outliers using Interquartile Range (IQR)
#'
#' @description Identifies outliers based on the classic boxplot method. Observations are flagged
#' if they fall outside the fences defined by \eqn{Q1 - coef \times IQR} and \eqn{Q3 + coef \times IQR}.
#'
#' @param data A data frame containing the variable of interest.
#' @param var A character string specifying the column name in `data` to analyze.
#' @param na.rm Logical. If `TRUE`, missing values are removed before calculating quartiles.
#' @param coef Numeric. The multiplier for the IQR to determine outlier fences.
#'   Common values are 1.5 (mild outliers) or 3 (extreme outliers).
#'
#' @return A logical vector of the same length as the input column, where `TRUE` indicates an outlier.
#'
#' @keywords internal
## function calculating iqr range
iqr_outlier_flags <- function(data, var, coef = coef, na.rm = na.rm) {
  x <- data[[var]]
  q1  <- quantile(x, 0.25, na.rm = na.rm)
  q3  <- quantile(x, 0.75, na.rm = na.rm)
  iqr <- q3 - q1
  lower <- q1 - coef * iqr
  upper <- q3 + coef * iqr

  # logical vector: TRUE = outlier
  x < lower | x > upper
}
