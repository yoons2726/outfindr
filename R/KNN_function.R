#' @title Flag Outliers using K-Nearest Neighbors (KNN)
#'
#' @description Identifies outliers by calculating the distance from each observation to its
#'   \eqn{k}-th nearest neighbor. Observations with distances exceeding a specified
#'   quantile threshold are flagged.
#'
#' @details This function computes a distance matrix for the selected variable. For every point,
#'   it finds the distance to the k-th nearest neighbor. It then calculates the
#'   `cutoff` quantile of these distances (e.g., the 95th percentile). Any point with a
#'   k-distance greater than this threshold is considered an outlier.
#'
#' @param data A data frame containing the variable of interest.
#' @param var A character string specifying the column name in `data` to analyze.
#'   The column must be numeric.
#' @param k Integer. The rank of the neighbor to consider (e.g., if `k=5`, the distance
#'   to the 5th nearest neighbor is used).
#' @param cutoff Numeric (0 to 1). The probability threshold for the distance distribution.
#'   Observations with a k-distance in the top (1 - cutoff) percent are flagged.
#' @param na.rm Logical. If `TRUE`, `NA` values are ignored during distance calculation
#'   but preserved in the output vector (as `NA`).
#'
#' @return A logical vector of the same length as the input column, where `TRUE` indicates an outlier.
#'
#' @keywords internal
## KNN-based outlier flags for a single variable
knn_outlier_flags <- function(data,
                              var,
                              k = k,
                              cutoff = cutoff,
                              na.rm = na.rm) {

  # allow unquoted column name: knn_outlier_flags(df, age)
 # var_name <- deparse(substitute(var))
  x <- data[[var]]

  if (!is.numeric(x)) {
    stop("Selected variable must be numeric for KNN method.")
  }

  # handle NAs
  if (na.rm) {
    keep <- !is.na(x)
    x_clean <- x[keep]
  } else {
    x_clean <- x
    keep <- rep(TRUE, length(x))
  }

  n <- length(x_clean)
  if (n <= k) {
    stop("Not enough non-missing observations for KNN (n <= k).")
  }

  ## compute pairwise distances (univariate, so just abs diff)
  # dist() also works, but this is explicit & easy to read
  dmat <- as.matrix(dist(x_clean))      # n x n, 0 on diagonal

  # distance to k-th nearest neighbour for each point
  kdist <- apply(dmat, 1, function(row) {
    sort(row)[k + 1]  # +1 because the smallest distance is 0 (self)
  })

  # threshold for being an outlier
  thr <- stats::quantile(kdist, cutoff, na.rm = TRUE)

  flags_clean <- kdist > thr   # TRUE = outlier (in clean subset)

  # put NAs back to original length
  flags <- rep(NA, length(x))
  flags[keep] <- flags_clean

  flags
}
