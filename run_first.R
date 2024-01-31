# Copyright 2024 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.






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

# K1 Small buiness tax rates by province, 2023 ----
data_K1 <- read_excel(excel_file, sheet = "K1", range = "a3:b13", col_names = TRUE)

# K2 Total building permits per capita, 2022 ----
data_K2 <- read_excel(excel_file, sheet = "K2", range = "a3:b13", col_names = TRUE)

# K3 Bankruptcies per 1,000 businesses, 2022 ----
data_K3 <- read_excel(excel_file, sheet = "K3", range = "a3:b13", col_names = TRUE)




# 1. Small Business Growth----

# 1.0.0 Breakdown of small businesses in British Columbia, 2022----
data_11 <- read_excel(excel_file, sheet = "1.0.0", range = "a2:h18", col_names = TRUE)


# 1.0.1 Breakdown of businesses in British Columbia, 2022 ----

data_001 <- read_excel(excel_file, sheet = "1.0.1", range = "a5:c8", col_names = TRUE)



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
data_12 <- read_excel(excel_file, sheet = "1.3a", range = "a23:c39", col_names = TRUE)
data_12$`%` <- as.numeric(data_12$`%`)


# 1.3b: Distribution of small businesses with and without employees by industry, 2022 ----
data_13 <- read_excel(excel_file, sheet = "1.3b", range = "a27:c41", col_names = TRUE)



# 1.4: Small business by industry, proportions with and without employees, 2022----
data_14 <- read_excel(excel_file, sheet = "1.4", range = "a4:f17", col_names = TRUE)
data_14 <- as.data.frame(data_14)

data_14 <- data_14[order(-data_14$`1-49 employees`),  ]

# 1.5: Number of net new small businesses - fastest growing sectors in BC, 2017-2022 ----
data_15 <- read_excel(excel_file, sheet = "1.5", range = "a15:b24", col_names = TRUE)

# 1.6 Sector growth rates for number of small businesses with employees, BC, 2017-2020 ----
data_16 <- read_excel(excel_file, sheet = "1.6", range = "a14:b23", col_names = TRUE)

# 1.7 Small businesses per capita by province, 2022 ----
data_17 <- read_excel(excel_file, sheet = "1.7", range = "a2:b12", col_names = TRUE)

# 1.8 Small business growth by province, 2017-2022 ----
data_18 <- read_excel(excel_file, sheet = "1.8", range = "a2:b12", col_names = TRUE)

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


# 1.11a Net change in number of small businesses by region, 2017-2022 ----
data_21a <- read_excel(excel_file, sheet = "1.11", range = "a3:d11", col_names = TRUE)
data_21a <- as.data.frame(data_21a)

# 1.11a Net change in number of small businesses by region, 2017-2022 ----
data_21b <- read_excel(excel_file, sheet = "1.11", range = "a3:d11", col_names = TRUE)
data_21b <- as.data.frame(data_21b)



# 2.0 Private sector employment in British Columbia by size of business, 2022 ----
data_21c <- read_excel(excel_file, sheet = "2.0", range = "a2:h8", col_names = TRUE)
## extract top headings
data_21c_headings <- data.frame(names = names(data_21c)) %>% filter(!str_detect(names, "\\.\\.\\."))
data_21c <- data_21c %>% row_to_names(1) %>% clean_names()


# 2.1 Share of total employment in British Columbia, 2022 ----
data_22 <- read_excel(excel_file, sheet = "2.1", range = "a2:c5", col_names = TRUE)
data_22$`%` <- as.numeric(data_22$`%`)


# 2.3 Share of employment by establishment size, 2022 ----
data_25 <- read_excel(excel_file, sheet = "2.3", range = "a21:c25", col_names = TRUE)
data_25$`%` <- as.numeric(data_25$`%`)

