library(readxl)
library(gt)
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(dplyr)
library(DT)
library(bcdata)
library(rmapshaper)
library(sf)
options(scipen = 999)

## clear environment
## important for code to save data as rds file at bottom of script
rm(list = ls())

# Read the Excel file
excel_file <- "C:/bc-small-business/SBP2023_Chart_data.xlsx"


# 1. Small Business Growth----

# 1.0.0 Breakdown of small businesses in British Columbia, 2022----
data_11 <- read_excel(excel_file, sheet = "1.0.0", range = "a2:h18", col_names = TRUE)
str(data_11)

# 1.0.1 Breakdown of businesses in British Columbia, 2022 ----

data_001 <- read_excel(excel_file, sheet = "1.0.1", range = "a5:c8", col_names = TRUE)
data_001


# 1.1 Growth of Small Businesses in BC----
## don't read in total, not needed in chart
data_09 <- read_excel(excel_file, sheet = "1.1", range = "a2:i7", col_names = TRUE) %>%
   rename(category = years) %>%
   pivot_longer(-category, names_to = "years", values_to = "count") %>%
   mutate(category = fct_inorder(category))
data_09


# 1.2a Growth of BC businesses by size----
data_10 <- read_excel(excel_file, sheet = "1.2a", range = "a2:i18", col_names = TRUE)


# 1.3a: Distribution of small businesses by industry----
data_12 <- read_excel(excel_file, sheet = "1.3a", range = "a2:c17", col_names = TRUE)
data_12$`%` <- as.numeric(data_12$`%`)
data_12

# 1.3b: Distribution of small businesses with and without employees by industry, 2022 ----
data_13 <- read_excel(excel_file, sheet = "1.3b", range = "a27:c41", col_names = TRUE)
data_13


# 1.4: Small business by industry, proportions with and without employees, 2022----
data_14 <- read_excel(excel_file, sheet = "1.4", range = "a4:f17", col_names = TRUE)
data_14 <- as.data.frame(data_14)
data_14
data_14 <- data_14[order(-data_14$`1-49 employees`),  ]
data_14



# 1.5: Number of net new small businesses - fastest growing sectors in BC, 2017-2022 ----
data_15 <- read_excel(excel_file, sheet = "1.5", range = "a2:b11", col_names = TRUE)
data_15




# 1.6 Sector growth rates for number of small businesses with employees, BC, 2017-2020 ----
data_16 <- read_excel(excel_file, sheet = "1.6", range = "a3:b12", col_names = TRUE)
data_16



# 1.7 Small businesses per capita by province, 2022 ----
data_17 <- read_excel(excel_file, sheet = "1.7", range = "a2:b12", col_names = TRUE)
data_17

# 1.8 Small business growth by province, 2017-2022 ----
data_18 <- read_excel(excel_file, sheet = "1.8", range = "a2:b12", col_names = TRUE)
data_18



# 1.9 Small business and population distribution by region in British Columbia, 2022----
#data_19 <- read_excel(excel_file, sheet = "1.9 and 1.10", range = "TODO", col_names = TRUE)
data_19 <- tibble::tribble(
                               ~region, ~pop_perc,  ~sb_perc,
                             "Cariboo",    "3.2%",    "2.4%",
                            "Kootenay",    "3.1%",    "2.6%",
              "North Coast &\nNechako",    "1.9%",    "1.5%",
            "Vancouver\nIsland/ Coast",   "17.1%",    "16.2%",
                           "Northeast",    "1.4%",    "1.3%",
                 "Thompson-\nOkanagan",   "11.9%",   "12.3%",
                "Mainland/Southwest",   "61.5%",   "63.7%"
             )

