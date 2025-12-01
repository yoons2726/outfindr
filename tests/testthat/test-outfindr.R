test_that("outfindr() flags outliers using the IQR method correctly", {
  data("heartdisease")
  test_value <- outfindr("chol",heartdisease,method="IQR")
  keep <- !is.na(heartdisease$chol)
  heartdisease <- heartdisease[keep,]
  lower <- quantile(heartdisease$chol,0.25,na.rm=T)-1.5*IQR(heartdisease$chol,na.rm=T)
  upper <- quantile(heartdisease$chol,0.75,na.rm=T)+1.5*IQR(heartdisease$chol,na.rm=T)
  logical <- heartdisease$chol<lower | heartdisease$chol>upper
  expected_value <- heartdisease[logical,]
  expect_equal(nrow(test_value),nrow(expected_value))
})
