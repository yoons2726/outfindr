# oufindr
outfindr is an R package designed to help users easily identify and handle outliers in their datasets. It offers a flexible approach to anomaly detection by implementing three distinct methods: Interquartile Range (IQR), Prespecified Range, and k-Nearest Neighbors (KNN).

# Installation
You can install the development version of outfindr from GitHub with:
```{r}
# install.packages("devtools")
devtools::install_github("yoons2726/outfindr")
```

# Usage
Here is how to use the different detection methods included in the package.

## 1. IQR Method
Use the Interquartile Range to automatically detect statistical outliers. This is best for standardizing exclusion criteria based on data distribution.
```{r}
library(outfindr)

# Load UCI heart disease data
data(heartdisease)

# Detect using IQR
results_IQR <- outfindr(var = "chol", data = heartdisease, method = "IQR")

# View flagged outliers
print(results_IQR)
```

## 2. Prespecified Range Method
Filter data based on domain knowledge by setting explicit lower and upper bounds.
```{r}
# Detect values outside the range of 0 to 200
results_range <- outfindr(var = "chol", data = heartdisease, method = "range", range = c(0, 200))

# View flagged outliers
print(results_range)
```

## 3. KNN Method (k-Nearest Neighbors)
Use a distance-based approach to find anomalies that are far from their neighbors. This is particularly useful for clustering-based outlier detection.
```{r}
# Detect using KNN (e.g., looking at the 5 nearest neighbors)
results_knn <- outfindr(var = "chol", data = heartdisease, method = "KNN", k = 5)

# View flagged outliers
print(results_knn)
```


# Features & Methodology
**outfindr** provides three core strategies for cleaning your data:
- **IQR (Interquartile Range)**: Calculates the spread of the middle 50% of your data. Points falling far outside this range (typically $1.5 \times IQR$) are flagged. This is a robust statistical method for univariate data.
- **Prespecified Range**: Allows the user to manually define "safe" limits. Any data point falling outside these specific minimum and maximum values is flagged. Ideal for data with known physical or logical limits (e.g., age cannot be negative).
- **KNN (k-Nearest Neighbors)**: An unsupervised machine learning approach. It calculates the average distance of a data point to its $k$ nearest neighbors. Points with the largest average distances are considered outliers.


