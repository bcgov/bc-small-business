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

#economic regions spatial data from the B.C. Data Catalogue using the bcdata package
# https://catalogue.data.gov.bc.ca/dataset/1aebc451-a41c-496f-8b18-6f414cde93b7

library(tidyverse)
library(bcdata)
library(rmapshaper)

bcdc_get_data("1aebc451-a41c-496f-8b18-6f414cde93b7") %>%
  mutate(region = case_when(ECONOMIC_REGION_ID == 5910 ~ "Vancouver Island/ Coast",
                            ECONOMIC_REGION_ID == 5920 ~ "Mainland/ Southwest",
                            ECONOMIC_REGION_ID == 5930 ~ "Thompson - Okanagan",
                            ECONOMIC_REGION_ID == 5940 ~ "Kootenay",
                            ECONOMIC_REGION_ID == 5950 ~ "Cariboo",
                            ECONOMIC_REGION_ID == 5960 ~ "North Coast & Nechako",
                            ECONOMIC_REGION_ID == 5970 ~ "North Coast & Nechako",
                            ECONOMIC_REGION_ID == 5980 ~ "Northeast"),
         region_label = case_when(ECONOMIC_REGION_ID == 5910 ~ "Vancouver\nIsland/ Coast",
                                  ECONOMIC_REGION_ID == 5920 ~ "Mainland/Southwest",
                                  ECONOMIC_REGION_ID == 5930 ~ "Thompson-\nOkanagan",
                                  ECONOMIC_REGION_ID == 5940 ~ "Kootenay",
                                  ECONOMIC_REGION_ID == 5950 ~ "Cariboo",
                                  ECONOMIC_REGION_ID == 5960 ~ "North Coast &\nNechako",
                                  ECONOMIC_REGION_ID == 5970 ~ "North Coast &\nNechako",
                                  ECONOMIC_REGION_ID == 5980 ~ "Northeast")) %>%
  group_by(region, region_label) %>%
  summarise() %>%
  rmapshaper::ms_clip(bcmaps::bc_bound(class = "sf")) %>%
  rmapshaper::ms_simplify(keep = 0.075, sys = TRUE) %>%
  saveRDS("app/data/data_geo.rds")




