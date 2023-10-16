options(scipen = 999)

library(tidyverse)
library(openxlsx)
library(janitor)

# Excel file ----
excel_file <- "Small business profile 2023 Data.xlsx"

# Functions ----
remove_empty <- function (data) { ## altered from janitor::remove empty to include " " and "" as empty cells

  ## remove empty rows
  mask_keep <- rowSums(is.na(data) | data == " " | data == "") != ncol(data)
  data <- data[mask_keep, , drop = FALSE]

  ## remove empty cols
  mask_keep <- colSums(is.na(data) | data == " " | data == "") != nrow(data)
  data <- data[, mask_keep, drop = FALSE]

}

rename_cols <- function(data, title_row = 1) {

  data %>%
    row_to_names(row_number = title_row) %>%
    rename(Category = 1,
           Sheet = ncol(.))
}

format <- function(data, Category2 = FALSE, Note2 = "^$") {

  data <- data %>%
    left_join(Contents, by = c("Sheet" = "Table")) %>%
    mutate(Source = filter(., str_detect(Category, "Source:")) %>% pull(Category) %>% str_remove_all("Source:(\\s)?"),
           Note = ifelse(!any(str_detect(.$Category, paste("Note:",Note2, sep = "|"))), "",
                         filter(., str_detect(Category, paste("Note:",Note2, sep = "|"))) %>%
                           pull(Category) %>%
                           paste(collapse = " || ") %>%
                           str_remove_all("Note:(\\s)?"))) %>%
    filter(!str_detect(Category, paste("Source:", "Note:", Note2, sep = "|")))

  if(Category2){
    data <- data %>%
      pivot_longer(-c("Sheet","Topic", "Category", "Category2","Source", "Note"), names_to = "Variable", values_to = "Value") %>%
      select(Topic_id = Sheet, Topic, Category, Category2, Variable, Value, Note, Source)
  } else{
    data <- data %>%
      pivot_longer(-c("Sheet", "Topic", "Category","Source", "Note"), names_to = "Variable", values_to = "Value") %>%
      select(Topic_id = Sheet, Topic, Category, Variable, Value, Note, Source)
  }

  data <- data %>%
    mutate(Value = as.character(Value))

}

# Read data ----
sheet_names <- getSheetNames(excel_file)
## openxlsx resulted in scientific notation that could not be resolved - use xlsx package to read in data instead
excel_data <- map(sheet_names, ~  xlsx::read.xlsx(excel_file, sheetName = .x) %>% remove_empty() %>% mutate(Sheet = .x))
names(excel_data) <- sheet_names

# Contents ----
## format Contents sheet - to be joined with tables later
Contents <- excel_data$Contents %>% row_to_names(1) %>% clean_names() %>% filter(row_number() != 1) %>%
  mutate(Table = case_when(str_detect(tables, "Appendix") ~ tables,
                           row_number() %in% c(10,25,35) ~ paste0(tables, "0"),
                           TRUE ~ tables),
         Topic = str_remove_all(na, "\n")) %>%
  select(Table, Topic)

## remove Contents from excel_data
excel_data$Contents <- NULL


# Format tables ----

## 1.1 ----
excel_data$`1.1` <- excel_data$`1.1` %>%
  rename_cols(2) %>%
  format()

## 1.2 ----
excel_data$`1.2` <- excel_data$`1.2` %>%
  rename_cols() %>%
  format()

## 1.3 ----
excel_data$`1.3`<- excel_data$`1.3` %>%
  rename_cols() %>%
  format()

## 1.4  ----
excel_data$`1.4` <- excel_data$`1.4` %>%
  rename_cols() %>%
  format(Note2 = "1\\.")

## 1.5 ----
excel_data$`1.5` <- excel_data$`1.5` %>%
  rename_cols() %>%
  mutate(Category2 = case_when(Category == "Goods Sector" ~ "Goods Sector",
                               Category == "Services Sector" ~ "Services Sector",
                               Category == "Total" ~ "Total")) %>%
  fill(Category2) %>%
  filter(!str_detect(Category, "Goods Sector|Services Sector")) %>%
  format(Category2 = TRUE, Note2 = 'is comprised of the')

