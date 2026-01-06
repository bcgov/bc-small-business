# Copyright {YYYY} {COPYRIGHT_HOLDER}
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

library(tidyverse)
library(fs)

lan <- config::get("lan")

## Add new year of data to file_names
file_names <- c(
  `2023` = path(lan, "Small Business Profile", "Annual 2023", "Data", "bc-small-business-profile-data-2023.xlsx"),
  `2024` = path(lan, "Small Business Profile", "Annual 2024", "Data", "bc-small-business-profile-data-2024.xlsx"),
  `2025` = path(lan, "Small Business Profile", "Annual 2025", "Data", "bc-small-business-profile-data-2025.xlsx")
)

## Copy files from lan to app/data (if they do not already exist)
walk(names(file_names),~ {
  new_file_name <- path("app", "data", paste0("bc-small-business-profile-data-", .x, ".xlsx"))
  if(!file.exists(new_file_name)) {
    file_copy(
      path = file_names[[.x]],
      new_path = new_file_name,
      overwrite = FALSE
    )
  } else { print(paste(.x, "file already exists, not copying from LAN"))}
})


