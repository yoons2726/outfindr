#' Heart Disease UCI Dataset
#'
#' @description
#' A combined dataset containing heart disease diagnosis data from four locations:
#' Cleveland, Hungary, Switzerland, and the VA Long Beach. It includes demographic,
#' clinical, and non-invasive test results used to predict the presence of heart disease.
#'
#' @format A data frame with 920 rows and 16 variables:
#' \describe{
#'   \item{id}{Unique identifier for the patient.}
#'   \item{age}{Age of the patient in years.}
#'   \item{sex}{Biological sex of the patient (\code{"Male"} or \code{"Female"}).}
#'   \item{dataset}{Origin of the patient data (\code{"Cleveland"}, \code{"Hungary"}, \code{"Switzerland"}, or \code{"VA Long Beach"}).}
#'   \item{cp}{Chest pain type. Levels include: \code{"typical angina"}, \code{"atypical angina"}, \code{"non-anginal"}, and \code{"asymptomatic"}.}
#'   \item{trestbps}{Resting blood pressure (in mm Hg on admission to the hospital).}
#'   \item{chol}{Serum cholesterol in mg/dl.}
#'   \item{fbs}{Fasting blood sugar > 120 mg/dl (\code{TRUE} or \code{FALSE}).}
#'   \item{restecg}{Resting electrocardiographic results. Levels: \code{"normal"}, \code{"st-t abnormality"}, or \code{"lv hypertrophy"}.}
#'   \item{thalch}{Maximum heart rate achieved during exercise.}
#'   \item{exang}{Exercise-induced angina (\code{TRUE} or \code{FALSE}).}
#'   \item{oldpeak}{ST depression induced by exercise relative to rest.}
#'   \item{slope}{The slope of the peak exercise ST segment. Levels: \code{"upsloping"}, \code{"flat"}, or \code{"downsloping"}.}
#'   \item{ca}{Number of major vessels (0-3) colored by fluoroscopy.}
#'   \item{thal}{Thalassemia status. Levels: \code{"normal"}, \code{"fixed defect"}, or \code{"reversable defect"}.}
#'   \item{num}{Diagnosis of heart disease (angiographic disease status). Value \code{0} indicates < 50\% diameter narrowing (no disease), while values \code{1} through \code{4} indicate distinct degrees of confirmed disease.}
#' }
#' @source
#' \url{https://archive.ics.uci.edu/dataset/45/heart+disease}
#'
#' @references
#' Janosi, A., Steinbrunn, W., Pfisterer, M., Detrano, R. (1988). Heart Disease.
#' UCI Machine Learning Repository.
#'
"heartdisease"
