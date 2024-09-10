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

options(scipen = 999)

library(tidyverse)
library(openxlsx)
library(janitor)

year <- 2024

# Excel file ----
excel_file <- config::get("data_filename")

# Functions ----
remove_empty <- function (data) { ## altered from janitor::remove empty to include " " and "" as empty cells

  ## remove empty cols
  ## remove columns that have only na, " ", or empty strings for all rows
  ##   OR have only na, " ", or empty strings for "most" rows and contain the word "Source"
  ##  (some columns have source/note info for charts that need to be removed)
  ## always keep first column
  mask_keep <- colSums(is.na(data[-1]) | data[-1] == " " | data[-1] == "") != nrow(data[-1]) &
    (colSums(is.na(data[-1]) | data[-1] == " " | data[-1] == "") < nrow(data[-1]) -4 | !grepl("Source|Note|Figure", data[-1]))
  data <- data[, c(TRUE, mask_keep), drop = FALSE]


  ## remove empty rows
  mask_keep <- rowSums(is.na(data) | data == " " | data == "") != ncol(data)
  data <- data[mask_keep, , drop = FALSE]
}

rename_cols <- function(data, title_row = 1) {

  data %>%
    row_to_names(row_number = title_row) %>%
    rename(Category = 1,            ## name the first column "Category"
           Topic_id = ncol(.)-1,    ## name the second to last column "Topic_id" - defined during data read
           Topic = ncol(.))         ## name the last column "Topic"  - defined during data read
}

format <- function(data, Category2 = FALSE, Note2 = "^$") {

  ## Notes in the data generally start with either "Note:", "*", "1.", or "†"
  ## put together a regular expression to check for rows that start with these characters
  ## Note2 can be used for any edge cases that have been missed
  note_row_prefixes <- paste("Note:|^\\*|1\\.|†", Note2, sep = "|")

  data <- data %>%
    mutate(Source = filter(., str_detect(Category, "Source:")) %>% pull(Category) %>% str_remove_all("Source:(\\s)?"),
           Note = ifelse(!any(str_detect(.$Category, note_row_prefixes)), "", ## if no notes, set Note to an empty string
                         filter(., str_detect(Category, note_row_prefixes)) %>%  ## if notes, combine all into one string separated by " || "
                           pull(Category) %>%
                           paste(collapse = " || ") %>%
                           str_remove_all("Note:(\\s)?"))) %>%
    filter(!str_detect(Category, paste("Source:", note_row_prefixes, sep = "|"))) %>% ## remove source and note rows from data
    mutate(across(everything(), as.character)) ## make everything into a character for easier pivoting - not doing any math with these numbers

  if(Category2){
    data <- data %>%
      pivot_longer(-c("Topic_id","Topic", "Category", "Category2","Source", "Note"), names_to = "Variable", values_to = "Value") %>%
      select(Topic_id, Topic, Category, Category2, Variable, Value, Note, Source)
  } else{
    data <- data %>%
      pivot_longer(-c("Topic_id", "Topic", "Category","Source", "Note"), names_to = "Variable", values_to = "Value") %>%
      select(Topic_id, Topic, Category, Variable, Value, Note, Source)
  }

  data %>% mutate(across(everything(), str_trim)) ## trim leading and trailing whitespace

}

# Read data ----
sheet_names <- getSheetNames(excel_file)
## openxlsx resulted in scientific notation that could not be resolved - use xlsx package to read in data instead
excel_data_raw <- map(sheet_names, ~  openxlsx::read.xlsx(excel_file, sheet = .x) %>%
                    remove_empty() %>%     ## remove empty rows/columns
                    mutate(Topic_id = .x,  ## create topic id from sheet name
                           Topic = names(.)[1] %>% str_replace_all("\\.", " ")))  ## create topic from top left title
names(excel_data_raw) <- sheet_names

# Format tables ----

excel_data <- excel_data_raw

## 1.1 ----
excel_data$`1.1` <- excel_data_raw$`1.1` %>%
  rename_cols() %>%
  format()

## 1.2 ----
excel_data$`1.2` <- excel_data_raw$`1.2` %>%
  rename_cols() %>%
  format()

## 1.3 ----
excel_data$`1.3`<- excel_data_raw$`1.3` %>%
  rename_cols() %>%
  format()

## 1.4  ----
excel_data$`1.4` <- excel_data_raw$`1.4` %>%
  rename_cols() %>%
  format()