#economic regions spatial data from the B.C. Data Catalogue using the bcdata package
# https://catalogue.data.gov.bc.ca/dataset/1aebc451-a41c-496f-8b18-6f414cde93b7
economic_regions <-
  bcdc_get_data("1aebc451-a41c-496f-8b18-6f414cde93b7") %>%
  mutate(geo = case_when(ECONOMIC_REGION_ID == 5910 ~ "Vancouver\nIsland/ Coast",
                         ECONOMIC_REGION_ID == 5920 ~ "Mainland/Southwest",
                         ECONOMIC_REGION_ID == 5930 ~ "Thompson-\nOkanagan",
                         ECONOMIC_REGION_ID == 5940 ~ "Kootenay",
                         ECONOMIC_REGION_ID == 5950 ~ "Cariboo",
                         ECONOMIC_REGION_ID == 5960 ~ "North Coast &\nNechako",
                         ECONOMIC_REGION_ID == 5970 ~ "North Coast &\nNechako",
                         ECONOMIC_REGION_ID == 5980 ~ "Northeast")) %>%
  group_by(geo) %>%
  summarise() %>%
  rmapshaper::ms_clip(bcmaps::bc_bound(class = "sf")) %>%
  rmapshaper::ms_simplify(keep = 0.075, sys = TRUE)

data_19 <- economic_regions %>%
  left_join(data_19, by = c("geo" = "region"))


# 1.10 Small businesses per 1,000 persons----
data_20 <- read_excel(excel_file, sheet = "1.9 and 1.10", range = "p3:q11", col_names = TRUE)
data_20 <- as.data.frame(data_20)


# 1.11 Net change in number of small businesses by region, 2017-2022 ----
data_21 <- read_excel(excel_file, sheet = "1.11", range = "a3:d11", col_names = TRUE)
data_21 <- as.data.frame(data_21)
str(data_21)


# 2.1 Share of total employment in British Columbia, 2022 ----
data_21a <- read_excel(excel_file, sheet = "2.0", range = "a17:h22", col_names = TRUE)
data_21a





#data_02 <- read_excel(excel_file, sheet = "0.2", range = "a3:e6", col_names = TRUE)


# data_04 <- read_excel(excel_file, sheet = "0.4", range = "a3:n5", col_names = FALSE)
# data_04t <- t(data_04)
# data_04_result <- as.data.frame(data_04t)
# colnames(data_04_result) <- data_04_result[1, ]
# data_04_result <- data_04_result[-1, ]
# data_04_result
#
#
# data_05 <- read_excel(excel_file, sheet = "Key1", range = "a3:b12", col_names = FALSE)
# data_06 <- read_excel(excel_file, sheet = "Key2", range = "a5:c15", col_names = TRUE)
# data_07 <- read_excel(excel_file, sheet = "Key2", range = "a23:b33", col_names = FALSE)
#
#
# data_08 <- read_excel(excel_file, sheet = "Key3", range = "a2:b12", col_names = TRUE)
# data_08
#
#
#









