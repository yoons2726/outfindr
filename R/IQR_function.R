## function calculating iqr range
iqr_outlier_flags <- function(data, var, na.rm = TRUE, coef = 1.5) {
  x <- data[,var]
  q1  <- quantile(x, 0.25, na.rm = na.rm)
  q3  <- quantile(x, 0.75, na.rm = na.rm)
  iqr <- q3 - q1
  lower <- q1 - coef * iqr
  upper <- q3 + coef * iqr

  # logical vector: TRUE = outlier
  x < lower | x > upper
}