# 2.4b Year-over-year growth in private sector employment----
data_26 <- read_excel(excel_file, sheet = "2.4b", range = "j14:x17", col_names = FALSE)
data_26t <- t(data_26)
data_26_result <- as.data.frame(data_26t)
colnames(data_26_result) <- data_26_result[1, ]
data_26_result <- data_26_result[-1, ]
data_26_result <- data_26_result %>% mutate_if(is.character, function(x) as.numeric(gsub("\\..*", "", x)))


# 2.5a One-year small business employment change, by province, 2020-2021----
data_27 <- read_excel(excel_file, sheet = "2.5", range = "a2:b12", col_names = TRUE)

# 2.5b Five-year small business employment change by province, 2017-2022----
data_28 <- read_excel(excel_file, sheet = "2.5", range = "a16:b26", col_names = TRUE)

# 2.6 Small business as a per cent of private sector employment by province, 2022----
data_29 <- read_excel(excel_file, sheet = "2.6", range = "a2:b12", col_names = TRUE)

# 2.7a One-year top and bottom industries for small business employment growth in British Columbia ----
data_30 <- read_excel(excel_file, sheet = "2.7", range = "a17:d27", col_names = TRUE)

# 2.7b Two-year top and bottom industries for small business employment growth in British Columbia ----
data_31 <- read_excel(excel_file, sheet = "2.7", range = "a35:d45", col_names = TRUE)

# 2.7c Five-year top and bottom industries for small business employment growth in British Columbia ----
data_32 <- read_excel(excel_file, sheet = "2.7", range = "a3:d13", col_names = TRUE)

#data_02 <- read_excel(excel_file, sheet = "0.2", range = "a3:e6", col_names = TRUE)

# 3.01 Self-employment as a per cent of total employment by province, 2022 ----
data_38 <- read_excel(excel_file, sheet = "3.01", range = "a2:b12", col_names = TRUE)

# 3.02 Self-employment per cent change by province, 2017-2022 ----
data_39 <- read_excel(excel_file, sheet = "3.02", range = "a2:b12", col_names = TRUE)

# 3.03a  Self-employment per cent change for regions in British Columbia, 2017-2022 ----
data_40 <- read_excel(excel_file, sheet = "3.03", range = "a2:b9", col_names = TRUE)

# 3.03b  Self-employment per cent change for regions in British Columbia, 1 Year ----
data_41 <- read_excel(excel_file, sheet = "3.03", range = "a13:b20", col_names = TRUE)

# 3.1a and 3.1b plots ----
data_42 <- read_excel(excel_file, sheet = "3.1a", range = "a3:c5", col_names = TRUE)
data_42 <- data_42 %>%
  pivot_longer(cols = -type, names_to = "help_type", values_to = "counts")


# 3.2a and 3.2b plots ----
data_43 <- read_excel(excel_file, sheet = "3.2", range = "a3:c9", col_names = TRUE)
data_43 <- data_43 %>%
  pivot_longer(cols = -years, names_to = "help_type", values_to = "counts")
data_43


# 3.3  ----
data_44 <- read_excel(excel_file, sheet = "3.3", range = "a3:c9", col_names = TRUE)
data_44 <- data_44 %>%
  pivot_longer(cols = -agegroup, names_to = "emp_type", values_to = "counts")
data_44






# 3.3b Share of British Columbia workers who are self-employed, by age ----
data_35 <- read_excel(excel_file, sheet = "3.3b", range = "a3:r9", col_names = FALSE)
data_35t <- t(data_35)
data_35_result <- as.data.frame(data_35t)
colnames(data_35_result) <- data_35_result[1, ]
data_35_result <- data_35_result[-1, ]
data_35_result$years <- round(as.numeric(data_35_result$years))
data_35_result


# Plot 3.4: Proportion of self-employed who are women by province, 2022----
data_45 <- read_excel(excel_file, sheet = "3.4", range = "a2:b12", col_names = TRUE)
names(data_45) <- c("Province", "Percent")
data_45



# Plot 3.5: Distribution of small businesses with and without employees by industry, 2022 ----
data_46 <- read_excel(excel_file, sheet = "3.5", range = "a4:c12", col_names = TRUE)
data_46

