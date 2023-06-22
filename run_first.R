library(readxl)

# Read the Excel file
excel_file <- "app/data/SBP2023_Chart_data1.xlsx"
data_01 <- read_excel(excel_file, sheet = "0.1", range = "a5:c8", col_names = TRUE)
data_02 <- read_excel(excel_file, sheet = "0.2", range = "a3:e6", col_names = TRUE)
data_03 <- read_excel(excel_file, sheet = "0.3", range = "a2:e12", col_names = TRUE)

ghgfhf
data_01