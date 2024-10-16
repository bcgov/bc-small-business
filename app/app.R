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

      ## header code found in R/header.R
      header,
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
              menuItem("Self-Employed", tabName = "page3", icon = icon("user"),
                       menuSubItem("Main", tabName = "main"),
                       menuSubItem("Women", tabName = "women"),
                       menuSubItem("Indigenous people", tabName = "indigenous")),
              menuItem("Contribution to Economy", tabName = "page4", icon = icon("usd")),
              menuItem("Small Business Exports", tabName = "page5", icon = icon("truck")),
              menuItem("Other Indicators", tabName = "page6", icon = icon("file-text")),
              menuItem("Previous Versions", icon = icon("folder"), style = "padding:7px 0 7px 0",
                       a(icon("download"), " Download 2023 data", id = "download_data_23", class = paste("shiny-download-link", "dwnldLink"),
                         href = "", target = "_blank", download = NA),
                       menuSubItem("Previous Reports", href = "https://llbc.ent.sirsidynix.net/client/en_GB/main/search/results?qu=small+business+profile&te=", newtab = TRUE, icon = icon("link"))),
              menuItem("Small Business Resources", href = "https://www2.gov.bc.ca/gov/content/employment-business/business/small-business/resources", newtab = TRUE, icon = icon("link")),
              menuItem("BC Data Catalogue Record", href = "https://catalogue.data.gov.bc.ca/dataset/14828d0e-3cab-4477-af30-eab919d3451a", newtab = TRUE, icon = icon("link")),
              div(style = "text-align:center;color:#b8c7ce", ## text color
                  downloadButton(outputId = "download_data", "Download data as excel", style = "margin:10px 0 30px 0"),
                  uiOutput("update_date")),
              menuItem("Stand Alone Figures", tabName = "page7")
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
                        highlight_1.1,
                        actionButton("explore1", "Explore further", icon = icon("line-chart"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("line-chart"), "Small business growth"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        highlight_1.2,
                        actionButton("explore2", "Explore further", icon = icon("line-chart"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("usd"), "Contribution to the economy"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        highlight_1.3,
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
                        highlight_2.1,
                        actionButton("explore4", "Explore further", icon = icon("users"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("user"), "Self-employment growth"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        highlight_2.2,
                        actionButton("explore5", "Explore further", icon = icon("user"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("user"), "Self-employment for women"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        highlight_2.3,
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
                        highlight_3.1,
                        actionButton("explore7", "Explore further", icon = icon("user"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("usd"), "Small business wages"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        highlight_3.2,
                        actionButton("explore8", "Explore further", icon = icon("usd"), class = "home-tab-btn"))),
                    box(
                      title = list(icon = icon("truck"), "Small business exporters"),
                      width = 4,
                      div(
                        style = "margin-bottom:43px",
                        highlight_3.3,
                        actionButton("explore9", "Explore further", icon = icon("truck"), class = "home-tab-btn")))
              ))), ## home tab end ----
              tabItem( ## page 1 tab start ----
                tabName = "page1",
                fluidRow(
                  figure_list_main[c("fig1.01", "fig1.02", "fig1.03", "fig1.04", "fig1.05",
                                     "fig1.06", "fig1.07", "fig1.08", "fig1.09", "fig1.10",
                                     "fig1.11", "fig1.12", "fig1.13", "fig1.14", "fig1.15")],
                  contact_box()
              )), ## page 1 tab end ----
              tabItem( ## page 2 tab start----
                tabName = "page2",
                fluidRow(
                  figure_list_main[c("fig2.01", "fig2.02", "fig2.03", "fig2.04", "fig2.05",
                                     "fig2.06", "fig2.07", "fig2.08", "fig2.09", "fig2.10")],
                  contact_box()
              )), ## page 2 tab end ----
              tabItem( ## page 3 tab start ----
                tabName = "page3", # dummy tab needed for menu - to enable submenuitems
              ),  ## page 3 tab end ----
              tabItem( ## page 3 subtab main start ----
                tabName = "main",
                fluidRow(
                  figure_list_main[c("fig3.01", "fig3.02", "fig3.03", "fig3.04", "fig3.05",
                                     "fig3.06", "fig3.07", "fig3.08", "fig3.09")],
                  contact_box()
                  )), ## page 3 subtab main end -----
              tabItem( ## page 3 subtab women start ----
                tabName = "women",
                fluidRow(
                  figure_list_main[c("fig3.10", "fig3.11", "fig3.12")],
                  contact_box()
                )), ## page 3 subtab women end -----
              tabItem( ## page 3 subtab indigenous start ----
                tabName = "indigenous",
                fluidRow(
                  figure_list_main[c("fig3.13")],
                  contact_box()
                  )), ## page 3 subtab indigenous end ----
              tabItem( ## page 4 tab start ----
                tabName = "page4",
                fluidRow(
                  figure_list_main[c("fig4.01", "fig4.02", "fig4.03", "fig4.04", "fig4.05", "fig4.06")],
                  contact_box()
                )), ## page 4 tab end ----
              tabItem( ## page 5 tab start ----
                tabName = "page5",
                fluidRow(
                  figure_list_main[c("fig5.01", "fig5.02", "fig5.03", "fig5.04", "fig5.05", "fig5.06", "fig5.07")],
                  contact_box()
                )), ## page 5 tab end ----
              tabItem( ## page 6 tab start ----
                tabName = "page6",
                fluidRow(
                  figure_list_main[c("fig6.01", "fig6.02", "fig6.03")],
                  contact_box()
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
                  uiOutput("fig_filter"),
                  contact_box()
              )) ## page 7 tab conditional end ----
            ), ## end of tabs ----
          ), ## end of dashboard body ----
        ) ## end of dashboard page ----
      ),
      bcsapps::bcsFooterUI(id = "footer")
    )
  )

