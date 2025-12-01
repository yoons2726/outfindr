# function flagging user specified outlier
range_outlier_flags <- function(data, var, range) {
  # check if range is not null and is numeric and is a two-element vector
  if(is.null(range) | !is.numeric(range) | length(range) != 2) {
    stop("Please specify a valid range.")
  }

  x <- data[[var]]
  lower <- range[1]
  upper <- range[2]

  # Identify outliers
  x < lower | x > upper
}

