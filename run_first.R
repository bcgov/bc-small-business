library(readxl)
library(gt)
library(tidyverse)

# Read the Excel file
excel_file <- "C:/bc-small-business/app/data/SBP2023_Chart_data2.xlsx"
data_01 <- read_excel(excel_file, sheet = "0.1", range = "a5:c8", col_names = TRUE)
data_01

data_02 <- read_excel(excel_file, sheet = "0.2", range = "a3:e6", col_names = TRUE)
data_03 <- read_excel(excel_file, sheet = "0.3", range = "a2:e12", col_names = TRUE)

data_04 <- read_excel(excel_file, sheet = "0.4", range = "a3:n5", col_names = FALSE)
data_04t <- t(data_04)
data_04_result <- as.data.frame(data_04t)
colnames(data_04_result) <- data_04_result[1, ]
data_04_result <- data_04_result[-1, ]
data_04_result


data_05 <- read_excel(excel_file, sheet = "Key1", range = "a3:b12", col_names = FALSE)
data_06 <- read_excel(excel_file, sheet = "Key2", range = "a5:c15", col_names = TRUE)
data_07 <- read_excel(excel_file, sheet = "Key2", range = "a23:b33", col_names = FALSE)

data_08 <- read_excel(excel_file, sheet = "Key3", range = "a2:c12", col_names = TRUE)
data_08



data_09 <- read_excel(excel_file, sheet = "1.1", range = "a2:i8", col_names = FALSE)
data_09t <- t(data_09)
data_09_result <- as.data.frame(data_09t)
colnames(data_09_result) <- data_09_result[1, ]
data_09_result <- data_09_result[-1, ]
data_09_result






data_10 <- read_excel(excel_file, sheet = "1.2a", range = "a2:i18", col_names = TRUE)
data_11 <- read_excel(excel_file, sheet = "1.2b", range = "a2:d18", col_names = TRUE)
data_12 <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)




data_13 <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_14 <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_15 <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_16 <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_17 <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)
data_xx <- read_excel(excel_file, sheet = "x.x", range = "x2:y12", col_names = TRUE)






print(data_03)