## 1.6 ----
excel_data$`1.6` <- excel_data$`1.6` %>%
  rename_cols() %>%
  format(Note2 = "is comprised of the")

## 1.7 ----
excel_data$`1.7` <- excel_data$`1.7` %>%
  row_to_names(2) %>%
  rename(Category = 1,
         `No paid employees amount` = 2,
         `1-49 employees amount` = 3,
         `No paid employees percent` = 5,
         `1-49 employees percent` = 6,
         Sheet = ncol(.)) %>%
  format() %>%
  suppressWarnings()

## 1.8 ----
excel_data$`1.8` <- excel_data$`1.8` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Non-Standard Sectors", "Non-Standard Sectors",NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry", Category2)) %>%
  filter(Category != "Non-Standard Sectors") %>%
  format(Category2 = TRUE)

## 1.9 ----
excel_data$`1.9` <- excel_data$`1.9` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Non-Standard Sectors", "Non-Standard Sectors",NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry", Category2)) %>%
  filter(Category != "Non-Standard Sectors") %>%
  format(Category2 = TRUE)

## 1.10 ----
excel_data$`1.10` <- excel_data$`1.10` %>%
  rename_cols() %>%
  format()

## 1.11 ----
excel_data$`1.11` <- excel_data$`1.11` %>%
  rename_cols() %>%
  format()

## 1.12 ----
excel_data$`1.12` <- excel_data$`1.12` %>%
  rename_cols() %>%
  format()

## 1.13 ----
excel_data$`1.13` <- excel_data$`1.13` %>%
  rename_cols() %>%
  format()

## 1.14-1.15 ----
excel_data$`1.14` <- excel_data$`1.14-1.15` %>%
  rename_cols() %>%
  mutate(Sheet = "1.14") %>%
  format()

excel_data$`1.15` <- excel_data$`1.14` %>%
  mutate(Topic_id = "1.15")

excel_data$`1.14-1.15` <- NULL

## 2.1 ----
change1 <- excel_data$`2.1`[1,5] %>% str_replace_all("\n", " ")
change2 <- excel_data$`2.1`[1,7] %>% str_replace_all("\n", " ")

excel_data$`2.1` <- excel_data$`2.1` %>%
  row_to_names(2) %>%
  rename(Category = 1,
         !!sym(paste(change1, names(.)[5])):= 5,
         !!sym(paste(change1, names(.)[6])):= 6,
         !!sym(paste(change2, names(.)[7])):= 7,
         !!sym(paste(change2, names(.)[8])):= 8,
         Sheet = ncol(.)) %>%
  format(Note2 = "Includes") %>%
  suppressWarnings()

## 2.2 ----
excel_data$`2.2` <- excel_data$`2.2` %>%
  rename(Category = 1,
         `Amount` = 2,
         `Per cent` = 3) %>%
  format()

## 2.3 ----
excel_data$`2.3` <- excel_data$`2.3` %>%
  rename_cols() %>%
  format()

## 2.4 ----
excel_data$`2.4` <- excel_data$`2.4` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Net growth", "Net growth", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Employment", Category2)) %>%
  filter(Category != "Net growth") %>%
  format(Category2 = TRUE)

## 2.5-2.6 ----
excel_data$`2.5` <- excel_data$`2.5-2.6` %>%
  rename_cols(2) %>%
  rename(!!sym(paste("Per cent growth", names(.[2]))):= 2) %>%
  mutate(Sheet = "2.5") %>%
  select(-3) %>%
  format()

excel_data$`2.6` <- excel_data$`2.5-2.6` %>%
  rename_cols(2) %>%
  rename(!!sym(paste("Per cent growth", names(.[2]))):= 2) %>%
  mutate(Sheet = "2.6") %>%
  select(-2) %>%
  format()

excel_data$`2.5-2.6` <- NULL

## 2.7 ----
excel_data$`2.7` <- excel_data$`2.7` %>%
  rename_cols() %>%
  format()

## 2.8-2.10 ----