## 1.5 ----
excel_data$`1.5` <- excel_data_raw$`1.5` %>%
  rename_cols() %>%
  mutate(Category2 = case_when(Category == "Goods Sector" ~ "Goods Sector",
                               Category == "Services Sector" ~ "Services Sector",
                               Category == "Total" ~ "Total")) %>%
  fill(Category2) %>%
  filter(!str_detect(Category, "Goods Sector|Services Sector")) %>%
  format(Category2 = TRUE)%>%
  filter(!is.na(Value)) ## remove empty % value for TOTAL

## 1.6 ----
excel_data$`1.6` <- excel_data_raw$`1.6` %>%
  rename_cols() %>%
  format()

## 1.7 ----
excel_data$`1.7` <- excel_data_raw$`1.7` %>%
  rename_cols(2) %>%
  rename(`No paid employees amount` = 2,
         `1-49 employees amount` = 3,
         `No paid employees percent` = 5,
         `1-49 employees percent` = 6) %>%
  format()

## 1.8 ----
excel_data$`1.8` <- excel_data_raw$`1.8` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Non-Standard Sectors", "Non-Standard Sectors",NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry", Category2)) %>%
  filter(Category != "Non-Standard Sectors") %>%
  format(Category2 = TRUE)

## 1.9 ----
excel_data$`1.9` <- excel_data_raw$`1.9` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Non-Standard Sectors", "Non-Standard Sectors",NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry", Category2)) %>%
  filter(Category != "Non-Standard Sectors") %>%
  format(Category2 = TRUE)

## 1.10 ----
excel_data$`1.10` <- excel_data_raw$`1.10` %>%
  rename_cols() %>%
  format()

## 1.11 ----
excel_data$`1.11` <- excel_data_raw$`1.11` %>%
  rename_cols() %>%
  format()

## 1.12 ----
excel_data$`1.12` <- excel_data_raw$`1.12` %>%
  slice(1:9) %>% ## check this - in 2024 needed to remove chart source and description
  rename_cols() %>%
  format()

## 1.13 ----
excel_data$`1.13` <- excel_data_raw$`1.13` %>%
  rename_cols(2) %>%
  format()

## 1.14-1.15 ----
excel_data$`1.14` <- excel_data_raw$`1.14-1.15` %>%
  select(1:7, Topic_id, Topic) %>% ## check the column numbers
  rename_cols(2) %>%
  mutate(Topic_id = "1.14",
         Category2 = "Number of small businesses") %>%
  format(Category2 = TRUE)

excel_data$`1.15` <- excel_data_raw$`1.14-1.15` %>%
  select(1, 8:ncol(.)) %>% ## check the column numbers
  rename_cols(2) %>%
  mutate(Topic_id = "1.15",
         Category2 = "Change") %>%
  format(Category2 = TRUE)

excel_data$`1.14-1.15` <- NULL

## 2.1 ----
one_year_chg_dates  <- excel_data$`2.1`[1,10] %>% str_replace_all("[:space:]*\r\n", " ") ## check the correct cells are being selected
five_year_chg_dates <- excel_data$`2.1`[1,12] %>% str_replace_all("[:space:]*\r\n", " ")

excel_data$`2.1` <- excel_data_raw$`2.1` %>%
  row_to_names(2) %>%
  rename(Category = 1,
         !!sym(paste(one_year_chg_dates, names(.)[10])):= 10,
         !!sym(paste(one_year_chg_dates, names(.)[11])):= 11,
         !!sym(paste(five_year_chg_dates, names(.)[12])):= 12,
         !!sym(paste(five_year_chg_dates, names(.)[13])):= 13,
         Topic_id = ncol(.)-1,
         Topic = ncol(.)) %>%
  format() %>%
  suppressWarnings()

## 2.2 ----
excel_data$`2.2` <- excel_data_raw$`2.2` %>%
  rename_cols() %>%
  format() %>%
  filter(!is.na(Value))  ## remove empty share value for Total

## 2.3 ----
excel_data$`2.3` <- excel_data_raw$`2.3`%>%
  slice(13:17) %>% ## check row numbers - in 2024 tab contained an additional table
  remove_empty() %>%
  #row_to_names(1) %>%  ## Additional formatting needed as this was the second table on the page in 2024
  rename(Category = 1,
         Employment = 2,
         `Per cent of total` = 3) %>%
  mutate(Topic = "Share of employment by establishment size, 2023") %>%
  format()

