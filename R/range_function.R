
range_outlier_flags <- function(data, var, range) {
  x <- data[[var]]
  lower <- range[1]
  upper <- range[2]

  # Identify outliers
  x < lower | x > upper
}
