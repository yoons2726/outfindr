#'
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