# 3.6 ----
data_47 <- read_excel(excel_file, sheet = "3.6", range = "a3:g5", col_names = TRUE)
data_47 <- data_47 %>%
  pivot_longer(cols = -indig, names_to = "year", values_to = "counts")
data_47

# 3.7a  ----
data_48 <- read_excel(excel_file, sheet = "3.7", range = "a3:c10", col_names = TRUE)
data_48 <- data_48 %>%
  pivot_longer(cols = -hours, names_to = "work_week", values_to = "counts")
data_48


# 3.7b  ----
data_49 <- read_excel(excel_file, sheet = "3.7", range = "a19:c26", col_names = TRUE)
data_49 <- data_49 %>%
  pivot_longer(cols = -hours, names_to = "sex", values_to = "counts")
data_49



# 4.1 Small business contribution to GDP by province, 2021 ----
data_50 <- read_excel(excel_file, sheet = "4.1", range = "a2:b12", col_names = TRUE)


# 4.2 Changes in average annual earnings, British Columbia, 2017-2022----
data_51 <- read_excel(excel_file, sheet = "4.2", range = "a28:c30", col_names = TRUE)
data_51 <- data_51 %>%
  pivot_longer(cols = -earningstype, names_to = "help_type", values_to = "counts")




# 4.3: Distribution of small businesses with and without employees by industry, 2022 ----
data_52 <- read_excel(excel_file, sheet = "4.3", range = "a29:c45", col_names = TRUE)


# 4.4: Distribution of small businesses with and without employees by industry, 2022 ----
data_53 <- read_excel(excel_file, sheet = "4.4", range = "a28:c44", col_names = TRUE)


# 4.3: Distribution of small businesses with and without employees by industry, 2022 ----
data_54 <- read_excel(excel_file, sheet = "4.5", range = "b3:d14", col_names = TRUE)


# 4.6 Small business contribution to GDP by province, 2021 ----
data_55 <- read_excel(excel_file, sheet = "4.6", range = "a2:b12", col_names = TRUE)


# 5.1 Number of BC exporters and value of exports, 2017-2022 ----
data_60 <- read_excel(excel_file, sheet = "5.1", range = "a3:i11", col_names = TRUE)

# 5.1b Percent of BC exporters and value of exports, 2017-2022 ----
data_60b <- read_excel(excel_file, sheet = "5.1", range = "k3:q11", col_names = TRUE)


# 5.2 Number of BC exporters and value of exports, 2017-2022 ----
data_61 <- read_excel(excel_file, sheet = "5.2", range = "a3:k18", col_names = TRUE)



# 5.3 plot value share ----
data_56 <- read_excel(excel_file, sheet = "5.3", range = "a19:d21", col_names = TRUE)
data_56 <- data_56 %>%
  pivot_longer(cols = -Exporters, names_to = "bus_type", values_to = "counts")
data_56

# 5.3 plot biz share ----
data_56b <- read_excel(excel_file, sheet = "5.3", range = "a24:d26", col_names = TRUE)
data_56b <- data_56b %>%
  pivot_longer(cols = -Exporters, names_to = "bus_type", values_to = "counts")






# 5.4 Destination share of value of small business exports by province, 2022----
## don't read in total, not needed in chart
data_57 <- read_excel(excel_file, sheet = "5.4", range = "a8:i11", col_names = TRUE) %>%
  rename(category = area) %>%
  pivot_longer(-category, names_to = "area", values_to = "count") %>%
  mutate(category = fct_inorder(category))
data_57



# 5.5 Export intensity for small businesses by province, 2022 ----
data_58 <- read_excel(excel_file, sheet = "5.5", range = "a4:b11", col_names = TRUE)


# 5.04 Growth of Small Businesses in BC----
## don't read in total, not needed in chart
data_59 <- read_excel(excel_file, sheet = "5.0.4", range = "a3:n5", col_names = TRUE) %>%
  rename(category = years) %>%
  pivot_longer(-category, names_to = "years", values_to = "count") %>%
  mutate(category = fct_inorder(category))
data_59






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

