#' @title Find Outliers in a Dataset
#'
#' @description Flags and extracts observations that are considered outliers in a
#'   specific variable of a dataset using one of three statistical methods.
#'
#' @param var A single character string specifying the variable name from `data`
#'   to analyze.
#' @param data A data frame containing the data.
#' @param method A character string specifying the method used to flag outliers.
#'   Options are:
#'   \itemize{
#'     \item \code{"IQR"}: Uses the Interquartile Range to define boundaries.
#'     Outliers are defined as observations falling outside the interval:
#'     \deqn{[Q1 - coef \times IQR, \quad Q3 + coef \times IQR]}
#'     where IQR = Q3 - Q1.
#'     \item \code{"range"}: Uses a user-specified numeric interval.
#'     Outliers are defined as any observation strictly
#'     less than \code{range[1]} or strictly greater than \code{range[2]}.
#'     \item \code{"KNN"}: Uses K-Nearest Neighbors distance scores.
#'     Computes the distance from each observation to its
#'     \eqn{k}-th nearest neighbor. These distances are ranked, and an observation
#'     is flagged as an outlier if its distance score is above the \code{cutoff}
#'     percentile (e.g., the top 5\% of distances if \code{cutoff = 0.95}).
#'   }
#'
#' @param range A numeric vector of length 2 (min, max) specifying the acceptable interval.
#'   Required if \code{method = "range"}.
#' @param na.rm Logical. If \code{TRUE}, missing values are excluded from calculations.
#'   Default is \code{TRUE}.
#' @param coef Numeric. The multiplier used for the IQR method. Typically set to
#'   1.5 (for mild outliers) or 3.0 (for extreme outliers). Default is 1.5.
#' @param k Integer. The rank of the neighbor used to calculate distance in the KNN method.
#'   Default is 5.
#' @param cutoff Numeric (0 to 1). The quantile threshold used in the KNN method to determine
#'   which distance scores qualify as outliers. Default is 0.95.
#'
#' @return A data frame containing the subset of rows from \code{data} flagged as outliers.
#'   If no outliers are found, returns the character string "No outliers found."
#'
#' @export
#'
#' @examples
#' outfindr("chol", heartdisease, method="range", range=c(0,200))
#'
outfindr <- function(var, data, method=c("IQR","range","KNN"),
                     range=NULL, na.rm=T, coef=1.5,
                     k=5, cutoff=0.95) {
  idx <- 0
  if(method=="IQR"){idx <- iqr_outlier_flags(data,var,na.rm,coef)}
  if(method=="range"){idx <- range_outlier_flags(data,var,range)}
  if(method=="KNN"){idx <- knn_outlier_flags(data,var,k,cutoff,na.rm)}
  if(!method %in% c("IQR","range","KNN")){stop("Please specify method: IQR, range, KNN.")}
  ifelse(sum(idx,na.rm=T)==0, sprintf("No outliers found."), data[idx,])

}

