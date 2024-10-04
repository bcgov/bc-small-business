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

header <- htmltools::tagList(
  ## HEADER STYLES
  htmltools::tags$head(htmltools::tags$style(htmltools::HTML('#header_col {background-color:#003366; border-bottom:2px solid #fcba19; position:fixed; z-index:10000;"}'))),
  htmltools::tags$head(htmltools::tags$style(htmltools::HTML('.header {padding:0 0px 0 0px; display:flex; height:80px; width:100%;}'))),
  htmltools::tags$head(htmltools::tags$style(htmltools::HTML('.banner {width:100%; display:flex; justify-content:flex-start; align-items:center; margin: 0 10px 0 10px}'))),
  htmltools::tags$head(htmltools::tags$style(htmltools::HTML('#app_title {font-weight:400; color:white; margin: 5px 5px 0 18px;}'))),
  htmltools::tags$head(htmltools::tags$style(htmltools::HTML('.searchbar {margin-left:auto; margin-right:0;width:250px;padding-top:20px}'))),
  htmltools::tags$head(htmltools::tags$style(htmltools::HTML('.link_list_div {margin-right:0;}'))),

  ## BANNER START
  shiny::column(id = "header_col",
                width = 12,
                htmltools::tags$header(
                  class="header",
                  htmltools::tags$div(
                    class="banner",

                    ## BCSTATS LOGO
                    htmltools::a(href= "https://www2.gov.bc.ca/gov/content/data/about-data-management/bc-stats",
                                 onclick="gtag",
                                 htmltools::img(src = "bcstats_logo_rev.png",
                                                title = "BC Stats",
                                                height = "80px",
                                                alt = "British Columbia - BC Stats")),

                    ## APP TITLE
                    shiny::h1(id = "app_title", "Small Business Profile"),

                    ## SEARCH BAR
                    htmltools::tags$div(
                      class = "searchbar",
                      shiny::selectizeInput(inputId = "searchbar",
                                           label = NULL,
                                           multiple = TRUE,
                                           choices = search_terms$searchterm,
                                           options = list(create = FALSE,
                                                          placeholder = "Search Profile      ",
                                                          onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
                                                          onType = I("function (str) {if (str === \"\") {this.close();}}"),
                                                          onItemAdd = I("function() {this.close();}")))),

                    ## MODULE CODE FOR LINK LIST
                    htmltools::tags$div(
                      class = "link_list_div",
                      shiny::uiOutput('links_yn')),

                    ## GITHUB LINK
                    htmltools::tags$a(href = "https://github.com/bcgov-c/bc-small-business",
                                      shiny::icon("github", "fa-lg"),
                                      style = "color:white")
                  ))))

