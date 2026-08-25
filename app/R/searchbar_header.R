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
  htmltools::tags$style(htmltools::HTML('
  /*overall header styling*/
  .bcs-header {
        background-color:#003366;
        border-bottom:2px solid #fcba19;
        position: sticky;
        top: 0;
        left: 0;
        display:flex;
        z-index: 2147483647;
        min-height: 80px;
        padding: 0;
  }
  .bcs-banner {
          width:100%;
          display:flex;
          flex-wrap: wrap;
          align-items:center;
          margin: 0 10px;
          padding: 8px 0;
  }

  /* logo styling */
  .bcs-logo {
    max-height: 60px;
  }

  /* title styling */
  .bcs-app-title {
    font-weight:700;
    color:white;
    margin: 5px 5px 0 5px;
    font-size: clamp(20px, 2.5vw, 40px); /* responsive font size */
    line-height: 1.15;
    max-width: 100%;
    overflow-wrap: break-word;
  }

  /* search bar */
  .bcs-searchbar {
    margin-top: 20px;
    margin-left:auto;
    width:240px;
  }
  .selectize-dropdown-content {
    max-height: 400px;
  }
  /* Move the dropdown arrow to the right */
  .selectize-control.single .selectize-input::after {
    right: 5px !important;
    left: auto !important;
  }

  /* links */
  .bcs-link-list {
    margin-left:0;
    width: 270px;
  }
  .selectize-input{
    padding:6px 5px;  /*reduce padding of text inside search bar and link list*/
  }

  /* github logo */
  .github-link{
    color:white;
  }

  /* changes for mobile */
  @media (max-width: 768px) {
  .bcs-logo {
    max-height: 40px;
  }

    /* change searchbar to left justified */
    .bcs-searchbar {
      width: 100px;
      margin-left:0
    }

    /*reduce padding around link list*/
    #links_yn .container-fluid {
    padding-right:5px;
    padding-left:5px;
    }
  /*reduce width of link list*/
  .bcs-link-list {
    width:240px;
  }
  }

  ')),

  ## BANNER START
  htmltools::tags$header(
    class = "bcs-header",

    htmltools::tags$div(
      class = "bcs-banner",

      ## BC STATS LOGO
      htmltools::a(
        href= "https://www2.gov.bc.ca/gov/content/data/statistics/bc-stats",
        onclick="gtag",
        htmltools::img(
          class = "bcs-logo",
          src = "bcstats_logo_rev.png",
          #height = "80px",
          alt = "BC Stats website")),

      ## APP TITLE
      htmltools::h1(
        class = "bcs-app-title",
        htmltools::tagList(
          htmltools::tags$span("Small Business Profile")
        )),

      ## SEARCH BAR
      htmltools::tags$div(
        class = "bcs-searchbar",
        shiny::selectizeInput(
          inputId = "searchbar",
          label = NULL,
          multiple = TRUE,
          choices = search_terms$searchterm,
          options = list(
            create = FALSE,
            placeholder = "Search Profile      ",
            onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
            onType = I("function (str) {if (str === \"\") {this.close();}}"),
            onItemAdd = I("function() {this.close();}"))
        )
      ),

      ## MODULE CODE FOR LINK LIST
      htmltools::tags$nav(
        class = "bcs-link-list",
        shiny::uiOutput('links_yn')),

      ## GITHUB LINK
      htmltools::a(
        class = "github-link",
        `aria-label` = "GitHub repository",
        href = "https://github.com/bcgov-c/bc-small-business",
        shiny::icon("github", "fa-lg"))
      )
    )
)


