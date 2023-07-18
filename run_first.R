library(readxl)
library(gt)
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(dplyr)
library(DT)
options(scipen = 999)

# Read the Excel file
excel_file <- "C:/bc-small-business/app/data/SBP2023_Chart_data2.xlsx"


# For 1. Small Business Growth

data_01 <- read_excel(excel_file, sheet = "0.1", range = "a5:d8", col_names = TRUE)
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

data_08 <- read_excel(excel_file, sheet = "Key3", range = "a2:b12", col_names = TRUE)
data_08


# 1.1 Growth of Small Businesses in BC
data_09 <- read_excel(excel_file, sheet = "1.1", range = "a2:i8", col_names = FALSE)
data_09t <- t(data_09)
data_09_result <- as.data.frame(data_09t)
colnames(data_09_result) <- data_09_result[1, ]
data_09_result <- data_09_result[-1, ]


# 1.2a Growth of BC businesses by size
data_10 <- read_excel(excel_file, sheet = "1.2a", range = "a2:i18", col_names = TRUE)

# 1.2b Breakdown of small businesses in British Columbia
data_11 <- read_excel(excel_file, sheet = "1.2b", range = "a2:d18", col_names = TRUE)

data_11 <- data_11 %>%
  mutate(## can format columns as percent with DT::datatable, but this removes the "-"s 
         ## use janitor::round_half_up to get expected rounding (round() rounds to closest even value)
         ## ignore janitor warning NAs introduced -- this is handled by the ifelse
         `Per cent of all businesses` = paste0(janitor::round_half_up(`Per cent of all businesses` * 100), "%"),
         `Per cent of small businesses` = ifelse(`Per cent of small businesses` == "-",
                                                  `Per cent of small businesses`,
                                                  paste0(janitor::round_half_up(as.numeric(`Per cent of small businesses`) * 100), "%"))) 
data_11


# Figure 1.3a: Distribution of small businesses by industry
data_12 <- read_excel(excel_file, sheet = "1.3a", range = "a2:d16", col_names = TRUE)
data_12$`%` <- as.numeric(data_12$`%`)
data_12

# Figure 1.3b: Distribution of small businesses with and without employees by industry, 2022

data_13 <- read_excel(excel_file, sheet = "1.3b", range = "a3:c17", col_names = TRUE)
data_13_result <- as.data.frame(data_13)
#print(data_13_result)
data_13_result <- data_13_result[order(-data_13_result$`Small businesses with no paid employees`),  ]
data_13_result

data_13_result <- data_13_result %>%
  mutate(`Small businesses with no paid employees` = paste0(format(round(`Small businesses with no paid employees` * 100, 1), nsmall = 1), "%"),
         `Small businesses with 1-49 employee` = paste0(format(round(`Small businesses with 1-49 employee` * 100, 1), nsmall = 1), "%"))


data_14 <- read_excel(excel_file, sheet = "1.4", range = "x2:y12", col_names = TRUE)
data_15 <- read_excel(excel_file, sheet = "1.5", range = "x2:y12", col_names = TRUE)
data_16 <- read_excel(excel_file, sheet = "1.6", range = "x2:y12", col_names = TRUE)
data_17 <- read_excel(excel_file, sheet = "1.7", range = "x2:y12", col_names = TRUE)
data_18 <- read_excel(excel_file, sheet = "1.8", range = "x2:y12", col_names = TRUE)
data_19 <- read_excel(excel_file, sheet = "1.9 and 1.10", range = "x2:y12", col_names = TRUE)
data_20 <- read_excel(excel_file, sheet = "1.11", range = "x2:y12", col_names = TRUE)
data_21 <- read_excel(excel_file, sheet = "2.1", range = "x2:y12", col_names = TRUE)
data_22 <- read_excel(excel_file, sheet = "2.2", range = "x2:y12", col_names = TRUE)
data_23 <- read_excel(excel_file, sheet = "2.3", range = "x2:y12", col_names = TRUE)
data_24 <- read_excel(excel_file, sheet = "2.4", range = "x2:y12", col_names = TRUE)
data_25 <- read_excel(excel_file, sheet = "2.4b", range = "x2:y12", col_names = TRUE)
data_26 <- read_excel(excel_file, sheet = "2.5", range = "x2:y12", col_names = TRUE)
data_27 <- read_excel(excel_file, sheet = "2.6", range = "x2:y12", col_names = TRUE)
data_28 <- read_excel(excel_file, sheet = "2.7", range = "x2:y12", col_names = TRUE)
data_29 <- read_excel(excel_file, sheet = "2.8", range = "x2:y12", col_names = TRUE)
data_30 <- read_excel(excel_file, sheet = "2.9", range = "x2:y12", col_names = TRUE)
data_31 <- read_excel(excel_file, sheet = "2.10", range = "x2:y12", col_names = TRUE)
data_32 <- read_excel(excel_file, sheet = "2.11", range = "x2:y12", col_names = TRUE)
data_33 <- read_excel(excel_file, sheet = "3.2", range = "x2:y12", col_names = TRUE)
data_34 <- read_excel(excel_file, sheet = "3.3", range = "x2:y12", col_names = TRUE)

data_35 <- read_excel(excel_file, sheet = "3.3b", range = "a3:r9", col_names = FALSE)
data_35t <- t(data_35)
data_35_result <- as.data.frame(data_35t)
colnames(data_35_result) <- data_35_result[1, ]
data_35_result <- data_35_result[-1, ]
data_35_result$years <- round(as.numeric(data_35_result$years))
data_35_result






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
