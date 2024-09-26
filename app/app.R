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

# Define UI
ui <-
  shiny::fluidPage(
    theme = "styles.css",
    HTML("<html lang='en'>"),
    fluidRow(

      ## Replace appname with the title that will appear in the header
      bcsapps::bcsHeaderUI(id = "header", appname = "Small Business Profile"),
      tags$head(tags$link(rel = "shortcut icon", href = "favicon.png")), ## to add BCGov favicon

      column( ## main body column ----
        width = 12,
        style = "margin-top:75px",
        dashboardPage( ## dashboard page ----
          skin = "blue",
          dashboardHeader(title = ""),
          dashboardSidebar( ## dashboard sidebar ----
            collapsed = FALSE,
            ## hide the standalone figure tab in the sidebar menu
            tags$head(tags$style(HTML("a[href = '#shiny-tab-page7']{ visibility: hidden; }"))),
            sidebarMenu(
              style = "position: fixed; overflow: visible;",
              id = "tabs", ## to be able to update with buttons on landing page
              menuItem("Home", tabName = "home", icon = icon("home")),
              menuItem("Small Business Growth", tabName = "page1", icon = icon("line-chart")),
              menuItem("Small Business Employment", tabName = "page2", icon = icon("users")),
              menuItem("Self-Employed",
                tabName = "page3", icon = icon("user"),
                menuSubItem("Main", tabName = "main"),
                menuSubItem("Women", tabName = "women"),
                menuSubItem("Indigenous people", tabName = "indigenous")),
              menuItem("Contribution to Economy", tabName = "page4", icon = icon("usd")),
              menuItem("Small Business Exports", tabName = "page5", icon = icon("truck")),
              menuItem("Other Indicators", tabName = "page6", icon = icon("file-text")),
              menuItem("Previous Reports", href = "https://llbc.ent.sirsidynix.net/client/en_GB/main/search/results?qu=small+business+profile&te=", newtab = TRUE, icon = icon("link")),
              menuItem("Small Business Resources", href = "https://www2.gov.bc.ca/gov/content/employment-business/business/small-business/resources", newtab = TRUE, icon = icon("link")),
              menuItem("Stand Alone Figures", tabName = "page7"),
              tags$div(
                style = "text-align:center;color:#b8c7ce",
                downloadButton(outputId = "download_data", "Download data as excel"),
                br(), br(), br(),
                uiOutput("update_date")
              )
            )
          ), ## end sidebar ----
          dashboardBody( ## dashboard body ----
            tabItems(  ## tabs ----
              tabItem( ## home tab start ----
                tabName = "home",
                fluidRow( # row 1 of landing page boxes
                  tags$div(
                    id = "light-blue",
                    box(
                      title = list(icon = icon("line-chart"), "Small business counts"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("<bottom>There were 534,400 businesses in B.C. in 2023. Of these,
                              98 per cent (<b>524,900</b>) were <b>small businesses with fewer
                              than 50 employees</b></bottom>."),
                        actionButton("explore1", "Explore further", icon = icon("line-chart"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("line-chart"), "Small business growth"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("Overall, there was a 4.1 per cent or <b>20,720 increase
                              in the number of small businesses in 2023</b>. Between 2018 and 2023,
                              the number of small businesses in B.C. grew by 3.2 per cent,
                              for an increase of 16,410 businesses."),
                        actionButton("explore2", "Explore further", icon = icon("line-chart"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("usd"), "Contribution to the economy"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("In 2023, <b>34 per cent</b> of B.C.’s GDP was attributable to small business activities."),
                        actionButton("explore3", "Explore further", icon = icon("usd"), class = "home-tab-btn")))
                )),
                fluidRow( # row 2 of landing page boxes
                  tags$div(
                    id = "light-blue",
                    box(
                      title = list(icon = icon("users"), "Small business employment"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("Small businesses in B.C. employed around <b>1,139,900 people</b> in 2023.
                              This accounts for 41 per cent of the workforce, or 51 per cent of private sector
                              jobs in the province."),
                        actionButton("explore4", "Explore further", icon = icon("users"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("user"), "Self-employment growth"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("In 2023, there were <b>447,800 self-employed people</b> in B.C.,
                              5.7 per cent higher than in 2022. Additionally, self-employment in B.C. grew 0.9 per cent
                              compared to 2018."),
                        actionButton("explore5", "Explore further", icon = icon("user"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("user"), "Self-employment for women"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("In 2023, <b>39.1 per cent</b> of all self-employed people in B.C. were <b>women</b>,
                              ranking fourth among provinces."),
                        actionButton("explore6", "Explore further", icon = icon("user"), class = "home-tab-btn")))
                )),
                fluidRow( # row 3 of landing page boxes
                  tags$div(
                    id = "light-blue",
                    box(
                      title = list(icon = icon("user"), "Self-employment for Indigenous people"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("In 2023, <b>10.3 per cent of all Indigenous workers were self-employed</b>,
                              compared to a self-employment rate of 16.3 per cent for non-Indigenous workers."),
                        actionButton("explore7", "Explore further", icon = icon("user"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("usd"), "Small business wages"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("Small business employees in B.C. earned an <b>average annual salary of $55,900</b> in 2023,
                              around $10,800 less than the $66,700 earned by the average large business employee."),
                        actionButton("explore8", "Explore further", icon = icon("usd"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("truck"), "Small business exporters"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        HTML("In 2023 there were <b>6,699 B.C. businesses with fewer than 50 employees</b> that
                              <b>exported goods to international destinations</b>, accounting for 86 per cent of
                              all exporting firms."),
                        actionButton("explore9", "Explore further", icon = icon("truck"), class = "home-tab-btn")))
              ))), ## home tab end ----
              tabItem( ## page 1 tab start ----
                tabName = "page1",
                fluidRow(
                  figure_list_main[c("fig1.01", "fig1.02", "fig1.03", "fig1.04",
                                     "fig1.05", "fig1.06", "fig1.07", "fig1.08",
                                     "fig1.09", "fig1.10", "fig1.11", "fig1.12",
                                     "fig1.13", "fig1.14", "fig1.15")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
              )), ## page 1 tab end ----
              tabItem( ## page 2 tab start----
                tabName = "page2",
                fluidRow(
                  figure_list_main[c("fig2.01", "fig2.02", "fig2.03", "fig2.04",
                                     "fig2.05", "fig2.06", "fig2.07", "fig2.08",
                                     "fig2.09", "fig2.10")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
              )), ## page 2 tab end ----
              tabItem( ## page 3 tab start ----
                tabName = "page3", # dummy tab needed for menu - to enable submenuitems
              ),  ## page 3 tab end ----
              tabItem( ## page 3 subtab main start ----
                tabName = "main",
                fluidRow(
                  figure_list_main[c("fig3.01", "fig3.02", "fig3.03", "fig3.04",
                                     "fig3.05", "fig3.06", "fig3.07", "fig3.08",
                                     "fig3.09")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
                  )), ## page 3 subtab main end -----
              tabItem( ## page 3 subtab women start ----
                tabName = "women",
                fluidRow(
                  figure_list_main[c("fig3.10", "fig3.11", "fig3.12")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
                )), ## page 3 subtab women end -----
              tabItem( ## page 3 subtab indigenous start ----
                tabName = "indigenous",
                fluidRow(
                  figure_list_main[c("fig3.13")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
                  )), ## page 3 subtab indigenous end ----
              tabItem( ## page 4 tab start ----
                tabName = "page4",
                fluidRow(
                  figure_list_main[c("fig4.01", "fig4.02", "fig4.03", "fig4.04",
                                     "fig4.05", "fig4.06")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
                )), ## page 4 tab end ----
              tabItem( ## page 5 tab start ----
                tabName = "page5",
                fluidRow(
                  figure_list_main[c("fig5.01", "fig5.02", "fig5.03", "fig5.04",
                                     "fig5.05", "fig5.06", "fig5.07")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
                )), ## page 5 tab end ----
              tabItem( ## page 6 tab start ----
                tabName = "page6",
                fluidRow(
                  figure_list_main[c("fig6.01", "fig6.02", "fig6.03")],
                  box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10)
                )), ## page 6 tab end ----
              tabItem( ## page 7 conditional tab start ----
                tabName = "page7",
                ## create a hidden drop down to determine which charts to display
                ## drop down will be updated programmatically
                conditionalPanel(condition = "false",
                                 selectInput("fig_selection",
                                             label = "fig_selection",
                                             choices = paste0("fig",unique(data_new$Topic_id)),
                                             multiple = TRUE)),
                fluidRow(
                  uiOutput("fig_filter")
              )) ## page 7 tab conditional end ----
            ), ## end of tabs ----
          ), ## end of dashboard body ----
        ) ## end of dashboard page ----
      ),
      bcsapps::bcsFooterUI(id = "footer")
    )
  )

# Define server logic
server <- function(input, output, session) {

  observeEvent(input$tabs, shinyjs::runjs("window.scrollTo(0,0)"))

  ## Change links to false to remove the link list from the header
  bcsapps::bcsHeaderServer(id = "header", links = TRUE)

  bcsapps::bcsFooterServer(id = "footer")



  ## update date ----
  output$update_date <- renderUI(
    paste("Last updated:", last_updated)
  )

  ## button navigation ----

  observeEvent(input$explore1, updateTabItems(session, "tabs", selected = "page1"))
  observeEvent(input$explore2, updateTabItems(session, "tabs", selected = "page1"))
  observeEvent(input$explore3, updateTabItems(session, "tabs", selected = "page4"))
  observeEvent(input$explore4, updateTabItems(session, "tabs", selected = "page2"))
  observeEvent(input$explore5, updateTabItems(session, "tabs", selected = "page2"))
  observeEvent(input$explore6, updateTabItems(session, "tabs", selected = "women"))
  observeEvent(input$explore7, updateTabItems(session, "tabs", selected = "indigenous"))
  observeEvent(input$explore8, updateTabItems(session, "tabs", selected = "page4"))
  observeEvent(input$explore9, updateTabItems(session, "tabs", selected = "page5"))

  ## standalone buttons
  observeEvent(input$btn1.01, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.01') })
  observeEvent(input$btn1.02, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.02') })
  observeEvent(input$btn1.03, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.03') })
  observeEvent(input$btn1.04, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.04') })
  observeEvent(input$btn1.05, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.05') })
  observeEvent(input$btn1.06, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.06') })
  observeEvent(input$btn1.07, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.07') })
  observeEvent(input$btn1.08, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.08') })
  observeEvent(input$btn1.09, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.09') })
  observeEvent(input$btn1.10, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.10') })
  observeEvent(input$btn1.11, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.11') })
  observeEvent(input$btn1.12, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.12') })
  observeEvent(input$btn1.13, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.13') })
  observeEvent(input$btn1.14, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.14') })
  observeEvent(input$btn1.15, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig1.15') })
  observeEvent(input$btn2.01, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.01') })
  observeEvent(input$btn2.02, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.02') })
  observeEvent(input$btn2.03, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.03') })
  observeEvent(input$btn2.04, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.04') })
  observeEvent(input$btn2.05, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.05') })
  observeEvent(input$btn2.06, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.06') })
  observeEvent(input$btn2.07, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.07') })
  observeEvent(input$btn2.08, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.08') })
  observeEvent(input$btn2.09, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.09') })
  observeEvent(input$btn2.10, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig2.10') })
  observeEvent(input$btn3.01, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.01') })
  observeEvent(input$btn3.02, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.02') })
  observeEvent(input$btn3.03, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.03') })
  observeEvent(input$btn3.04, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.04') })
  observeEvent(input$btn3.05, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.05') })
  observeEvent(input$btn3.06, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.06') })
  observeEvent(input$btn3.07, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.07') })
  observeEvent(input$btn3.08, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.08') })
  observeEvent(input$btn3.09, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.09') })
  observeEvent(input$btn3.10, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.10') })
  observeEvent(input$btn3.11, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.11') })
  observeEvent(input$btn3.12, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.12') })
  observeEvent(input$btn3.13, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig3.13') })
  observeEvent(input$btn4.01, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig4.01') })
  observeEvent(input$btn4.02, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig4.02') })
  observeEvent(input$btn4.03, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig4.03') })
  observeEvent(input$btn4.04, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig4.04') })
  observeEvent(input$btn4.05, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig4.05') })
  observeEvent(input$btn4.06, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig4.06') })
  observeEvent(input$btn5.01, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig5.01') })
  observeEvent(input$btn5.02, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig5.02') })
  observeEvent(input$btn5.03, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig5.03') })
  observeEvent(input$btn5.04, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig5.04') })
  observeEvent(input$btn5.05, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig5.05') })
  observeEvent(input$btn5.06, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig5.06') })
  observeEvent(input$btn5.07, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig5.07') })
  observeEvent(input$btn6.01, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig6.01') })
  observeEvent(input$btn6.02, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig6.02') })
  observeEvent(input$btn6.03, { updateTabItems(session, 'tabs', selected = 'page7'); updateSelectInput(session, 'fig_selection', selected = 'fig6.03') })

  output$fig_filter <- renderUI(fig_list_standalone[input$fig_selection])

  ## download button ----
  output$download_data <- downloadHandler(
    filename = "bc-small-business-profile-data.xlsx",
    content = function(file) {
      file.copy("data/bc-small-business-profile-data.xlsx", file)
    }
  )

  ## color definition ----
  custom_colors <- c(
    yellow = "#fcb814", light_green = "#95c1b2", green = "#15987b",
    light_blue = "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082",
    navy = "#143047"
  )

  custom_colors_rgb <- list(
    yellow = c(252, 184, 20), light_green = c(149, 193, 178), green = c(21, 152, 123),
    light_blue = c(146, 181, 210), med_blue = c(14, 131, 176), dark_blue = c(1, 80, 130),
    navy = c(20, 48, 71)
  )

  region_colors <- c(
    "Provincial Total" = "#000000",
    "Cariboo" = "#95c1b2", "Kootenay" = "#15987b", "Mainland/Southwest" = "#0e83b0",
    "North Coast & Nechako" = "#fcb814", "Northeast" = "#143047", "Thompson-Okanagan" = "#015082",
    "Vancouver Island/Coast" = "#92b5d2"
  )

  size_colors <- c(
    "Small Business" = "#95c1b2", "Small businesses" = "#95c1b2",
    "Small businesses with employees" = "#95c1b2",
    "Small businesses with employees (Fewer than 50)" = "#95c1b2",
    "Small businesses without employees (Self-employed without paid help)" = "#15987b",
    "Small businesses without employees" = "#15987b",
    "Large Business" = "#fcb814", "Large Businesses" = "#fcb814",
    "Large businesses" = "#fcb814", "Large Businesses (Businesses with 50 or more)" = "#fcb814",
    "Public Sector" = "#92b5d2"
  )


  # datatable1.01 ----
  ## Figure 1.1: Breakdown of businesses in British Columbia
  output$datatable1.01 <- output$datatable1.01_s <- renderDT({
    table_data <- data_new %>%
      filter(Topic_id == "1.01") %>%
      select(Category, Variable, Value) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for mixed type columns
      mutate_at(c(3, 4), ~ ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x)))) %>%
      mutate_at(c(6, 8), ~ ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x), accuracy = 0.1))) %>%
      mutate_at(c(2, 5, 7), ~ ifelse(str_detect(.x, "<"), .x, comma(as.numeric(.x)))) %>%
      suppressWarnings()

    # Create the datatable
    datatable(table_data,
      rownames = FALSE,
      colnames = c("", names(table_data)[-1]),
      ## change default class (table-striped) to cell-border (borders around all cells, no striping)
      class = "cell-border",
      options = list(
        scrollX = TRUE,
        paging = FALSE,
        dom = "t",
        ## format header
        headerCallback = JS(
          "function(thead, data, start, end, display){",
          "  $('th', thead).css('color', 'white');",
          "  $('th', thead).css('background-color', '#0e83b0');",
          "  $('th', thead).css('text-align', 'center');",
          "  $('th', thead).css('border-style', 'solid');",
          "  $('th', thead).css('border-width', '1px');",
          "  $('th', thead).css('border-color', 'white');",
          "}"
        ),
        ## column widths
        columnDefs = list(list(width = "300px", targets = 0))
      )
    ) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2, 5, 7), textAlign = "right") %>%
      formatStyle(c(3, 4, 6, 8), textAlign = "center") %>%
      formatStyle(
        columns = 1:ncol(table_data),
        ## use styleRow to select which rows to apply style
        backgroundColor = styleRow(rows = c(8, 15, 16), "#c4d6e7"),
        color = styleRow(rows = c(8, 15, 16), "#015082"),
        fontWeight = styleRow(rows = c(8, 15, 16), "bold")
      ) %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(2, 3), "30px"))
  })

  # plot1.02 ----
  ## Figure 1.2: Count of small businesses in British Columbia
  output$plot1.02 <- output$plot1.02_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.02" & Category != "Total small businesses") %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    # Create the stacked bar chart with custom colors
    plot_ly(plot_data,
      x = ~Variable,
      y = ~Value,
      color = ~Category,
      type = "bar",
      colors = custom_colors %>% unname() %>% rev(),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "", tickformat = ","),
        barmode = "relative",
        showlegend = TRUE,
        legend = list(orientation = "h", x = 0, y = 1.3),
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.03 ----
  ## Figure 1.3: Share of businesses by employment size in British Columbia
  output$plot1.03 <- output$plot1.03_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.03") %>%
      mutate(Value = as.numeric(Value))

    total_count <- prep_data %>%
      filter(Variable == "Count", Category == "Total") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Variable == "Per cent" & Category != "Total") %>%
      mutate(
        Label = percent(Value),
        Category2 = str_replace_all(Category, "\\(", "\\\n\\("),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      y = ~Category2,
      x = ~Value,
      color = ~Category,
      colors = size_colors,
      type = "bar",
      orientation = "h",
      text = ~ paste0(Category2, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        title = "",
        xaxis = list(title = "", tickformat = ".0%"),
        yaxis = list(title = ""),
        showlegend = FALSE
      ) %>%
      add_annotations( ## add requested additional info on chart
        x = 0,
        y = 0.99,
        text = paste0("<b>Total businesses and organizations = ", comma(total_count), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot1.04a ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 1 year
  output$plot1.04a <- output$plot1.04a_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "1-yr growth") %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      type = "bar",
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0,"),
        barmode = "relative",
        hovermode = "y"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.04b ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 2 year
  output$plot1.04b <- output$plot1.04b_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "2-yr growth") %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      type = "bar",
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0,"),
        barmode = "relative",
        hovermode = "y"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.04c ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 5 year
  output$plot1.04c <- output$plot1.04c_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "5-yr growth") %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      type = "bar",
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0,"),
        barmode = "relative",
        hovermode = "y"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.05 ----
  ## Figure 1.5: Distribution of small businesses by industry
  output$plot1.05 <- output$plot1.05_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.05" & Variable == "%") %>%
      select(Category, Value, Category2)

    ## Add in Goods and Service sector dummy rows
    plot_data <- bind_rows(
      data.frame(Category = "Goods Sector", Value = "0"),
      prep_data %>% filter(Category2 == "Goods Sector"),
      data.frame(Category = "Services Sector", Value = "0"),
      prep_data %>% filter(Category2 == "Services Sector")
    ) %>%
      mutate(
        Value = as.numeric(Value),
        Label = ifelse(Category %in% c("Goods Sector", "Services Sector"), "", percent(Value)),
        Category = fct_inorder(Category),
        custom_ticktext = ifelse(Category %in% c("Goods Sector", "Services Sector"),
          paste0("<span style='color: #005182'><b>", Category, "<b></span>"),
          as.character(Category)
        )
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      type = "bar",
      marker = list(color = "#005182"),
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        legend = list(orientation = "h", x = -2, y = 1.2),
        xaxis = list(title = "", tickformat = "0%"),
        yaxis = list(
          title = "",
          tickvals = ~Category,
          ticktext = ~custom_ticktext,
          autorange = "reversed"
        ),
        hovermode = "y"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.06 ----
  ## Figure 1.6: Distribution of small businesses with and without employees by industry
  output$plot1.06 <- output$plot1.06_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.06" & Category != "Overall") %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value, accuracy = 0.1),
        Variable = str_remove_all(Variable, " percent"),
        Variable_label = str_remove_all(Variable, "(Small businesses with )|( \\(([:space:]|[:graph:])*$)")
      ) %>%
      arrange(desc(Variable), desc(Value)) %>%
      mutate(
        Category = fct_inorder(Category),
        Variable = fct_inorder(Variable)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste0(Variable_label, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
        xaxis = list(title = "", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed"),
        hovermode = "y unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.07 ----
  ## Figure 1.7: Small businesses by industry, proportions with and without employees
  output$plot1.07 <- output$plot1.07_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.07" & !str_detect(Variable, "Total") & str_detect(Variable, "percent")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value, accuracy = 0.1),
        Variable = str_remove_all(Variable, " percent")
      ) %>%
      arrange(desc(Variable), desc(Value)) %>%
      mutate(
        Category = fct_inorder(Category),
        Variable = fct_inorder(Variable)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
        xaxis = list(title = "", tickformat = "0%"),
        yaxis = list(title = ""),
        barmode = "stack",
        hovermode = "y unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.08 ----
  ## Figure 1.8: Fastest-growing industries by number of net new small businesses with employees
  output$plot1.08 <- output$plot1.08_S <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.08" & nchar(Variable) > 4) %>%
      select(Category, Value, Category2) %>%
      mutate(Value = as.numeric(Value))

    ## Add in Non-Standard Sectors dummy row
    plot_data <- bind_rows(
      prep_data %>% filter(Category2 == "Industry") %>% mutate(color = "navy") %>% arrange(desc(Value)),
      data.frame(Category = "Non-Standard Sectors", Value = 0),
      prep_data %>% filter(Category2 == "Non-Standard Sectors") %>% mutate(color = "dark_blue") %>% arrange(desc(Value))
    ) %>%
      mutate(
        Label = ifelse(Category %in% c("Non-Standard Sectors"), "", comma(Value)),
        Category = fct_inorder(Category),
        custom_ticktext = ifelse(Category %in% c("Non-Standard Sectors"),
          paste0("<span style='color: #005182'><b>", Category, "<b></span>"),
          as.character(Category)
        )
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      type = "bar",
      marker = list(color = ~ custom_colors[color]),
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        legend = list(orientation = "h", x = -2, y = 1.2),
        xaxis = list(title = "", tickformat = ","),
        yaxis = list(
          title = "",
          tickvals = ~Category,
          ticktext = ~custom_ticktext,
          autorange = "reversed"
        ),
        hovermode = "y"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.09----
  ## Figure 1.9: Fastest-growing industries by per cent growth in small businesses with employees
  output$plot1.09 <- output$plot1.09_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.09" & nchar(Variable) > 4) %>%
      select(Category, Value, Category2) %>%
      mutate(Value = as.numeric(Value))

    ## Add in Non-Standard Sectors dummy row
    plot_data <- bind_rows(
      prep_data %>% filter(Category2 == "Industry") %>% mutate(color = "navy") %>% arrange(desc(Value)),
      data.frame(Category = "Non-Standard Sectors", Value = 0),
      prep_data %>% filter(Category2 == "Non-Standard Sectors") %>% mutate(color = "dark_blue") %>% arrange(desc(Value))
    ) %>%
      mutate(
        Label = ifelse(Category %in% c("Non-Standard Sectors"), "", percent(Value, accuracy = 0.1)),
        Category = fct_inorder(Category),
        custom_ticktext = ifelse(Category %in% c("Non-Standard Sectors"),
          paste0("<span style='color: #005182'><b>", Category, "<b></span>"),
          as.character(Category)
        )
      )
    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      type = "bar",
      marker = list(color = ~ custom_colors[color]),
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        legend = list(orientation = "h", x = -2, y = 1.2),
        xaxis = list(title = "", tickformat = "0%"),
        yaxis = list(
          title = "",
          tickvals = ~Category,
          ticktext = ~custom_ticktext,
          autorange = "reversed"
        ),
        hovermode = "y"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.10 ----
  ## Figure 1.10: Small businesses per 1,000 people by province
  output$plot1.10 <- output$plot1.10_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.10") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(
        Label = comma(Value),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = ","),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.55,
        y = 0.85,
        text = paste("<b>— Canadian Total:", canada_average, "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot1.11 ----
  ## Figure 1.11: Small business growth by province
  output$plot1.11 <- output$plot1.11_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.11") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.09,
        y = 0.63,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot1.12 ----
  ## Figure 1.12: Small business and population distribution by region in British Columbia
  output$plot1.12 <- output$plot1.12_s <- renderPlot({
    plot_data <- data_geo %>%
      left_join(data_new %>% filter(Topic_id == "1.12"),
        by = c("region" = "Category")
      ) %>%
      mutate(
        Value = as.numeric(Value),
        Variable = case_when(
          str_detect(Variable, "population") ~ "pop",
          str_detect(Variable, "businesses") ~ "sb"
        ),
        region = str_replace_all(region, "/ ", "/"),
        region = str_replace_all(region, " - ", "-")
      ) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(
        label = paste0(region_label, "\n", percent(sb, accuracy = 0.1), " SB\n", percent(pop, accuracy = 0.1), " population"),
        region = factor(region,
          levels = c(
            "North Coast & Nechako", "Cariboo", "Kootenay",
            "Vancouver Island/Coast", "Mainland/Southwest",
            "Thompson-Okanagan", "Northeast"
          )
        ),
        text_color = case_when(
          region %in% c("Vancouver Island/Coast", "Mainland/Southwest", "North Coast & Nechako") ~ "black",
          TRUE ~ "white"
        )
      ) %>%
      arrange(region)

    ggplot(data = plot_data) +
      geom_sf(aes(fill = region), color = "white", linewidth = 0.5) +
      geom_sf_text(aes(label = label, color = text_color),
        size = 4, lineheight = 0.8, fontface = "bold",
        ## northcoast, vi, mainland, cariboo, kootenay, t-o, northeast
        nudge_x = c(120000, -280000, 150000, -90000, 0, -10000, 20000),
        nudge_y = c(-190000, -120000, -180000, -100000, -50000, 20000, 0)
      ) +
      scale_fill_manual(values = region_colors) +
      scale_color_manual(values = c(white = "white", black = "black")) +
      theme_void() +
      theme(
        legend.position = "none",
        text = element_text(face = "bold")
      )
  })

  # plot1.13 ----
  ## Figure 1.13: Small businesses per 1,000 people by region in British Columbia
  output$plot1.13 <- output$plot1.13_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.13" & !str_detect(Category, "Total")) %>%
      filter(Variable == max(Variable)) %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Category,
      type = "bar",
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      colors = region_colors,
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        showlegend = FALSE,
        title = "",
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0,"),
        barmode = "relative"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.14 ----
  ## Figure 1.14: Number of small businesses by region
  output$plot1.14 <- output$plot1.14_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.14") %>%
      filter(Variable == max(Variable)) %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Category,
      type = "bar",
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      colors = region_colors,
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        showlegend = FALSE,
        title = "",
        yaxis = list(title = "", autorange = "reversed"),
        xaxis = list(title = "Number of Businesses", tickformat = "0,"),
        barmode = "relative"
      ) %>%
      plotly_custom_layout()
  })

  # plot1.15 ----
  ## Figure 1.15: Net change in number of small businesses by region
  output$plot1.15 <- output$plot1.15_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.15") %>%
      filter(str_detect(Variable, "Net change")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Category,
      type = "bar",
      orientation = "h",
      text = ~ paste0(Category, ": ", Label),
      colors = region_colors,
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        showlegend = FALSE,
        title = "",
        yaxis = list(title = "", autorange = "reversed"),
        xaxis = list(title = "Net Change of Businesses", tickformat = "0,"),
        barmode = "relative"
      ) %>%
      plotly_custom_layout()
  })

  # datatable2.01 ----
  ## Figure 2.1: Private sector employment in British Columbia by size of business
  output$datatable2.01 <- output$datatable2.01_s <- renderDT({
    table_data <- bind_rows(
      data_new %>% ## latest annual data
        filter(Topic_id == "2.01", nchar(Variable) == 4) %>%
        filter(Variable == max(Variable)) %>%
        select(Category, Variable, Value),
      data_new %>% ## comparison data
        filter(Topic_id == "2.01", nchar(Variable) > 4) %>%
        select(Category, Variable, Value)
    ) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for mixed type columns
      mutate_at(c(3, 4), ~ ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x), accuracy = 1))) %>%
      mutate_at(c(6, 8), ~ ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x), accuracy = 0.1))) %>%
      mutate_at(c(2, 5, 7), ~ ifelse(str_detect(.x, "<"), .x, comma(as.numeric(.x)))) %>%
      suppressWarnings()

    # create a custom table header
    h_1 <- names(table_data)[5] %>%
      str_replace(" \\(", "\\\r\\\n\\(") %>%
      str_replace("\\) [:alpha:]*", "\\)")
    h_2 <- names(table_data)[7] %>%
      str_replace(" \\(", "\\\r\\\n\\(") %>%
      str_replace("\\) [:alpha:]*", "\\)")
    heading2 <- htmltools::withTags(table(
      class = "display",
      thead(
        tr(
          th(rowspan = 2, ""),
          th(rowspan = 2, "Employment"),
          th(rowspan = 2, "Per cent of small business"),
          th(rowspan = 2, "Per cent of private sector"),
          th(colspan = 2, h_1),
          th(colspan = 2, h_2)
        ),
        tr(
          lapply(rep(c("Number", "Per cent"), 2), th)
        )
      )
    ))

    ## create a datatable
    datatable(table_data,
      container = heading2,
      rownames = FALSE,
      ## change default class (table-striped) to cell-border (borders around all cells, no striping)
      class = "cell-border",
      options = list(
        scrollX = TRUE,
        paging = FALSE,
        dom = "t",
        ## format header
        headerCallback = JS(
          "function(thead, data, start, end, display){",
          "  $('th','tr', thead).css('color', 'white');",
          "  $('th','tr', thead).css('background-color', '#0e83b0');",
          "  $('th','tr', thead).css('text-align', 'center');",
          "  $('th','tr', thead).css('border-style', 'solid');",
          "  $('th','tr', thead).css('border-width', '1px');",
          "  $('th','tr', thead).css('border-color', 'white');",
          "}"
        ),
        ## column widths
        columnDefs = list(
          list(width = "300px", targets = 0),
          list(width = "75px", targets = 3)
        )
      )
    ) %>%
      ## helper functions for formatting
      formatStyle(1:8, backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2, 5, 7), textAlign = "right") %>%
      formatStyle(c(3, 4, 6, 8), textAlign = "center") %>%
      formatStyle(
        columns = 1:8,
        ## use styleRow to select which rows to apply style
        backgroundColor = styleRow(rows = nrow(table_data), "#c4d6e7"),
        color = styleRow(rows = nrow(table_data), "#015082"),
        fontWeight = styleRow(rows = nrow(table_data), "bold")
      ) %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(2, 3), "30px"))
  })

  # plot2.02 ----
  ## Figure 2.2 Share of total employment in British Columbia
  output$plot2.02 <- output$plot2.02_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "2.02") %>%
      mutate(Value = as.numeric(Value))

    total <- prep_data %>%
      filter(Category == "Total") %>%
      filter(Variable == max(Variable)) %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Variable == "Share") %>%
      arrange(desc(Value)) %>%
      mutate(
        Label = percent(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Category,
      colors = size_colors,
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        showlegend = FALSE,
        xaxis = list(title = "Share of Total Employment", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed")
      ) %>% ## add line
      add_annotations( ## add requested additional info on chart
        x = 0,
        y = 0.99,
        text = paste("<b>Total Employment =", comma(total), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot2.03 ----
  ## Figure 2.3: Share of employment by establishment size
  output$plot2.03 <- output$plot2.03_s <- renderPlotly({
    ## pull total employement from 2.02
    total <- data_new %>%
      filter(Topic_id == "2.02" & Category == "Total") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value)) %>%
      pull(Value)

    plot_data <- data_new %>%
      filter(Topic_id == "2.03" & str_detect(Variable, "Per cent")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Category,
      colors = size_colors,
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        showlegend = FALSE,
        xaxis = list(title = "Share of Total Employment", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed")
      ) %>% ## add line
      add_annotations( ## add requested additional info on chart
        x = 0,
        y = 0.99,
        text = paste("<b>Total Employment =", comma(total), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot2.04 ----
  ## Figure 2.4: Year-over-year growth in private sector employment
  output$plot2.04 <- output$plot2.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.04" & Category2 == "Net Growth" & !str_detect(Category, "Total")) %>%
      filter(Variable > as.numeric(max(Variable)) - 14) %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value),
        Category = fct_inorder(Category)
      )

    custom_colors1 <- custom_colors[c("dark_blue", "med_blue", "yellow")] %>% unname()

    plot_ly(plot_data,
      y = ~Value,
      x = ~Variable,
      color = ~Category,
      colors = custom_colors1,
      type = "bar",
      orientation = "v",
      text = ~ paste(Category, ":", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(x = 0, y = 1, traceorder = "reversed"),
        yaxis = list(title = "Number of Jobs"),
        xaxis = list(title = ""),
        barmode = "relative",
        hovermode = "x unified",
        ## to show all label regardless of length
        hoverlabel = list(namelength = -1)
      ) %>%
      plotly_custom_layout()
  })

  # plot2.05 ----
  ## Figure 2.5: One-year small business employment change, by province
  output$plot2.05 <- output$plot2.05_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "2.05") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "% Gowth", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0,
        y = 0.59,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot2.06 ----
  ## Figure 2.6: Five-year small business employment change by province
  output$plot2.06 <- output$plot2.06_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "2.06") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "% Growth", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0,
        y = 0.59,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot2.07 ----
  ## Figure 2.7: Small business as a per cent of private sector employment by province
  output$plot2.07 <- output$plot2.07_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "2.07") %>%
      mutate(Value = as.numeric(Value) / 100)

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0,
        y = 0.95,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot2.08 ----
  ## Figure 2.8: One-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.08 <- output$plot2.08_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.08") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(
        Label = ifelse(`Net growth` > 0,
          paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, +", comma(`Net growth`), " businesses"),
          paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, ", comma(`Net growth`), " businesses")
        ),
        Category = fct_inorder(Category),
        selected_color = ifelse(str_detect(Category2, "Top"), custom_colors["yellow"], custom_colors["navy"])
      )

    plot_ly(plot_data,
      x = ~`Per cent growth`,
      y = ~Category,
      color = ~Category2,
      colors = custom_colors[c("navy", "yellow")] %>% unname(),
      type = "bar",
      text = ~Label,
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
        xaxis = list(title = "One-year growth rate in small business employment", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed")
      ) %>%
      plotly_custom_layout()
  })

  # plot2.09 ----
  ## Figure 2.9: Two-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.09 <- output$plot2.09_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.09") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(
        Label = ifelse(`Net growth` > 0,
          paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, +", comma(`Net growth`), " businesses"),
          paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, ", comma(`Net growth`), " businesses")
        ),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~`Per cent growth`,
      y = ~Category,
      color = ~Category2,
      colors = custom_colors[c("navy", "yellow")] %>% unname(),
      type = "bar",
      text = ~Label,
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
        xaxis = list(title = "Two-year growth rate in small business employment", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed")
      ) %>%
      plotly_custom_layout()
  })

  # plot2.10 ----
  ## Figure 2.10: Five-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.10 <- output$plot2.10_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.10") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(
        Label = ifelse(`Number of businesses` > 0,
          paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, +", comma(`Number of businesses`), " businesses"),
          paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, ", comma(`Number of businesses`), " businesses")
        ),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~`Per cent growth`,
      y = ~Category,
      color = ~Category2,
      colors = custom_colors[c("navy", "yellow")] %>% unname(),
      type = "bar",
      text = ~Label,
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
        xaxis = list(title = "Five-year growth rate in small business employment", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed")
      ) %>%
      plotly_custom_layout()
  })

  # plot3.01 ----
  ## Figure 3.1: Self-employment as a per cent of total employment by province
  output$plot3.01 <- output$plot3.01_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.01") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.55,
        y = 0.85,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot3.02 ----
  ## Figure 3.2: Self-employment per cent change by province
  output$plot3.02 <- output$plot3.02_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.02") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.75,
        y = 0.5,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot3.03a ----
  ## Figure 3.3a: One-year self-employment per cent change for regions in British Columbia
  output$plot3.03a <- output$plot3.03a_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.03") %>%
      filter(Variable == "1 year Per cent") %>%
      mutate(Value = as.numeric(Value))

    provincial_average <- prep_data %>%
      filter(Category == "Provincial total") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Provincial total") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Category,
      colors = region_colors,
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        showlegend = FALSE,
        xaxis = list(title = "", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed"),
        shapes = list(vline(provincial_average))
      ) %>% ## add line
      add_annotations(
        x = 0.25,
        y = .99,
        text = paste("<b>— Provincial Average =", percent(provincial_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot3.03b ----
  ## Figure 3.3b: five-year self-employment per cent change for regions in British Columbia
  output$plot3.03b <- output$plot3.03b_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.03") %>%
      filter(Variable == "5-year Per cent") %>%
      mutate(Value = as.numeric(Value))

    provincial_average <- prep_data %>%
      filter(Category == "Provincial total") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Provincial total") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Category,
      colors = region_colors,
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        showlegend = FALSE,
        xaxis = list(title = "", tickformat = "0%"),
        yaxis = list(title = "", autorange = "reversed"),
        shapes = list(vline(provincial_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.45,
        y = .99,
        text = paste("<b>— Provincial Average =", percent(provincial_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot3.04 ----
  ## Figure 3.4: Number of self-employed persons with and without paid help in British Columbia
  output$plot3.04 <- output$plot3.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.04" & str_detect(Variable, "paid help") & !str_detect(Category, "Total")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value)
      )

    plot_ly(plot_data,
      x = ~Variable,
      y = ~Value,
      color = ~Category,
      colors = custom_colors[c("yellow", "navy")] %>% unname(),
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0,"),
        barmode = "relative",
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.05 ----
  ## Figure 3.5: Number of self-employed persons in British Columbia by incorporation status
  output$plot3.05 <- output$plot3.05_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.05" & str_detect(Variable, "paid help") & !str_detect(Category, "Total")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = comma(Value)
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      color = ~Variable,
      colors = custom_colors[c("yellow", "navy")] %>% unname(),
      type = "bar",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0,"),
        barmode = "relative",
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.06 ----
  ## Figure 3.6: Number of self-employed with paid help compared to self-employed without paid help, British Columbia
  output$plot3.06 <- output$plot3.06_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.06") %>%
      mutate(
        Value = as.numeric(Value) * 1000,
        Label = comma(Value)
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      color = ~Variable,
      colors = custom_colors[c("yellow", "navy")] %>% unname(),
      type = "bar",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0,"),
        barmode = "group",
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.07 ----
  ## Figure 3.7: Age distribution of self-employed workers compared to employees, British Columbia
  output$plot3.07 <- output$plot3.07_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.07") %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(abs(Value), accuracy = 0.1),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste(Variable, ":", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0.5, y = 1.2, traceorder = "reversed"),
        yaxis = list(title = ""),
        xaxis = list(title = "", tickformat = "0%"),
        barmode = "relative"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.08 ----
  ## Figure 3.8: Share of British Columbian workers who are self-employed, by age
  output$plot3.08 <- output$plot3.08_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.08" & Category != "Total") %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(abs(Value), accuracy = 0.1),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Variable,
      y = ~Value,
      color = ~Category,
      colors = custom_colors %>% unname(),
      type = "scatter",
      mode = "lines",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        yaxis = list(title = "", tickformat = "0%"),
        xaxis = list(title = ""),
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.09 ----
  ## Figure 3.9: Hours worked, self-employed compared to employees
  output$plot3.09 <- output$plot3.09_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.09" & !str_detect(Category, "main")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(abs(Value), accuracy = 0.1),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste(Variable, ":", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
        yaxis = list(title = "", autorange = "reversed"),
        xaxis = list(title = "", tickformat = "0%"),
        barmode = "relative"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.10 ----
  ## Figure 3.10: Proportion of self-employed who are women by province
  output$plot3.10 <- output$plot3.10_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.10") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.15,
        y = 0.9,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot3.11 ----
  ## Figure 3.11: Proportion of self-employed who are women, by region
  output$plot3.11 <- output$plot3.11_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.11") %>%
      filter(Variable == max(Variable) | Variable == as.numeric(max(Variable)) - 5) %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = "", autorange = "reversed"),
        xaxis = list(title = "", tickformat = "0%"),
        hovermode = "y unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.12 ----
  ## Figure 3.12: Hours worked among self-employed men and women, British Columbia
  output$plot3.12 <- output$plot3.12_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.12" & !str_detect(Category, "main")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(abs(Value), accuracy = 0.1),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste(Variable, ":", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0.5, y = 1.2, traceorder = "normal"),
        yaxis = list(title = "", autorange = "reversed"),
        xaxis = list(title = "", tickformat = "0%"),
        barmode = "relative"
      ) %>%
      plotly_custom_layout()
  })

  # plot3.13 ----
  ## Figure 3.13: Per cent of working, off-reserve Indigenous and non-Indigenous people who are self-employed in British Columbia
  output$plot3.13 <- output$plot3.13_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.13" & Category != "Difference") %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Variable,
      y = ~Value,
      color = ~Category,
      colors = custom_colors %>% unname(),
      type = "bar",
      orientation = "v",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = "% Self-employed", tickformat = "0%"),
        xaxis = list(title = ""),
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot4.01 ----
  ## Figure 4.1: Small business contribution to GDP by province
  output$plot4.01 <- output$plot4.01_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "4.01") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(
        Label = percent(Value, accuracy = 1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.2,
        y = 0.9,
        text = paste("<b>— Canadian Average:", percent(canada_average), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot4.02 ----
  ## Figure 4.2: Changes in average annual earnings in British Columbia
  output$plot4.02 <- output$plot4.02_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "4.02" & !str_detect(Category, "Per cent")) %>%
      mutate(Value = as.numeric(Value))

    wage_gap <- prep_data %>%
      filter(str_detect(Variable, "(G|g)ap")) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(
        year = str_extract(Category, "[:digit:]{4}"),
        amount = dollar(`Small business wage gap`),
        percent = percent(`Gap in per cent`, accuracy = 0.1),
        text = paste0("<b>Wage gap ", year, " = ", amount, " (", percent, ")</b>")
      ) %>%
      pull(text)

    plot_data <- prep_data %>%
      filter(Topic_id == "4.02" & !str_detect(Variable, "(G|g)ap")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = dollar(Value),
        Category = str_extract(Category, "Earnings [:digit:]{4}"),
        Variable = fct_inorder(Variable)
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      color = ~Variable,
      colors = custom_colors %>% unname(),
      type = "bar",
      orientation = "v",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = "Thousands", tickformat = "$,"),
        xaxis = list(title = "Payroll/Employee"),
        hovermode = "x unified"
      ) %>%
      add_annotations(
        x = 0.01,
        y = 0.79,
        text = wage_gap[1],
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      add_annotations(
        x = 0.5,
        y = 0.99,
        text = wage_gap[2],
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot4.03 ----
  ## Figure 4.3: Small business average annual earnings and wage gap by industry
  output$plot4.03 <- output$plot4.03_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "4.03" & !str_detect(Variable, "(G|g)ap")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = dollar(Value),
        Variable = fct_inorder(Variable),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
        xaxis = list(title = "", tickformat = "$,"),
        yaxis = list(title = "", autorange = "reversed"),
        hovermode = "y unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot4.04 ----
  ## Figure 4.4: Small business wage gaps by industry, British Columbia
  output$plot4.04 <- output$plot4.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "4.04" & !str_detect(Variable, "Dollar")) %>%
      mutate(
        Value = as.numeric(Value),
        Label = dollar(Value, accuracy = 1),
        Variable = str_extract(Variable, "[:digit:]{4}"),
        Category = fct_inorder(Category)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
        xaxis = list(title = "", tickformat = "$,"),
        yaxis = list(title = "", autorange = "reversed"),
        hovermode = "y unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot4.05 ----
  ## Figure 4.5: Average annual earnings by province
  output$plot4.05 <- output$plot4.05_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "4.05") %>%
      mutate(
        Value = as.numeric(Value),
        Label = dollar(Value, accuracy = 1)
      ) %>%
      arrange(desc(Variable), desc(Value)) %>%
      mutate(
        Category = fct_inorder(Category),
        Variable = fct_inorder(Variable)
      )

    plot_ly(plot_data,
      x = ~Value,
      y = ~Category,
      color = ~Variable,
      colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
      type = "bar",
      orientation = "h",
      text = ~ paste0(Variable, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
        xaxis = list(title = "", tickformat = "$,"),
        yaxis = list(title = "", autorange = "reversed"),
        hovermode = "y unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot4.06 ----
  ## Figure 4.6: Small business share of total payroll by province
  output$plot4.06 <- output$plot4.06_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "4.06") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CDA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CDA") %>%
      mutate(
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "0%"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.2,
        y = 0.89,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # datatable5.01a ----
  ## Figure 5.1: Number of British Columbia exporters and value of exports, British Columbia
  ## part1: Values
  output$datatable5.01a <- output$datatable5.01a_s <- renderDT({
    prep_data <- data_new %>%
      filter(Topic_id == "5.01", str_detect(Category2, "Values")) %>%
      select(Category2, `Number of businesses` = Category, Variable, Value) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for columns
      mutate_at(c(3:8), ~ comma(as.numeric(.x))) %>%
      mutate_at(c(9:10), ~ percent(as.numeric(.x), accuracy = 0.1))

    ## add in second heading row
    heading_two <- data.frame(t(c("", "Value of exports ($millions)", names(prep_data)[3:10])))
    colnames(heading_two) <- colnames(prep_data)

    table_data <- bind_rows(
      prep_data %>% filter(Category2 == "Number of businesses - Values"),
      heading_two,
      prep_data %>% filter(Category2 == "Value of exports ($millions) - Values")
    )

    # Create the datatable
    datatable(table_data[-1],
      rownames = FALSE,
      ## change default class (table-striped) to cell-border (borders around all cells, no striping)
      class = "cell-border",
      options = list(
        scrollX = TRUE, ordering = FALSE, paging = FALSE, dom = "t",
        ## format header
        headerCallback = JS(
          "function(thead, data, start, end, display){",
          "  $('th', thead).css('color', 'white');",
          "  $('th', thead).css('background-color', '#0e83b0');",
          "  $('th', thead).css('text-align', 'center');",
          "  $('th', thead).css('border-style', 'solid');",
          "  $('th', thead).css('border-width', '1px');",
          "  $('th', thead).css('border-color', 'white');",
          "}"
        ),
        ## column widths
        columnDefs = list(list(width = "180px", targets = 0))
      )
    ) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(1:ncol(table_data),
        color = styleRow(4, "white"),
        backgroundColor = styleRow(4, "#0e83b0"),
        textAlign = styleRow(4, "center"),
        borderStyle = styleRow(4, "solid"),
        borderWidth = styleRow(4, "1px"),
        borderColor = styleRow(4, "white"),
        fontWeight = styleRow(4, "bold")
      ) %>%
      formatStyle(2:7, textAlign = "center") %>%
      formatStyle(8:9, textAlign = "center") %>%
      formatStyle(
        columns = 1:ncol(table_data),
        ## use styleRow to select which rows to apply style
        backgroundColor = styleRow(rows = c(3, 7), "#c4d6e7"),
        color = styleRow(rows = c(3, 7), "#015082"),
        fontWeight = styleRow(rows = c(3, 7), "bold")
      )
  })

  # datatable5.01b ----
  ## Figure 5.1: Number of British Columbia exporters and value of exports, British Columbia
  ## part2: Percentages
  output$datatable5.01b <- output$datatable5.01b_s <- renderDT({
    prep_data <- data_new %>%
      filter(Topic_id == "5.01", str_detect(Category2, "Percentages")) %>%
      select(Category2, `Number of businesses` = Category, Variable, Value) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for columns
      mutate_at(c(3:8), ~ percent(as.numeric(.x), accuracy = 0.1))

    ## add in second heading row
    heading_two <- data.frame(t(c("", "Value of exports", names(prep_data)[3:8])))
    colnames(heading_two) <- colnames(prep_data)

    table_data <- bind_rows(
      prep_data %>% filter(Category2 == "Number of businesses - Percentages"),
      heading_two,
      prep_data %>% filter(Category2 == "Value of exports ($millions) - Percentages")
    )

    # Create the datatable
    datatable(table_data[-1],
      rownames = FALSE,
      ## change default class (table-striped) to cell-border (borders around all cells, no striping)
      class = "cell-border",
      options = list(
        scrollX = TRUE, ordering = FALSE, paging = FALSE, dom = "t",
        ## format header
        headerCallback = JS(
          "function(thead, data, start, end, display){",
          "  $('th', thead).css('color', 'white');",
          "  $('th', thead).css('background-color', '#0e83b0');",
          "  $('th', thead).css('text-align', 'center');",
          "  $('th', thead).css('border-style', 'solid');",
          "  $('th', thead).css('border-width', '1px');",
          "  $('th', thead).css('border-color', 'white');",
          "}"
        ),
        ## column widths
        columnDefs = list(list(width = "180px", targets = 0))
      )
    ) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(1:ncol(table_data),
        color = styleRow(4, "white"),
        backgroundColor = styleRow(4, "#0e83b0"),
        textAlign = styleRow(4, "center"),
        borderStyle = styleRow(4, "solid"),
        borderWidth = styleRow(4, "1px"),
        borderColor = styleRow(4, "white"),
        fontWeight = styleRow(4, "bold")
      ) %>%
      formatStyle(2:7, textAlign = "center") %>%
      formatStyle(8:9, textAlign = "center") %>%
      formatStyle(
        columns = 1:ncol(table_data),
        ## use styleRow to select which rows to apply style
        backgroundColor = styleRow(rows = c(3, 7), "#c4d6e7"),
        color = styleRow(rows = c(3, 7), "#015082"),
        fontWeight = styleRow(rows = c(3, 7), "bold")
      )
  })

  # datatable5.02 ----
  ## Figure 5.2: Growth in small business exporters and exports by province and territory
  output$datatable5.02 <- output$datatable5.02_s <- renderDT({
    prep_data <- bind_rows(
      data_new %>% ## latest annual data
        filter(Topic_id == "5.02", nchar(Variable) == 4) %>%
        filter(Variable == max(Variable)) %>%
        select(Category2, Category, Variable, Value),
      data_new %>% ## comparison data
        filter(Topic_id == "5.02", nchar(Variable) > 4) %>%
        select(Category2, Category, Variable, Value)
    ) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for columns
      mutate_at(c(3), ~ comma(as.numeric(.x), accuracy = 1)) %>%
      mutate_at(c(4:5), ~ percent(as.numeric(.x), accuracy = 0.1))

    heading_two <- names(prep_data)[3:5]

    table_data <- prep_data %>%
      pivot_wider(
        names_from = "Category2", values_from = all_of(heading_two),
        names_glue = "{Category2}_{.value}",
        names_vary = "slowest"
      ) ## this specification sorts columns correctly

    # create a custom table header
    heading2 <- htmltools::withTags(table(
      class = "display",
      thead(
        tr(
          th(rowspan = 1, ""),
          th(colspan = 3, "Number of Exporters"),
          th(colspan = 3, "Value of Exports ($ millions)")
        ),
        tr(
          lapply(c("", rep(heading_two, 2)), th)
        )
      )
    ))

    ## create a datatable
    datatable(table_data,
      container = heading2,
      rownames = FALSE,
      ## change default class (table-striped) to cell-border (borders around all cells, no striping)
      class = "cell-border",
      options = list(
        scrollX = TRUE,
        paging = FALSE,
        dom = "t",
        ## format header
        headerCallback = JS(
          "function(thead, data, start, end, display){",
          "  $('th', thead).css('color', 'white');",
          "  $('th', thead).css('background-color', '#0e83b0');",
          "  $('th','tr', thead).addClass('tab5');",
          "  $('th','tr', thead).css('text-align', 'center');",
          "  $('th','tr', thead).css('border-style', 'solid');",
          "  $('th','tr', thead).css('border-width', '1px');",
          "  $('th','tr', thead).css('border-color', 'white');",
          "  $('tr').css('color', '#015082');",
          "  $('tr').css('background-color', '#c4d6e7');",
          "  $('tr').css('text-align', 'center');",
          "}"
        ),
        # ## column widths
        columnDefs = list(list(width = "180px", targets = 0))
      )
    ) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:7, backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2, 5), textAlign = "right") %>%
      formatStyle(c(3, 4, 6, 7), textAlign = "center") %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(8:11), "30px"))
  })

  # plot5.03 ----
  ## Figure 5.3: Share of business exporters by destination of exports
  output$plot5.03 <- output$plot5.03_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "5.03") %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        Category2 = fct_inorder(Category2)
      )

    plot_ly(plot_data,
      x = ~Category2,
      y = ~Value,
      color = ~Category,
      colors = custom_colors[c("dark_blue", "med_blue", "green")] %>% unname(),
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = "", tickformat = "0%"),
        xaxis = list(title = ""),
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot5.04 ----
  ## Figure 5.4: Share of export value by destination of exports
  output$plot5.04 <- output$plot5.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "5.04" & Variable == "Share of export value") %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        Category2 = fct_inorder(Category2)
      )

    plot_ly(plot_data,
      x = ~Category2,
      y = ~Value,
      color = ~Category,
      colors = custom_colors[c("dark_blue", "med_blue", "green")] %>% unname(),
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = "", tickformat = "0%"),
        xaxis = list(title = ""),
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot5.05 ----
  ## Figure 5.5: Destination share of value of small business exports by province
  output$plot5.05 <- output$plot5.05_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "5.05" & Category2 == "Share of exports") %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value, accuracy = 0.1),
        Category = fct_rev(Category),
        Variable = fct_inorder(Variable)
      )

    plot_ly(plot_data,
      x = ~Variable,
      y = ~Value,
      color = ~Category,
      colors = custom_colors[c("dark_blue", "med_blue", "green")] %>% unname(),
      type = "bar",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        legend = list(orientation = "h", x = 0, y = 1.2),
        yaxis = list(title = "% of Total", tickformat = "0%"),
        xaxis = list(title = ""),
        barmode = "relative",
        hovermode = "x unified"
      ) %>%
      plotly_custom_layout()
  })

  # plot5.06 ----
  ## Figure 5.6: Export intensity for small businesses by province
  output$plot5.06 <- output$plot5.06_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "5.06" & Variable == "Exports intensity") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(
        Label = dollar(Value, accuracy = 0.1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "$ Millions per Business", tickformat = "$"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.6,
        y = 0.27,
        text = paste("<b>— Canada:", dollar(canada_average, accuracy = 0.1), "million</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot5.07 ----
  ## Figure 5.7: Value of goods exports for large and small businesses
  output$plot5.07 <- output$plot5.07_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "5.07") %>%
      mutate(
        Value = as.numeric(Value) / 1e6,
        Label = dollar(Value, accuracy = 0.1)
      )

    plot_ly(plot_data,
      x = ~Variable,
      y = ~Value,
      color = ~Category,
      colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
      type = "scatter",
      mode = "lines",
      stackgroup = "one",
      text = ~ paste0(Category, ": ", Label, " billion"),
      hovertemplate = "%{text}<extra></extra>"
    ) %>%
      layout(
        title = "",
        xaxis = list(title = ""),
        yaxis = list(title = "$ Billions", tickformat = "$"),
        barmode = "stack",
        hovermode = "x unified",
        showlegend = TRUE,
        legend = list(orientation = "h", x = 0, y = 1.3)
      ) %>%
      plotly_custom_layout()
  })

  # plot6.01 ----
  ## Figure 6.1 Small business tax rates by province
  output$plot6.01 <- output$plot6.01_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == 6.01) %>%
      filter(Variable == max(Variable)) %>%
      mutate(
        Value = as.numeric(Value),
        Label = percent(Value),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = ""),
        yaxis = list(title = "Tax Rate", tickformat = "0.1%")
      ) %>%
      plotly_custom_layout()
  })

  # plot6.02 ----
  ## Figure 6.2: Total building permits per capita
  output$plot6.02 <- output$plot6.02_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "6.02") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(
        Label = dollar(Value),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = "", tickformat = ""),
        yaxis = list(title = "", tickformat = "$0,"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.35,
        y = 0.85,
        text = paste("<b>— All of Canada:", dollar(canada_average, accuracy = 1), "per capita</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })

  # plot6.03 ----
  ## Figure 6.3: Business bankruptcy rates by province
  output$plot6.03 <- output$plot6.03_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "6.03") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = 100 * as.numeric(Value)) ## Check on this

    canada_average <- prep_data %>%
      filter(Category == "CAN") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CAN") %>%
      mutate(
        Label = round_half_up(Value, digits = 1),
        Category = fct_inorder(Category),
        selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"])
      )

    plot_ly(plot_data,
      x = ~Category,
      y = ~Value,
      type = "bar",
      marker = list(color = ~selected_color),
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hoverinfo = "text"
    ) %>%
      layout(
        xaxis = list(title = ""),
        yaxis = list(title = "", tickformat = ".1f"),
        shapes = list(hline(canada_average))
      ) %>% ## add line
      ## add canadian average text
      add_annotations(
        x = 0.05,
        y = 0.33,
        text = paste("<b>Canadian Average:", round_half_up(canada_average, digits = 1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>%
      plotly_custom_layout()
  })
}

# Run the app
shinyApp(ui, server)