## 2.4 ----
excel_data$`2.4` <- excel_data_raw$`2.4` %>%
  rename_cols() %>%
  mutate(Category2 = c(rep("Employment", 4), rep("Net Growth", 4), NA)) %>%
  format(Category2 = TRUE) %>%
  filter(!is.na(Value)) ## remove empty net growth value for 1996 (first year of data)

## 2.5-2.6 ----
excel_data$`2.5` <- excel_data_raw$`2.5-2.6` %>%
  select(1,5, Topic_id, Topic) %>%   ## check column numbers
  rename_cols() %>%
  mutate(Topic_id = "2.5",
         Topic = "One-year Small business employment change, by province, 2022-2023") %>% ## check years
  format()

excel_data$`2.6` <- excel_data_raw$`2.5-2.6` %>%
  select(1,6, Topic_id, Topic) %>%  ## check column numbers
  rename_cols() %>%
  mutate(Topic_id = "2.6",
         Topic = "Five-year Small business employment change, by province, 2018-2023") %>% ## check years
  format()

excel_data$`2.5-2.6` <- NULL

## 2.7 ----
excel_data$`2.7` <- excel_data_raw$`2.7` %>%
  rename_cols() %>%
  format()

## 2.8-2.10 ----
excel_data$`2.8` <- excel_data_raw$`2.8-2.10` %>%
  slice(1:12, nrow(.)-1, nrow(.)) %>%   ## check row numbers
  rename_cols() %>%
  mutate(Topic_id = "2.8",
         Category2 = ifelse(Category == "Industry Bottom five", "Industry Bottom five", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry Top five", Category2)) %>%
  filter(Category != "Industry Bottom five") %>%
  format(Category2 = TRUE)

## pull out the topic for 2.9
topic_2 <- excel_data_raw$`2.8-2.10`[excel_data_raw$`2.8-2.10` %>% pull(1) %>% str_detect("Two-year"), 1]

excel_data$`2.9` <- excel_data_raw$`2.8-2.10` %>%
  slice(c(14,25, nrow(.)-1, nrow(.))) %>%
  rename_cols() %>%
  mutate(Topic_id = "2.9",
         Topic = topic_2,
         Category2 = ifelse(Category == "Industry Bottom five", "Industry Bottom five", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry Top five", Category2)) %>%
  filter(Category != "Industry Bottom five") %>%
  format(Category2 = TRUE)

topic_5 <-  excel_data_raw$`2.8-2.10`[excel_data_raw$`2.8-2.10` %>% pull(1) %>% str_detect("Five-year"), 1]

excel_data$`2.10` <- excel_data_raw$`2.8-2.10` %>%
  slice(27:nrow(.)) %>%
  rename_cols() %>%
  mutate(Topic_id = "2.10",
         Topic = topic_5,
         Category2 = ifelse(Category == "Industry Bottom five", "Industry Bottom five", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry Top five", Category2)) %>%
  filter(Category != "Industry Bottom five") %>%
  format(Category2 = TRUE)

excel_data$`2.8-2.10` <- NULL

## 3.1 ----
excel_data$`3.1` <- excel_data_raw$`3.1` %>%
  rename_cols() %>%
  select(-`CA for chart`) %>% ## check this
  format()

## 3.2 ----
excel_data$`3.2` <- excel_data_raw$`3.2` %>%
  rename_cols(2) %>%
  select(-`CAN for chart`) %>%
  format()

## 3.3 ----
## work around because column titles in two rows
col_names <- excel_data_raw$`3.3` %>%
  slice(1:2) %>%
  summarize_all(paste, collapse = " ") %>%
  summarize_all(str_remove_all, "NA[:space:]*") %>%
  rename_cols() %>%
  names()

excel_data$`3.3` <- excel_data_raw$`3.3` %>%
  slice(3:nrow(.)) %>%
  set_names(col_names) %>%
  format()

## 3.4 ----
excel_data$`3.4`  <- excel_data_raw$`3.4` %>%
  rename_cols(2) %>%
  format()

## 3.5 ----
excel_data$`3.5` <- excel_data_raw$`3.5` %>%
  rename_cols(2) %>%
  format()

## 3.6 ----
excel_data$`3.6` <- excel_data_raw$`3.6` %>%
  rename_cols() %>%
  format()

## 3.7 ----
excel_data$`3.7` <- excel_data_raw$`3.7` %>%
  rename_cols() %>%
  format()

## 3.8 ----
excel_data$`3.8` <- excel_data_raw$`3.8` %>%
  rename_cols() %>%
  format()

## 3.9 ----
excel_data$`3.9` <- excel_data_raw$`3.9 and 3.12` %>%
  slice(1:12) %>%              ## check row numbers
  select(1:3, Topic_id, Topic) %>%
  rename_cols(2) %>%
  mutate(Topic_id = "3.9") %>%
  format()

## 3.10 ----
excel_data$`3.10` <- excel_data_raw$`3.10` %>%
  rename_cols() %>%
  format()

## 3.11 ----
excel_data$`3.11` <- excel_data_raw$`3.11` %>%
  rename_cols() %>%
  format()

## 3.12 ----
excel_data$`3.12` <- excel_data_raw$`3.9 and 3.12` %>%
  slice(13:nrow(.)) %>%         ## check row numbers
  select(1:3, Topic_id, Topic) %>% ## check row numbers
  rename_cols(3) %>%
  mutate(Topic_id = "3.12",
         Topic = "Hours worked among self-employed men and women, British Columbia, 2023") %>%
  format()

excel_data$`3.9 and 3.12` <- NULL

## 3.13 ----
excel_data$`3.13` <- excel_data_raw$`3.13` %>%
  rename_cols(2) %>%
  format()

## 4.1 ----
excel_data$`4.1` <- excel_data_raw$`4.1` %>%
  rename_cols() %>%
  format()

## 4.2 ----
excel_data$`4.2` <- excel_data_raw$`4.2` %>%
  rename_cols() %>%
  format() %>%
  filter(!is.na(Value)) ## remove empty Gap in per cent value for Per cent change

## 4.3 ----
excel_data$`4.3` <- excel_data_raw$`4.3` %>%
  rename_cols() %>%
  format()

## 4.4 ----
## work around because column titles in two rows
col_names <- excel_data_raw$`4.4` %>%
  slice(1:2) %>%
  summarize_all(paste, collapse = " ") %>%
  summarize_all(str_remove_all, "NA[:space:]*") %>%
  rename_cols() %>%
  names()

excel_data$`4.4` <- excel_data_raw$`4.4` %>%
  slice(3:nrow(.)) %>%
  set_names(col_names) %>%
  format()

## 4.5 ----
excel_data$`4.5` <- excel_data_raw$`4.5` %>%
  slice(1:13) %>%
  select(-1) %>% ## check columns
  remove_empty() %>%
  rename_cols() %>%
  format()

## 4.6 ----
excel_data$`4.6` <- excel_data_raw$`4.6` %>%
  rename_cols() %>%
  format()

## 5.1 ----
excel_data$`5.1` <- bind_rows(
  excel_data_raw$`5.1` %>%
    select(1:9, Topic_id, Topic) %>%
    rename_cols() %>%
    mutate(Category2 = ifelse(Category == "Value of exports ($millions)", "Value of exports ($millions) - Values", NA)) %>%
    fill(Category2) %>%
    mutate(Category2 = ifelse(is.na(Category2), "Number of businesses - Values", Category2)) %>%
    filter(Category != "Value of exports ($millions)") %>%
    format(Category2 = TRUE),
  excel_data_raw$`5.1` %>%
    select(1, 11:ncol(.)) %>%
    rename_cols() %>%
    mutate(Category2 = ifelse(Category == "Value of exports ($millions)", "Value of exports ($millions) - Percentages", NA)) %>%
    fill(Category2) %>%
    mutate(Category2 = ifelse(is.na(Category2), "Number of businesses - Percentages", Category2)) %>%
    filter(Category != "Value of exports ($millions)") %>%
    format(Category2 = TRUE)
)

## 5.2 ----
excel_data$`5.2` <-  bind_rows(
  excel_data$`5.2` %>%
    slice(1:15) %>%
    select(1:6, Topic_id, Topic) %>%
    rename_cols(2) %>%
    mutate(Category2 = "Number of Exporters"),
  excel_data$`5.2` %>%
    select(1,7:ncol(.)) %>%
    rename_cols(2) %>%
    mutate(Category2 = "Value of Exports ($ million)")
) %>%
  mutate(across(-c(Category, Category2, Topic_id, Topic), as.numeric)) %>%
  format(Category2 = TRUE)

## 5.3-5.4 ----
excel_data$`5.3-5.4` <- excel_data_raw$`5.3-5.4` %>%
  slice(-c(6:8)) %>%
  rename_cols(2) %>%
  mutate(Category2 = c(rep("Small business exporters", 3), rep("Large business exporters", 3), "", "")) %>%
  format(Category2 = TRUE)

## 5.5 ----
excel_data$`5.5` <- excel_data_raw$`5.5` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Share of exports", "Share of exports", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Small Bus Exports", Category2)) %>%
  filter(Category != "Share of exports") %>%
  format(Category2 = TRUE)

## 5.6 ----
excel_data$`5.6` <- excel_data_raw$`5.6` %>%
  rename_cols() %>%
  format()

## 5.7 ----
excel_data$`5.7` <- excel_data_raw$`5.7` %>%
  rename_cols() %>%
  format()

## 6.1 ----
excel_data$`6.1` <- excel_data_raw$`6.1` %>%
  rename_cols() %>%
  format()

## 6.2 ----
excel_data$`6.2` <- excel_data_raw$`6.2` %>%
  rename_cols(2) %>%
  mutate(Category2 = "Value of building permits per person") %>%
  format(Category2 = TRUE)

## 6.3 ----
excel_data$`6.3` <- excel_data_raw$`6.3` %>%
  rename_cols() %>%
  format()

# ## Appendix 1 ----
Appendix_1 <- excel_data_raw$`Appendix 1`  %>% select(-Topic_id, -Topic)
change_title <- Appendix_1[1,][!is.na(Appendix_1[1,])]

a1_header <- matrix(nrow = 2, ncol = ncol(Appendix_1)-1)
a1_header[1,1] <- names(Appendix_1)[1] %>% str_replace_all("\\.", " ")
a1_header[2,ncol(a1_header)] <- change_title

Appendix_1 <- Appendix_1 %>%
  row_to_names(2) %>%
  rename(Industry = 1) %>%
  mutate(Region = ifelse(`#` == "#", Industry, NA), .before = Industry) %>%
  fill(Region) %>%
  mutate(Region = ifelse(is.na(Region), "BRITISH COLUMBIA", Region)) %>%
  filter(`#` != "#") %>%
  mutate(`%` = scales::label_percent(accuracy = 0.000000001)(as.numeric(`%`))) ## to format as percents in csv output

write_csv(as.data.frame(a1_header), paste("Small business profile", year, "Data - Appendix 1.csv"), col_names = FALSE, na = "")
write_csv(Appendix_1, paste("Small business profile", year, "Data - Appendix 1.csv"), append = TRUE, col_names = TRUE, na = "")

 excel_data$`Appendix 1` <- NULL

# ## Appendix 2 ----
Appendix_2 <- excel_data_raw$`Appendix2`  %>% select(-Topic_id, -Topic)

a2_header <- data.frame(header =  names(Appendix_2)[1] %>%
                          str_replace_all("\\.\\.", " (") %>%
                          str_replace_all("\\.$", ")") %>%
                          str_replace_all("\\.", " "))

Appendix_2 <- Appendix_2 %>%
  row_to_names(1) %>%
  mutate_at(vars(-c(1,2)), as.numeric) %>%
  mutate_at(vars(-c(1,2)), round_half_up, digits = 1) %>%
  fill(Sex)

write_csv(a2_header,  paste("Small business profile", year, "Data - Appendix 2.csv"), col_names = FALSE, na = "")
write_csv(Appendix_2, paste("Small business profile", year, "Data - Appendix 2.csv"), append = TRUE, col_names = TRUE, na = "")

 excel_data$Appendix2 <- NULL

## Combine ----
data <- map_df(excel_data, bind_rows) %>%
  select(Topic_id, Topic, Category, Category2, Variable, Value, Note, Source) %>%
  mutate(Variable = str_replace_all(Variable, "[:space:]*\r\n", " "),
         Note = str_replace_all(Note, "“|”", '"'), ## right/left quotation marks with regular ones
         Topic_id = ifelse(nchar(Topic_id) == 3, str_replace_all(Topic_id, "\\.", "\\.0"), Topic_id)) %>% ## change ids to 1.01 and 1.10 format
  arrange(Topic_id)

write_csv(data, paste("Small business profile", year, "Data.csv"), na = "")





