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

# Load required libraries
library(shiny)
library(shinydashboard)
library(tidyverse)  ## for data manipulation
library(janitor)    ## for cleaning data (includes rounding functions)
library(lubridate)  ## for dates
library(ggplot2)    ## for plots
library(plotly)     ## for interactive plots
library(DT)         ## for tables
library(sf)
library(scales)

last_updated <- "October 15, 2024"

# read data
data_new <- readRDS("data/data_new.rds")
data_geo <- readRDS("data/data_geo.rds")

# get the figure titles
figs <- data_new %>%
  distinct(Topic_id, Topic) %>%
  mutate(Figure = paste0("Figure ", str_replace_all(Topic_id, "\\.0", "\\."), ":"),
         fig_text = paste(Figure, Topic)) %>%
  select(Topic_id, fig_text)

# set action button text
actionbtn_text <- "View this figure on its own"