# Define server logic ----
server <- function(input, output, session) {

  observeEvent(input$tabs, shinyjs::runjs("window.scrollTo(0,0)"))

  ## header/footer ----
  ## header server
  bcstatslinks::linkModServer('links')
  output$links_yn <- shiny::renderUI(bcstatslinks::linkModUI('links'))
  ## footer server
  bcsapps::bcsFooterServer(id = 'footer')

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

  ## standalone figure tab ----
  output$fig_filter <- renderUI(fig_list_standalone[input$fig_selection])

  ## search box functionality ----
  observeEvent(input$searchbar,{
    ## change to standalone tab
    updateTabItems(session, 'tabs', selected = 'page7')

    ## update displayed figures
    updateSelectInput(session, 'fig_selection',
                      selected = search_terms %>%
                        filter(searchterm == input$searchbar) %>%
                        pull(figure_list) %>%
                        str_split_1(", "))

    ## clear search bar
    updateSelectInput(session, "searchbar", selected = "")
  })

  ## download buttons ----
  ## current data
  output$download_data <- downloadHandler(
    filename = "bc-small-business-profile-data-2024.xlsx",
    content = function(file) { file.copy("data/bc-small-business-profile-data-2024.xlsx", file) })

  ## past data
  output$download_data_23 <- downloadHandler(
    filename = "bc-small-business-profile-data-2023.xlsx",
    content = function(file) { file.copy("data/bc-small-business-profile-data-2023.xlsx", file) })

  ## color definition ----
  default_color <- "#1f77b4"

  custom_colors <- c(yellow = "#fcb814", light_green = "#95c1b2", green = "#15987b",
                     light_blue = "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082", navy = "#143047")

  region_colors <- c("Provincial Total" = "#000000",
                     "Cariboo" = "#95c1b2", "Kootenay" = "#15987b", "Mainland/Southwest" = "#0e83b0",
                     "North Coast & Nechako" = "#fcb814", "Northeast" = "#143047", "Thompson-Okanagan" = "#015082",
                     "Vancouver Island/Coast" = "#92b5d2")

  size_colors <- c("Small Business" = "#95c1b2", "Small businesses" = "#95c1b2",
                   "Small businesses with employees" = "#95c1b2",
                   "Small businesses with employees (Fewer than 50)" = "#95c1b2",
                   "Small businesses without employees (Self-employed without paid help)" = "#15987b",
                   "Small businesses without employees" = "#15987b",
                   "Large Business" = "#fcb814", "Large Businesses" = "#fcb814",
                   "Large businesses" = "#fcb814", "Large Businesses (Businesses with 50 or more)" = "#fcb814",
                   "Public Sector" = "#92b5d2")

  # datatable1.01 ----
  ## Figure 1.1: Breakdown of businesses in British Columbia
  output$datatable1.01 <- output$datatable1.01_s <- renderDT({
    table_data <- data_new %>%
      filter(Topic_id == "1.01") %>%
      select(Category, Variable, Value) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for mixed type columns
      mutate_at(c(3, 4), ~ ifelse(str_detect(.x, "^-$"), .x, percent(r(as.numeric(.x), 2)))) %>%
      mutate_at(c(6, 8), ~ ifelse(str_detect(.x, "^-$"), .x, percent(r(as.numeric(.x), 3), accuracy = 0.1))) %>%
      mutate_at(c(2, 5, 7), ~ ifelse(str_detect(.x, "<"), .x, comma(as.numeric(.x)))) %>%
      suppressWarnings()

    # Create the datatable
    datatable(table_data,
      rownames = FALSE,
      colnames = c("", names(table_data)[-1]),
      class = "cell-border",   ## change default class (table-striped) to cell-border (borders around all cells, no striping)
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
          "}"),
        ## column widths
        columnDefs = list(list(width = "300px", targets = 0)))) %>%
      ## Style: can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2, 5, 7), textAlign = "right") %>%
      formatStyle(c(3, 4, 6, 8), textAlign = "center") %>%
      formatStyle(columns = 1:ncol(table_data),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(8, 15, 16), "#c4d6e7"),
                  color = styleRow(rows = c(8, 15, 16), "#015082"),
                  fontWeight = styleRow(rows = c(8, 15, 16), "bold")) %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(2, 3), "30px"))
  })

  # plot1.02 ----
  ## Figure 1.2: Count of small businesses in British Columbia
  output$plot1.02 <- output$plot1.02_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.02" & Category != "Total small businesses") %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Category, ": ", comma(Value)),
             x_Category = fct_inorder(Variable),
             color_Category = fct_inorder(Category))

    vertical_bar_chart(plot_data,
                       colors = rev(unname(custom_colors)),
                       y_tickformat = ",",
                       barmode = "relative",
                       legend_dir = "h")
  })

  # plot1.03 ----
  ## Figure 1.3: Share of businesses by employment size in British Columbia
  output$plot1.03 <- output$plot1.03_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.03") %>%
      mutate(Value = as.numeric(Value))

    total_count <- prep_data %>%
      filter(Variable == "Count", Category == "Total") %>%
      pull(Value) %>%
      r(digits = -2)

    plot_data <- prep_data %>%
      filter(Variable == "Per cent" & Category != "Total") %>%
      mutate(y_Category = str_replace_all(Category, "\\(", "\\\n\\("),
             color_Category = fct_inorder(Category),
             Label = paste0(y_Category, ": ", percent(r(Value, 2), accuracy = 1)))

    horizontal_bar_chart(plot_data,
                         colors = size_colors,
                         x_tickformat = ".0%",
                         hovermode = "closest") %>%
      add_annotations(x = 0,
                      y = 0.99,
                      text = paste0("<b>Total businesses and organizations: ", comma(total_count), "</b>"),
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F)
  })

  # plot1.04a ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 1 year
  output$plot1.04a <- output$plot1.04a_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "1-yr growth") %>%
      mutate(Value = as.numeric(Value),
             y_Category = fct_inorder(Category),
             color_Category = "same",   ## all one color
             Label = paste0(y_Category, ": ", comma(Value)))

    horizontal_bar_chart(plot_data,
                         colors = default_color,
                         x_title = paste("1-Year Growth,", unique(plot_data$Category2)),
                         x_tickformat = "0,")
  })

  # plot1.04b ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 2 year
  output$plot1.04b <- output$plot1.04b_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "2-yr growth") %>%
      mutate(Value = as.numeric(Value),
             y_Category = fct_inorder(Category),
             color_Category = "same",   ## all one color
             Label = paste0(y_Category, ": ", comma(Value)))

    horizontal_bar_chart(plot_data,
                         colors = default_color,
                         x_title = paste("2-Year Growth,", unique(plot_data$Category2)),
                         x_tickformat = "0,")
  })

  # plot1.04c ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 5 year
  output$plot1.04c <- output$plot1.04c_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "5-yr growth") %>%
      mutate(Value = as.numeric(Value),
             y_Category = fct_inorder(Category),
             color_Category = "same",   ## all one color
             Label = paste0(y_Category, ": ", comma(Value)))

    horizontal_bar_chart(plot_data,
                         colors = default_color,
                         x_title = paste("5-Year Growth,", unique(plot_data$Category2)),
                         x_tickformat = "0,")
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
      mutate(Value = as.numeric(Value),
             y_Category = fct_inorder(Category),
             color_Category = "same",   ## all one color
             Label = ifelse(str_detect(Category, "Sector"), "", paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1))),
             custom_ticktext = ifelse(str_detect(Category, "Sector"),
                                      paste0("<span style='color: ", custom_colors[["dark_blue"]], "'><b>", Category, "<b></span>"),
                                      Category))

    horizontal_bar_chart(plot_data,
                         colors = custom_colors[["dark_blue"]],
                         x_tickformat = "0%",
                         autorange = "reversed") %>%
      layout(yaxis = list(tickvals = ~Category,
                          ticktext = ~custom_ticktext))
  })

  # plot1.06 ----
  ## Figure 1.6: Distribution of small businesses with and without employees by industry
  output$plot1.06 <- output$plot1.06_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.06" & Category != "Overall") %>%
      mutate(Value = as.numeric(Value),
             Variable = str_remove_all(Variable, " percent"),
             Variable_label = str_remove_all(Variable, "(Small businesses with )|( \\(([:space:]|[:graph:])*$)"),
             Label = paste0(Variable_label, ": ", percent(r(Value, 3), accuracy = 0.1))) %>%
      arrange(desc(Variable), desc(Value)) %>%  ## arrange variable desc so 'no paid' is first for color
      mutate(y_Category = fct_inorder(Category),
             color_Category = fct_inorder(Variable))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("dark_blue", "med_blue")]),
                         x_tickformat = "0%",
                         hovermode = "y unified",
                         autorange = "reversed",
                         showlegend = TRUE)
  })

  # plot1.07 ----
  ## Figure 1.7: Small businesses by industry, proportions with and without employees
  output$plot1.07 <- output$plot1.07_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.07" & !str_detect(Variable, "Total") & str_detect(Variable, "percent")) %>%
      mutate(Value = as.numeric(Value),
             Variable = str_remove_all(Variable, " percent"),
             Label = paste0(Variable, ": ", percent(r(Value, 3), accuracy = 0.1))) %>%
      arrange(desc(Variable), desc(Value)) %>%  ## arrange variable desc so 'no paid' is first for color
      mutate(y_Category = fct_inorder(Category),
             color_Category = fct_inorder(Variable))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("dark_blue", "med_blue")]),
                         x_tickformat = "0%",
                         barmode = "stack",
                         hovermode = "y unified",
                         showlegend = TRUE)
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
      prep_data %>% filter(Category2 == "Industry") %>% mutate(color_Category = "navy") %>% arrange(desc(Value)),
      data.frame(Category = "Non-Standard Sectors", Value = 0, color_Category = "navy"),
      prep_data %>% filter(Category2 == "Non-Standard Sectors") %>% mutate(color_Category = "dark_blue") %>% arrange(desc(Value))
    ) %>%
      mutate(y_Category = fct_inorder(Category),
             color_Category = fct_inorder(color_Category),
             Label = ifelse(str_detect(Category, "Sector"), "", paste0(Category, ": ", comma(Value))),
             custom_ticktext = ifelse(str_detect(Category, "Sector"),
                                      paste0("<span style='color: ", custom_colors[["dark_blue"]], "'><b>", Category, "<b></span>"),
                                      as.character(Category)))

    horizontal_bar_chart(plot_data,
                         colors = custom_colors,  ## since color_Category = color names
                         x_tickformat = ",",
                         hovermode = "closest",
                         autorange = "reversed") %>%
      layout(yaxis = list(tickvals = ~Category,
                          ticktext = ~custom_ticktext))

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
      prep_data %>% filter(Category2 == "Industry") %>% mutate(color_Category = "navy") %>% arrange(desc(Value)),
      data.frame(Category = "Non-Standard Sectors", Value = 0, color_Category = "navy"),
      prep_data %>% filter(Category2 == "Non-Standard Sectors") %>% mutate(color_Category = "dark_blue") %>% arrange(desc(Value))
    ) %>%
      mutate(y_Category = fct_inorder(Category),
             color_Category = fct_inorder(color_Category),
             Label = ifelse(str_detect(Category, "Sector"), "", paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1))),
             custom_ticktext = ifelse(str_detect(Category, "Sector"),
                                      paste0("<span style='color: ", custom_colors[["dark_blue"]], "'><b>", Category, "<b></span>"),
                                      as.character(Category)))

    horizontal_bar_chart(plot_data,
                         colors = custom_colors,  ## since color_Category = color names
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed") %>%
      layout(yaxis = list(tickvals = ~Category,
                          ticktext = ~custom_ticktext))
  })

  # plot1.10 ----
  ## Figure 1.10: Small businesses per 1,000 people by province
  output$plot1.10 <- output$plot1.10_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.10") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(Label = comma(Value),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Total:", canada),
                     y_title = "",
                     y_tickformat = ",")
  })

  # plot1.11 ----
  ## Figure 1.11: Small business growth by province
  output$plot1.11 <- output$plot1.11_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "1.11") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "",
                     y_tickformat = "0%")
  })

  # plot1.12 ----
  ## Figure 1.12: Small business and population distribution by region in British Columbia
  output$plot1.12 <- output$plot1.12_s <- renderPlot({
    plot_data <- data_geo %>%
      left_join(data_new %>% filter(Topic_id == "1.12"),
        by = c("region" = "Category")
      ) %>%
      mutate(Value = as.numeric(Value),
             Variable = case_when(str_detect(Variable, "population") ~ "pop",
                                  str_detect(Variable, "businesses") ~ "sb"),
             region = str_replace_all(region, "/ ", "/"),
             region = str_replace_all(region, " - ", "-")) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(label = paste0(region_label, "\n", percent(r(sb, 3), accuracy = 0.1), " SB\n", percent(r(pop, 3), accuracy = 0.1), " population"),
             region = factor(region,
                             levels = c("North Coast & Nechako", "Cariboo", "Kootenay",
                                        "Vancouver Island/Coast", "Mainland/Southwest",
                                        "Thompson-Okanagan", "Northeast")),
             text_color = case_when(
               region %in% c("Vancouver Island/Coast", "Mainland/Southwest", "North Coast & Nechako") ~ "black",
               TRUE ~ "white")) %>%
      arrange(region)

    ggplot(data = plot_data) +
      geom_sf(aes(fill = region), color = "white", linewidth = 0.5) +
      geom_sf_text(aes(label = label, color = text_color),
                   size = 4, lineheight = 0.8, fontface = "bold",
                   ## northcoast, vi, mainland, cariboo, kootenay, t-o, northeast
                   nudge_x = c(120000, -280000, 150000, -90000, 0, -10000, 20000),
                   nudge_y = c(-190000, -120000, -180000, -100000, -50000, 20000, 0)) +
      scale_fill_manual(values = region_colors) +
      scale_color_manual(values = c(white = "white", black = "black")) +
      theme_void() +
      theme(legend.position = "none",
            text = element_text(face = "bold"))
  })

  # plot1.13 ----
  ## Figure 1.13: Small businesses per 1,000 people by region in British Columbia
  output$plot1.13 <- output$plot1.13_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.13" & !str_detect(Category, "Total")) %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value),
             y_Category = fct_inorder(Category),
             color_Category = y_Category,
             Label = paste0(Category, ": ", comma(Value)))

    horizontal_bar_chart(plot_data,
                         colors = region_colors,  ## since color_Category = color names
                         x_title = "Number of Businesses per 1,000 People",
                         x_tickformat = ",",
                         hovermode = "closest")
  })

  # plot1.14 ----
  ## Figure 1.14: Number of small businesses by region
  output$plot1.14 <- output$plot1.14_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.14") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value),
             y_Category = fct_inorder(Category),
             color_Category = y_Category,
             Label = paste0(Category, ": ", comma(Value)))

    horizontal_bar_chart(plot_data,
                         colors = region_colors,  ## since color_Category = color names
                         x_title = "Number of Businesses",
                         x_tickformat = ",",
                         hovermode = "closest",
                         autorange = "reversed")
  })

  # plot1.15 ----
  ## Figure 1.15: Net change in number of small businesses by region
  output$plot1.15 <- output$plot1.15_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "1.15") %>%
      filter(str_detect(Variable, "Net change")) %>%
      mutate(Value = as.numeric(Value),
             y_Category = fct_inorder(Category),
             color_Category = y_Category,
             Label = paste0(Category, ": ", comma(Value)))

    horizontal_bar_chart(plot_data,
                         colors = region_colors,  ## since color_Category = color names
                         x_title = "Net Change of Businesses",
                         x_tickformat = ",",
                         hovermode = "closest",
                         autorange = "reversed")
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
      mutate_at(c(3, 4), ~ ifelse(str_detect(.x, "^-$"), .x, percent(r(as.numeric(.x), 2), accuracy = 1))) %>%
      mutate_at(c(6, 8), ~ ifelse(str_detect(.x, "^-$"), .x, percent(r(as.numeric(.x), 3), accuracy = 0.1))) %>%
      mutate_at(c(2, 5, 7), ~ ifelse(str_detect(.x, "<"), .x, comma(as.numeric(.x)))) %>%
      suppressWarnings()

    # create a custom table header
    h_1 <- names(table_data)[5] %>% str_replace(" \\(", "\\\r\\\n\\(") %>% str_replace("\\) [:alpha:]*", "\\)")
    h_2 <- names(table_data)[7] %>% str_replace(" \\(", "\\\r\\\n\\(") %>% str_replace("\\) [:alpha:]*", "\\)")

    heading2 <- htmltools::withTags(table(
      class = "display",
      thead(
        tr(
          th(rowspan = 2, ""),
          th(rowspan = 2, "Employment"),
          th(rowspan = 2, "Per cent of small business"),
          th(rowspan = 2, "Per cent of private sector"),
          th(colspan = 2, h_1),
          th(colspan = 2, h_2)),
        tr(
          lapply(rep(c("Number", "Per cent"), 2), th)))))

    ## create a datatable
    datatable(table_data,
      container = heading2,
      rownames = FALSE,
      class = "cell-border", ## change default class (table-striped) to cell-border (borders around all cells, no striping)
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
          "}"),
        ## column widths
        columnDefs = list(list(width = "300px", targets = 0),
                          list(width = "75px", targets = 3)))) %>%
      formatStyle(1:8, backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2, 5, 7), textAlign = "right") %>%
      formatStyle(c(3, 4, 6, 8), textAlign = "center") %>%
      formatStyle(columns = 1:8,
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = nrow(table_data), "#c4d6e7"),
                  color = styleRow(rows = nrow(table_data), "#015082"),
                  fontWeight = styleRow(rows = nrow(table_data), "bold")) %>%
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
      mutate(Label = paste0(Category, ": ", percent(Value)),
             y_Category = fct_inorder(Category),
             color_Category = y_Category)

    horizontal_bar_chart(plot_data,
                         colors = size_colors,  ## since color_Category = color names
                         x_title = "Share of Total Employment",
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed") %>%
      add_annotations(x = 0,
                      y = 0.99,
                      text = paste("<b>Total Employment:", comma(total), "</b>"),
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F )
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
      mutate(Value = as.numeric(Value),
             Label = paste0(Category, ": ", percent(Value)),
             y_Category = fct_inorder(Category),
             color_Category = y_Category)

    horizontal_bar_chart(plot_data,
                         colors = size_colors,  ## since color_Category = color names
                         x_title = "Share of Total Employment",
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed") %>%
      add_annotations(x = 0,
                      y = 0.99,
                      text = paste("<b>Total Employment:", comma(total), "</b>"),
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F)
  })

  # plot2.04 ----
  ## Figure 2.4: Year-over-year growth in private sector employment
  output$plot2.04 <- output$plot2.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.04" & Category2 == "Net Growth" & !str_detect(Category, "Total")) %>%
      filter(Variable > as.numeric(max(Variable)) - 14) %>%
      mutate(Value = as.numeric(Value),
             Label = paste(Category, ":", comma(Value)),
             x_Category = fct_inorder(Variable),
             color_Category = fct_inorder(Category))

    vertical_bar_chart(plot_data,
                       # in category order: self-emp, small, large
                       colors = unname(custom_colors[c("dark_blue", "med_blue", "yellow")]),
                       y_title = "Number of Jobs",
                       y_tickformat = "",
                       barmode = "relative",
                       traceorder = "reversed")
  })

  # plot2.05 ----
  ## Figure 2.5: One-year small business employment change, by province
  output$plot2.05 <- output$plot2.05_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "2.05") %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "% Growth",
                     y_tickformat = "0%")
  })

  # plot2.06 ----
  ## Figure 2.6: Five-year small business employment change by province
  output$plot2.06 <- output$plot2.06_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "2.06") %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "% Growth",
                     y_tickformat = "0%")
  })

  # plot2.07 ----
  ## Figure 2.7: Small business as a per cent of private sector employment by province
  output$plot2.07 <- output$plot2.07_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "2.07") %>%
      mutate(Value = as.numeric(Value) / 100)

    canada <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "",
                     y_tickformat = "0%")
  })

  # plot2.08 ----
  ## Figure 2.8: One-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.08 <- output$plot2.08_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.08") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(Value = `Per cent growth`,
             Label = ifelse(`Net growth` > 0,
                            paste0(percent(r(`Per cent growth`, 3), accuracy = 0.1), " growth, +", comma(`Net growth`), " businesses"),
                            paste0(percent(r(`Per cent growth`, 3), accuracy = 0.1), " growth, ", comma(`Net growth`), " businesses")),
             y_Category = fct_inorder(Category),
             color_Category = fct_inorder(Category2))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("yellow", "navy")]),
                         x_title = "One-year growth rate in<br>small business employment",
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed",
                         showlegend = TRUE,
                         traceorder = "reversed") %>%
    layout(xaxis = list(title=list(font = list(size = 12))))

  })

  # plot2.09 ----
  ## Figure 2.9: Two-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.09 <- output$plot2.09_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.09") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(Value = `Per cent growth`,
             Label = ifelse(`Net growth` > 0,
                            paste0(percent(r(`Per cent growth`, 3), accuracy = 0.1), " growth, +", comma(`Net growth`), " businesses"),
                            paste0(percent(r(`Per cent growth`, 3), accuracy = 0.1), " growth, ", comma(`Net growth`), " businesses")),
             y_Category = fct_inorder(Category),
             color_Category = fct_inorder(Category2))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("yellow", "navy")]),
                         x_title = "Two-year growth rate in<br>small business employment",
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed",
                         showlegend = TRUE,
                         traceorder = "reversed") %>%
      layout(xaxis = list(title=list(font = list(size = 12))))
  })

  # plot2.10 ----
  ## Figure 2.10: Five-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.10 <- output$plot2.10_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "2.10") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(Value = `Per cent growth`,
           Label = ifelse(`Number of businesses` > 0,
                          paste0(percent(r(`Per cent growth`, 3), accuracy = 0.1), " growth, +", comma(`Number of businesses`), " businesses"),
                          paste0(percent(r(`Per cent growth`, 3), accuracy = 0.1), " growth, ", comma(`Number of businesses`), " businesses")),
           y_Category = fct_inorder(Category),
           color_Category = fct_inorder(Category2))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("yellow", "navy")]),
                         x_title = "Five-year growth rate in<br>small business employment",
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed",
                         showlegend = TRUE,
                         traceorder = "reversed") %>%
      layout(xaxis = list(title=list(font = list(size = 12))))
  })

  # plot3.01 ----
  ## Figure 3.1: Self-employment as a per cent of total employment by province
  output$plot3.01 <- output$plot3.01_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.01") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "",
                     y_tickformat = "0%")
  })

  # plot3.02 ----
  ## Figure 3.2: Self-employment per cent change by province
  output$plot3.02 <- output$plot3.02_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.02") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "",
                     y_tickformat = "0%")
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
      mutate(Label = paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1)),
             y_Category = fct_inorder(Category),
             color_Category = fct_inorder(Category))

     horizontal_bar_chart(plot_data,
                         colors = region_colors,
                         x_title = paste("% Change,", unique(plot_data$Category2)),
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed") %>%
      layout(shapes = list(vline(provincial_average))) %>%
      add_annotations(x = 0.25,
                      y = .99,
                      text = paste("<b><span style = 'letter-spacing:-2px'>&#8212;&#8212;</span> Provincial Average: ",
                                   percent(r(provincial_average, 3), accuracy = 0.1),
                                   "</b>"),
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F)
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
      mutate(Label = paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1)),
             y_Category = fct_inorder(Category),
             color_Category = fct_inorder(Category))

    horizontal_bar_chart(plot_data,
                         colors = region_colors,
                         x_title = paste("% Change,", unique(plot_data$Category2)),
                         x_tickformat = "0%",
                         hovermode = "closest",
                         autorange = "reversed") %>%
      layout(shapes = list(vline(provincial_average))) %>%
      add_annotations(x = 0.45,
                      y = .99,
                      text = paste("<b><span style = 'letter-spacing:-2px'>&#8212;&#8212;</span> Provincial Average: ",
                                   percent(r(provincial_average, 3), accuracy = 0.1),
                                   "</b>"),
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F)
  })

  # plot3.04 ----
  ## Figure 3.4: Number of self-employed persons with and without paid help in British Columbia
  output$plot3.04 <- output$plot3.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.04" & str_detect(Variable, "paid help") & !str_detect(Category, "Total")) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Category, ": ", comma(Value)),
             x_Category = fct_inorder(Variable),
             color_Category = fct_inorder(Category))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("yellow", "navy")]),
                       y_tickformat = "",
                       barmode = "relative",
                       traceorder = "reversed")
  })

  # plot3.05 ----
  ## Figure 3.5: Number of self-employed persons in British Columbia by incorporation status
  output$plot3.05 <- output$plot3.05_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.05" & str_detect(Variable, "paid help") & !str_detect(Category, "Total")) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Variable, ": ", comma(Value)),
             x_Category = fct_inorder(Category),
             color_Category = fct_inorder(Variable))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("yellow", "navy")]),
                       y_tickformat = "",
                       barmode = "relative",
                       traceorder = "reversed")
  })

  # plot3.06 ----
  ## Figure 3.6: Number of self-employed with paid help compared to self-employed without paid help, British Columbia
  output$plot3.06 <- output$plot3.06_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.06") %>%
      mutate(Value = as.numeric(Value) * 1000,
             Label = paste0(Variable, ": ", comma(Value)),
             x_Category = fct_inorder(Category),
             color_Category = fct_inorder(Variable))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("yellow", "navy")]),
                       y_tickformat = "",
                       legend_dir = "h")
  })

  # plot3.07 ----
  ## Figure 3.7: Age distribution of self-employed workers compared to employees, British Columbia
  output$plot3.07 <- output$plot3.07_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.07") %>%
      mutate(Value = as.numeric(Value),
             Label = paste(Variable, ":", percent(r(abs(Value), 3), accuracy = 0.1)),
             y_Category = fct_inorder(Category)) %>%
      arrange(Value) %>% ## arrange so that negative values come first for color
      mutate(color_Category = fct_inorder(Variable))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("med_blue", "dark_blue")]),
                         x_tickformat = "0%",
                         barmode = "relative",
                         hovermode = "y unified",
                         showlegend = TRUE)
  })

  # plot3.08 ----
  ## Figure 3.8: Share of British Columbian workers who are self-employed, by age
  output$plot3.08 <- output$plot3.08_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.08" & Category != "Total") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(r(abs(Value), 3), accuracy = 0.1),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
      x = ~Variable,
      y = ~Value,
      color = ~Category,
      colors = custom_colors %>% unname(),
      type = "scatter",
      mode = "lines",
      text = ~ paste0(Category, ": ", Label),
      textposition = "none",
      hovertemplate = "%{text}<extra></extra>") %>%
      layout(yaxis = list(title = "", tickformat = "0%"),
             xaxis = list(title = ""),
             hovermode = "x unified") %>%
      plotly_custom_layout()
  })

  # plot3.09 ----
  ## Figure 3.9: Hours worked, self-employed compared to employees
  output$plot3.09 <- output$plot3.09_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.09" & !str_detect(Category, "main")) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(str_remove_all(Variable, " average([:space:]|[:graph:])+$"),
                            ": ",
                            percent(r(abs(Value), 3), accuracy = 0.1)),
             y_Category = fct_inorder(Category)) %>%
      arrange(Value) %>% ## arrange so that negative values come first for color
      mutate(color_Category = fct_inorder(Variable))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("med_blue", "dark_blue")]),
                         x_tickformat = "0%",
                         barmode = "relative",
                         hovermode = "y unified",
                         showlegend = TRUE)
  })

  # plot3.10 ----
  ## Figure 3.10: Proportion of self-employed who are women by province
  output$plot3.10 <- output$plot3.10_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "3.10") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "",
                     y_tickformat = "0%")
  })

  # plot3.11 ----
  ## Figure 3.11: Proportion of self-employed who are women, by region
  output$plot3.11 <- output$plot3.11_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.11") %>%
      filter(Variable == max(Variable) | Variable == as.numeric(max(Variable)) - 5) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Variable, ": ", percent(r(Value, 3), accuracy = 0.1)),
             y_Category = fct_inorder(Category)) %>%
      arrange(Variable) %>%  ## arrange so earlier year is first for color
      mutate(color_Category = fct_inorder(Variable))

      horizontal_bar_chart(plot_data,
                           colors = unname(custom_colors[c("med_blue", "dark_blue")]),
                           x_tickformat = "0%",
                           hovermode = "y unified",
                           autorange = "reversed",
                           showlegend = TRUE)
  })

  # plot3.12 ----
  ## Figure 3.12: Hours worked among self-employed men and women, British Columbia
  output$plot3.12 <- output$plot3.12_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.12" & !str_detect(Category, "main")) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(str_remove_all(Variable, " average([:space:]|[:graph:])+$"),
                           ": ",
                           percent(r(abs(Value), 3), accuracy = 0.1)),
             y_Category = fct_inorder(Category)) %>%
      arrange(Value) %>% ## arrange so that negative values come first for color
      mutate(color_Category = fct_inorder(Variable))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("med_blue", "dark_blue")]),
                         x_tickformat = "0%",
                         barmode = "relative",
                         hovermode = "y unified",
                         autorange = "reversed",
                         showlegend = TRUE)
  })

  # plot3.13 ----
  ## Figure 3.13: Per cent of working, off-reserve Indigenous and non-Indigenous people who are self-employed in British Columbia
  output$plot3.13 <- output$plot3.13_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "3.13" & Category != "Difference") %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1)),
             x_Category = fct_inorder(Variable),
             color_Category = fct_inorder(Category))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("yellow", "navy")]),
                       y_title = "% Self-employed",
                       y_tickformat = "0%",
                       legend_dir = "h")
  })

  # plot4.01 ----
  ## Figure 4.1: Small business contribution to GDP by province
  output$plot4.01 <- output$plot4.01_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "4.01") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(Label = percent(r(Value, 2), accuracy = 1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 2), accuracy = 1)),
                     y_title = "",
                     y_tickformat = "0%")
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
      mutate(year = str_extract(Category, "[:digit:]{4}"),
             amount = dollar(`Small business wage gap`),
             percent = percent(r(`Gap in per cent`, 3), accuracy = 0.1),
             text = paste0("<b>Wage gap ", year, ": ", amount, " (", percent, ")</b>")) %>%
      pull(text)

    plot_data <- prep_data %>%
      filter(!str_detect(Variable, "(G|g)ap")) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Variable, ": ", dollar(Value)),
             x_Category = str_extract(Category, "Earnings [:digit:]{4}"),
             color_Category = fct_inorder(Variable))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("yellow", "navy")]),
                       y_title = "", #"Thousands",
                       y_tickformat = "$,",
                       legend_dir = "h") %>%
      layout(xaxis = list(title = "Payroll/Employee")) %>%
      add_annotations(x = 0.01,
                      y = 0.79,
                      text = wage_gap[1],
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F) %>%
      add_annotations(x = 0.5,
                      y = 0.99,
                      text = wage_gap[2],
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F)
  })

  # plot4.03 ----
  ## Figure 4.3: Small business average annual earnings and wage gap by industry
  output$plot4.03 <- output$plot4.03_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "4.03" & !str_detect(Variable, "(G|g)ap")) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Variable, ": ", dollar(Value)),
             y_Category = fct_inorder(Category)) %>%
      arrange(desc(Variable)) %>%   ## arrange desc so small is first for color
      mutate(color_Category = fct_inorder(Variable))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("med_blue", "dark_blue")]),
                         x_tickformat = "$,",
                         hovermode = "y unified",
                         autorange = "reversed",
                         showlegend = TRUE)
  })

  # plot4.04 ----
  ## Figure 4.4: Small business wage gaps by industry, British Columbia
  output$plot4.04 <- output$plot4.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "4.04" & !str_detect(Variable, "Dollar")) %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Variable, ": ", dollar(r(Value, 0), accuracy = 1)),
             y_Category = fct_inorder(Category),
             color_Category = str_extract(Variable, "[:digit:]{4}")) %>%
      arrange(color_Category) %>%  ## arrange so earlier year is first for color
      mutate(color_Categor = fct_inorder(color_Category))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("med_blue", "dark_blue")]),
                         x_tickformat = "$,",
                         hovermode = "y unified",
                         autorange = "reversed",
                         showlegend = TRUE)
  })

  # plot4.05 ----
  ## Figure 4.5: Average annual earnings by province
  output$plot4.05 <- output$plot4.05_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "4.05") %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Variable, ": ", dollar(r(Value, 0), accuracy = 1))) %>%
      arrange(desc(Variable), desc(Value)) %>%
      mutate(y_Category = fct_inorder(Category)) %>%
    arrange(desc(Variable)) %>%   ## arrange desc so small is first for color
    mutate(color_Category = fct_inorder(Variable))

    horizontal_bar_chart(plot_data,
                         colors = unname(custom_colors[c("med_blue", "dark_blue")]),
                         x_tickformat = "$,",
                         hovermode = "y unified",
                         autorange = "reversed",
                         showlegend = TRUE)
  })

  # plot4.06 ----
  ## Figure 4.6: Small business share of total payroll by province
  output$plot4.06 <- output$plot4.06_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "4.06") %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "CDA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CDA") %>%
      mutate(Label = percent(r(Value, 3), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", percent(r(canada, 3), accuracy = 0.1)),
                     y_title = "",
                     y_tickformat = "0%")
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
      mutate_at(c(9:10), ~ percent(r(as.numeric(.x), 3), accuracy = 0.1))

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
      class = "cell-border", ## change default class (table-striped) to cell-border (borders around all cells, no striping)
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
          "}"),
        ## column widths
        columnDefs = list(list(width = "180px", targets = 0)))) %>%
      ## Style: can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(1:ncol(table_data),
                  color = styleRow(4, "white"),
                  backgroundColor = styleRow(4, "#0e83b0"),
                  textAlign = styleRow(4, "center"),
                  borderStyle = styleRow(4, "solid"),
                  borderWidth = styleRow(4, "1px"),
                  borderColor = styleRow(4, "white"),
                  fontWeight = styleRow(4, "bold")) %>%
      formatStyle(2:7, textAlign = "center") %>%
      formatStyle(8:9, textAlign = "center") %>%
      formatStyle(columns = 1:ncol(table_data),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(3, 7), "#c4d6e7"),
                  color = styleRow(rows = c(3, 7), "#015082"),
                  fontWeight = styleRow(rows = c(3, 7), "bold"))
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
      mutate_at(c(3:8), ~ percent(r(as.numeric(.x), 3), accuracy = 0.1))

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
      class = "cell-border", ## change default class (table-striped) to cell-border (borders around all cells, no striping)
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
          "}"),
        ## column widths
        columnDefs = list(list(width = "180px", targets = 0)))) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(1:ncol(table_data),
                  color = styleRow(4, "white"),
                  backgroundColor = styleRow(4, "#0e83b0"),
                  textAlign = styleRow(4, "center"),
                  borderStyle = styleRow(4, "solid"),
                  borderWidth = styleRow(4, "1px"),
                  borderColor = styleRow(4, "white"),
                  fontWeight = styleRow(4, "bold")) %>%
      formatStyle(2:7, textAlign = "center") %>%
      formatStyle(8:9, textAlign = "center") %>%
      formatStyle(columns = 1:ncol(table_data),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(3, 7), "#c4d6e7"),
                  color = styleRow(rows = c(3, 7), "#015082"),
                  fontWeight = styleRow(rows = c(3, 7), "bold"))
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
      mutate_at(c(3), ~ comma(r(as.numeric(.x), 0), accuracy = 1)) %>%
      mutate_at(c(4:5), ~ percent(r(as.numeric(.x), 3), accuracy = 0.1))

    heading_two <- names(prep_data)[3:5]

    table_data <- prep_data %>%
      pivot_wider(names_from = "Category2", values_from = all_of(heading_two),
                  names_glue = "{Category2}_{.value}",
                  names_vary = "slowest") ## this specification sorts columns correctly

    # create a custom table header
    heading2 <- htmltools::withTags(table(
      class = "display",
      thead(
        tr(
          th(rowspan = 1, ""),
          th(colspan = 3, "Number of Exporters"),
          th(colspan = 3, "Value of Exports ($ millions)")),
        tr(
          lapply(c("", rep(heading_two, 2)), th)))))

    ## create a datatable
    datatable(table_data,
      container = heading2,
      rownames = FALSE,
      class = "cell-border", ## change default class (table-striped) to cell-border (borders around all cells, no striping)
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
          "}"),
        # ## column widths
        columnDefs = list(list(width = "180px", targets = 0)))) %>%
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
      mutate(Value = as.numeric(Value),
             Label = paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1)),
             x_Category = fct_inorder(Category2)) %>%
      arrange(desc(Category)) %>%   ## arrange order: US, non, both
      mutate(color_Category = fct_inorder(Category))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("dark_blue", "med_blue", "green")]),
                       y_tickformat = "0%",
                       legend_dir = "h")
  })

  # plot5.04 ----
  ## Figure 5.4: Share of export value by destination of exports
  output$plot5.04 <- output$plot5.04_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "5.04" & Variable == "Share of export value") %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1)),
             x_Category = fct_inorder(Category2)) %>%
      arrange(desc(Category)) %>%   ## arrange order: US, non, both
      mutate(color_Category = fct_inorder(Category))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("dark_blue", "med_blue", "green")]),
                       y_tickformat = "0%",
                       legend_dir = "h")
  })

  # plot5.05 ----
  ## Figure 5.5: Destination share of value of small business exports by province
  output$plot5.05 <- output$plot5.05_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "5.05" & Category2 == "Share of exports") %>%
      mutate(Value = as.numeric(Value),
             Label = paste0(Category, ": ", percent(r(Value, 3), accuracy = 0.1)),
             x_Category = fct_inorder(Variable)) %>%
      arrange(desc(Category)) %>%   ## arrange order: US, non, both
      mutate(color_Category = fct_inorder(Category))

    vertical_bar_chart(plot_data,
                       colors = unname(custom_colors[c("dark_blue", "med_blue", "green")]),
                       y_title = "% of Total",
                       y_tickformat = "0%",
                       barmode = "relative",
                       legend_dir = "h")
  })

  # plot5.06 ----
  ## Figure 5.6: Export intensity for small businesses by province
  output$plot5.06 <- output$plot5.06_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "5.06" & Variable == "Exports intensity") %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = dollar(r(Value, 1), accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canada:", dollar(r(canada, 1), accuracy = 0.1), "million"),
                     y_title = "$ Millions per Business",
                     y_tickformat = "$")
  })

  # plot5.07 ----
  ## Figure 5.7: Value of goods exports for large and small businesses
  output$plot5.07 <- output$plot5.07_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == "5.07") %>%
      mutate(Value = as.numeric(Value) / 1e6,
             Label = dollar(r(Value, 1), accuracy = 0.1)) %>%
      arrange(desc(Category)) %>%  ## arrange desc so small is on top for color
      mutate(Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Variable,
            y = ~Value,
            color = ~Category,
            colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
            type = "scatter",
            mode = "lines",
            stackgroup = "one",
            text = ~ paste0(Category, ": ", Label, " billion"),
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "$ Billions", tickformat = "$"),
             barmode = "stack",
             hovermode = "x unified",
             showlegend = TRUE,
             legend = list(orientation = "v", x = 0, y = 1.2)) %>%
      plotly_custom_layout()
  })

  # plot6.01 ----
  ## Figure 6.1 Small business tax rates by province
  output$plot6.01 <- output$plot6.01_s <- renderPlotly({
    plot_data <- data_new %>%
      filter(Topic_id == 6.01) %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     y_title = "Tax Rate",
                     y_tickformat = "0.1%")
  })

  # plot6.02 ----
  ## Figure 6.2: Total building permits per capita
  output$plot6.02 <- output$plot6.02_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "6.02") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(Label = dollar(r(Value, 0), accuracy = 1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("All of Canada:", dollar(r(canada, 0), accuracy = 1), "per capita"),
                     y_title = "",
                     y_tickformat = "$,")
  })

  # plot6.03 ----
  ## Figure 6.3: Business bankruptcy rates by province
  output$plot6.03 <- output$plot6.03_s <- renderPlotly({
    prep_data <- data_new %>%
      filter(Topic_id == "6.03") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = 100 * as.numeric(Value)) ## Check on this

    canada <- prep_data %>%
      filter(Category == "CAN") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CAN") %>%
      mutate(Label = round_half_up(Value, digits = 1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    provincial_chart(plot_data,
                     hline_val = canada,
                     label = paste("Canadian Average:", round_half_up(canada, digits = 1)),
                     y_title = "",
                     y_tickformat = ".1f")
  })
}

# Run the app
shinyApp(ui, server)