# # 2.1 Share of total employment in British Columbia, 2022 ----
# data_22 <- read_excel(excel_file, sheet = "2.1", range = "a2:c5", col_names = TRUE)
# data_22$`%` <- as.numeric(data_22$`%`)
# data_22
#
#
#
# # 2.2 Private sector employment in British Columbia by size of business, 2022 ----
# data_23 <- read_excel(excel_file, sheet = "2.2", range = "a3:d8", col_names = TRUE)
#
# # 2.3a Share of businesses and organizations by size, 2022 ----
# data_24 <- read_excel(excel_file, sheet = "2.3", range = "a23:c26", col_names = TRUE)
# data_24$`%` <- as.numeric(data_24$`%`)
# data_24
#
# # 2.3b Share of employment by establishment size, 2022 ----
# data_25 <- read_excel(excel_file, sheet = "2.3", range = "d21:f25", col_names = TRUE)
# data_25$`%` <- as.numeric(data_25$`%`)
# data_25
#
#
# # 2.4a TBD its a table currently ----
#
# # 2.4b Year-over-year growth in private sector employment----
# data_26 <- read_excel(excel_file, sheet = "2.4b", range = "j14:x17", col_names = FALSE)
# data_26t <- t(data_26)
# data_26t
# data_26_result <- as.data.frame(data_26t)
# colnames(data_26_result) <- data_26_result[1, ]
# data_26_result <- data_26_result[-1, ]
# data_26_result <- data_26_result %>% mutate_if(is.character, function(x) as.numeric(gsub("\\..*", "", x)))
# data_26_result
#
# # 2.5a One-year small business employment change, by province, 2020-2021----
# data_27 <- read_excel(excel_file, sheet = "2.5", range = "a2:b12", col_names = TRUE)
# data_27
#
# # 2.5b Five-year small business employment change by province, 2017-2022----
# data_28 <- read_excel(excel_file, sheet = "2.5", range = "a16:b26", col_names = TRUE)
# data_28
#
# # 2.6 Small business as a per cent of private sector employment by province, 2022----
# data_29 <- read_excel(excel_file, sheet = "2.6", range = "a2:b12", col_names = TRUE)
# data_29
#
# # 2.7a One-year top and bottom industries for small business employment growth in British Columbia ----
# data_30 <- read_excel(excel_file, sheet = "2.7", range = "a18:c27", col_names = FALSE)
# data_30
#
# # 2.7b Two-year top and bottom industries for small business employment growth in British Columbia ----
# data_31 <- read_excel(excel_file, sheet = "2.7", range = "a36:c45", col_names = FALSE)
# data_31
#
# # 2.7c Five-year top and bottom industries for small business employment growth in British Columbia ----
# data_32 <- read_excel(excel_file, sheet = "2.7", range = "a4:c13", col_names = FALSE)
# data_32
#
# # 2.8 Self-employment as a per cent of total employment by province, 2022 ----
# data_33 <- read_excel(excel_file, sheet = "2.8", range = "a2:b12", col_names = TRUE)
# data_33
#
# # 2.9 Self-employment per cent change by province, 2017-2022----
# data_34 <- read_excel(excel_file, sheet = "2.9", range = "a2:b12", col_names = TRUE)
# data_34
#
# # 2.10a Self-employment per cent change for regions in British Columbia, 2021-2022----
# data_36 <- read_excel(excel_file, sheet = "2.10", range = "a13:b20", col_names = TRUE)
# data_36
#
# # 2.10b Self-employment per cent change for regions in British Columbia, 2017-2022----
# data_37 <- read_excel(excel_file, sheet = "2.10", range = "a2:b9", col_names = TRUE)
#
# # 3.1 TABLE Number of self-employed business owners in British Columbia ----
# data_38 <- read_excel(excel_file, sheet = "3.1", range = "a3:e6", col_names = TRUE)
#
# # 3.2 Number of self-employed with paid help compared to self-employed without paid help, British Columbia, 2017-2022----
# data_39 <- read_excel(excel_file, sheet = "3.2", range = "a3:c9", col_names = TRUE)
# data_39
#
# # 3.3a Age distribution of self-employed workers compared to employees, British Columbia, 2022----
# data_40 <- read_excel(excel_file, sheet = "3.3", range = "a3:c9", col_names = TRUE)
# names(data_40) <- c("agegroup", "Employees", "self-employed")
# data_40
#
# # 3.3b Share of British Columbia workers who are self-employed, by age ----
# data_35 <- read_excel(excel_file, sheet = "3.3b", range = "a3:r9", col_names = FALSE)
# data_35t <- t(data_35)
# data_35_result <- as.data.frame(data_35t)
# colnames(data_35_result) <- data_35_result[1, ]
# data_35_result <- data_35_result[-1, ]
# data_35_result$years <- round(as.numeric(data_35_result$years))
# data_35_result
#
#
# # 3.4  Proportion of self-employed who are women by province, 2022----
# data_41 <- read_excel(excel_file, sheet = "3.4", range = "a2:b12", col_names = TRUE)
# names(data_41) <- c("Province", "Percent")
# data_41
#
# ## Save data for app ----
# ## remove unneeded environment variables
# rm(excel_file,economic_regions,data_04,data_04t,data_26,data_26t,data_35,data_35t)

## combine all dataset in environment into one list
## ls() lists everything in you environment
## get("name_of_data") returns the data
## map iterates over all the objects and appends the results to a list
all_data <- map(ls(), get)
names(all_data) <- ls()[-1]  ## removing first environment variable (should be all_data - it is important this comes first alphabetically)

saveRDS(all_data, "app/data/data.rds")
rm(list = ls())