periods <- excel_data$`2.8-2.10` %>%
  filter(if_any(1, is.na)) %>%
  pull(2)

excel_data$`2.8` <- excel_data$`2.8-2.10` %>%
  slice(c(2:13, 42:43)) %>%
  rename_cols() %>%
  mutate(Sheet = "2.8",
         Category2 = ifelse(Category == "Industry Bottom five", "Industry Bottom five", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry Top five", Category2)) %>%
  filter(Category != "Industry Bottom five") %>%
  format(Category2 = TRUE) %>%
  mutate(Topic = paste0(Topic, ", ", periods[1]))

excel_data$`2.9` <- excel_data$`2.8-2.10` %>%
  slice(c(16:27, 42:43)) %>%
  rename_cols() %>%
  mutate(Sheet = "2.9",
         Category2 = ifelse(Category == "Industry Bottom five", "Industry Bottom five", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry Top five", Category2)) %>%
  filter(Category != "Industry Bottom five") %>%
  format(Category2 = TRUE) %>%
  mutate(Topic = paste0(Topic, ", ", periods[1]))

excel_data$`2.10` <- excel_data$`2.8-2.10` %>%
  slice(c(30:43)) %>%
  rename_cols() %>%
  mutate(Sheet = "2.10",
         Category2 = ifelse(Category == "Industry Bottom five", "Industry Bottom five", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Industry Top five", Category2)) %>%
  filter(Category != "Industry Bottom five") %>%
  format(Category2 = TRUE) %>%
  mutate(Topic = paste0(Topic, ", ", periods[1]))

excel_data$`2.8-2.10` <- NULL

## 3.1 ----
excel_data$`3.1` <- excel_data$`3.1` %>%
  rename_cols() %>%
  format()

## 3.2 ----
excel_data$`3.2` <- excel_data$`3.2` %>%
  rename_cols() %>%
  format()

## 3.3 ----
excel_data$`3.3` <- excel_data$`3.3` %>%
  rename_cols() %>%
  format()

## 3.4-3.5 ----
excel_data$`3.4`  <- excel_data$`3.4-3.5` %>%
  rename_cols(2) %>%
  mutate(Sheet = "3.4") %>%
  format()

excel_data$`3.5` <- excel_data$`3.4` %>%
  mutate(Topic_id = "3.5")

excel_data$`3.4-3.5` <- NULL

## 3.6 ----
excel_data$`3.6` <- excel_data$`3.6` %>%
  rename_cols() %>%
  format()

## 3.7 ----
excel_data$`3.7` <- excel_data$`3.7` %>%
  rename_cols() %>%
  format()

## 3.8 ----
excel_data$`3.8` <- excel_data$`3.8` %>%
  rename_cols() %>%
  format()

## 3.9 ----
excel_data$`3.9` <- excel_data$`3.9` %>%
  rename_cols(2) %>%
  format()

## 3.10 ----
excel_data$`3.10` <- excel_data$`3.10` %>%
  rename_cols() %>%
  format()

## 3.11 ----
excel_data$`3.11` <- excel_data$`3.11` %>%
  rename_cols() %>%
  format()

## 3.12 ----
excel_data$`3.12` <- excel_data$`3.12` %>%
  rename_cols(2) %>%
  format()

## 3.13 ----
excel_data$`3.13` <- excel_data$`3.13` %>%
  rename_cols(2) %>%
  format()

## 4.1 ----
excel_data$`4.1` <- excel_data$`4.1` %>%
  rename_cols() %>%
  format()

## 4.2 ----
excel_data$`4.2` <- excel_data$`4.2` %>%
  rename_cols() %>%
  format()

## 4.3 ----
excel_data$`4.3` <- excel_data$`4.3` %>%
  rename_cols() %>%
  format()

## 4.4 ----
col_names <- excel_data$`4.4` %>%
  slice(1:2) %>%
  summarize_all(paste, collapse = " ") %>%
  rename_cols() %>%
  names()

names(excel_data$`4.4`) <- col_names

excel_data$`4.4` <- excel_data$`4.4` %>%
  slice(3:nrow(.)) %>%
  format()

## 4.5 ----
excel_data$`4.5` <- excel_data$`4.5` %>%
  rename_cols() %>%
  format()

## 4.6 ----
excel_data$`4.6` <- excel_data$`4.6` %>%
  rename_cols() %>%
  format()

## 5.1 ----
excel_data$`5.1` <- excel_data$`5.1` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Value of exports ($millions)", "Value of exports ($millions)", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Number of businesses", Category2)) %>%
  filter(Category != "Value of exports ($millions)") %>%
  mutate(temp = case_when(Category == "Small business exporters" ~  "Small bus.",
                          Category == "Large business exporters" ~ "Large bus.")) %>%
  fill(temp) %>%
  mutate(Category = ifelse(Category == "Per cent of total", paste(temp, Category), Category)) %>%
  select(-temp) %>%
  mutate(across(-c(Category, Category2, Sheet), ~suppressWarnings(as.numeric(.x)))) %>%
  format(Category2 = TRUE)

## 5.2 ----
## One Year, Five Year variables - growth rate on new line which can't be seen in csv
excel_data$`5.2` <-  bind_rows(
  excel_data$`5.2` %>%
    slice(1:15) %>%
    select(1:6, ncol(.)) %>%
    rename_cols(2) %>%
    mutate(Category2 = "Number of Exporters"),
  excel_data$`5.2` %>%
    select(1,7:ncol(.)) %>%
    rename_cols(2) %>%
    mutate(Category2 = "Value of Exports ($ million)")
) %>%
  mutate(across(-c(Category, Category2, Sheet), as.numeric)) %>%
  format(Category2 = TRUE) %>%
  mutate(Variable = str_replace_all(Variable, "\\\n", " "))


## 5.3-5.4 ----
excel_data$`5.3` <- excel_data$`5.3-5.4` %>%
  slice(c(2:5, 12:13)) %>%
  rename_cols() %>%
  mutate(Sheet = "5.3",
         Category2 = "Small business exporters") %>%
  format(Category2 = TRUE)

excel_data$`5.4` <- excel_data$`5.3-5.4` %>%
  slice(8:13) %>%
  rename_cols() %>%
  mutate(Sheet = "5.4",
         Category2 = "Large business exporters") %>%
  format(Category2 = TRUE)

excel_data$`5.3-5.4` <- NULL

## 5.5 ----
excel_data$`5.5` <- excel_data$`5.5` %>%
  rename_cols() %>%
  mutate(Category2 = ifelse(Category == "Per cent of total", "Per cent of total", NA)) %>%
  fill(Category2) %>%
  mutate(Category2 = ifelse(is.na(Category2), "Value", Category2)) %>%
  filter(Category != "Per cent of total") %>%
  format(Category2 = TRUE)

## 5.6 ----
excel_data$`5.6` <- excel_data$`5.6` %>%
  rename_cols() %>%
  format()

## 5.7 ----
excel_data$`5.7` <- excel_data$`5.7` %>%
  rename_cols() %>%
  format()

## 6.1 ----
excel_data$`6.1` <- excel_data$`6.1` %>%
  rename_cols(2) %>%
  format()

## 6.2 ----
excel_data$`6.2` <- excel_data$`6.2` %>%
  rename_cols() %>%
  format()

## 6.3 ----
excel_data$`6.3` <- excel_data$`6.3` %>%
  rename_cols() %>%
  format()

## Combine ----
excel_data$`Appendix 1` <- NULL
excel_data$Appendix2 <- NULL

data <- map_df(excel_data, bind_rows) %>%
  select(Topic_id, Topic, Category, Category2, Variable, Value, Note, Source) %>%
  mutate(Note = str_replace_all(Note, "“|”", '"'), ## right/left quotation marks with regular ones
         Topic_id = ifelse(nchar(Topic_id) == 3, str_replace_all(Topic_id, "\\.", "\\.0"), Topic_id)) %>% ## change ids to 1.01 and 1.10 format
  arrange(Topic_id)

write_csv(data, "Small business profile 2023 Data.csv", na = "")





