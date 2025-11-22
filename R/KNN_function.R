## KNN-based outlier flags for a single variable
knn_outlier_flags <- function(data,
                              var,
                              k = 5,
                              cutoff = 0.95,
                              na.rm = TRUE) {

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
