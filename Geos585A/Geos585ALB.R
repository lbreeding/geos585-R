library(readxl)
file_path <- "C:/Users/15203/OneDrive/Documents/GitHub/geos585-R/Geos585A/GeosTrialData.xlsx"
data <- read_excel(file_path, sheet = "treeDataTreeRO1876R", n_max = 2)
row_1 <- data[1, ]
row_2 <- data[2, ]


library(readxl)
file_path <- "C:/Users/15203/OneDrive/Documents/GitHub/geos585-R/Geos585A/GeosTrialData.xlsx"
data1 <- read_excel(file_path, sheet = "treeDataTreeRO1876R", range = "A1:XFD150")
ids <- as.character(data1[1, ])
units <- as.character(data1[2, ])
ts_data <- as.matrix(data1[-c(1,2),])





























