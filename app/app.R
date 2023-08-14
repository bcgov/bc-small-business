# Load required libraries
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(ggplot2)
library(sf)
library(tidyr)

data <- readRDS("data/data.rds")
last_updated <- "August 2023"


# Define UI
ui <-

  shiny::fluidPage(
    theme = "styles.css",
    HTML("<html lang='en'>"),
    fluidRow(

      ## Replace appname with the title that will appear in the header
      bcsapps::bcsHeaderUI(id = 'header', appname = "Small Business Profile"),

      ## main body column ----
      column(width = 12,
             style = "margin-top:75px",

             shiny::tags$html(lang = "en",
                              ## dashboard page ----
                              dashboardPage(skin = "blue",
                                            dashboardHeader(title = "", titleWidth = 187),
                                            ## dashboard sidebar ----
                                            dashboardSidebar(minified = TRUE, collapsed = FALSE,
                                                             sidebarMenu(
                                                               id = "tabs", ## to be able to update with buttons on landing page
                                                               menuItem("Home", tabName = "home", icon = icon("home")),
                                                               menuItem("Additional Indicators", tabName = "page0", icon = icon("file-text")),
                                                               menuItem("Small Business Growth", tabName = "page1", icon = icon("line-chart")),
                                                               menuItem("Small Business Employment", tabName = "page2",
                                                                        icon = icon("users")),

                                                               menuItem("Self-Employed", tabName = "page3", icon = icon("user"),
                                                                        menuSubItem("For women", tabName = "women"),
                                                                        menuSubItem("For Indigenous people", tabName = "indigenous")
                                                               ),



                                                               menuItem("Contribution to Economy", tabName = "page4", icon = icon("usd")),
                                                               menuItem("Small Business Exports", tabName = "page5", icon = icon("truck")),
                                                               tags$div(style = "text-align:center;color:#b8c7ce",
                                                                        br(),
                                                                        downloadButton(outputId = "download_data", "Download data as excel"),
                                                                        br(),br(),
                                                                        uiOutput("update_date")

                                                               )
                                                             )
                                            ),
                                            ## dashboard body ----
                                            dashboardBody(
                                              ## tabs ----
                                              tabItems(
                                                ## home tab ----
                                                tabItem(
                                                  tabName = "home",

                                                  # row 1 of landing page boxes

                                                  fluidRow(
                                                    tags$div(id = "green",
                                                             box(
                                                               title = "Small business counts",
                                                               tagList(
                                                                 HTML("There were 513,300 businesses in B.C. in 2022. Of these, 98 per cent (<b>504,200</b>) were <b>small businesses with fewer than 50 employees</b>."),
                                                                 br(),br(),
                                                                 actionButton("explore1", "Explore small business growth", icon= icon("line-chart"))
                                                               ),
                                                               width = 4
                                                             ),
                                                             box(
                                                               title = "Small business growth",
                                                               tagList(
                                                                 HTML("Overall, there was a new 0.2 per cent or <b>1,020 increase in the number of small businesses in 2022</b>. Between 2017 and 2022, the number of small businesses in B.C. grew by 3.1 per cent, for a new increase of 15,100 businesses."),
                                                                 br(),br(),
                                                                 actionButton("explore2", "Explore small business growth", icon = icon("line-chart"))
                                                               ),
                                                               width = 4
                                                             )),
                                                    tags$div(id = "blue",
                                                             box(
                                                               title = "Contribution to the economy",
                                                               tagList(
                                                                 HTML("In 2022, B.C.'s small business sector generate aproximately <b>33 per cent</b> of provincial GDP."),
                                                                 br(),br(),
                                                                 actionButton("explore3", "Explore contribution to economy", icon = icon("usd"))
                                                               ),
                                                               width = 4
                                                             ))),

                                                  # row 2 of landing page boxes
                                                  fluidRow(
                                                    tags$div(id = "light-green",

                                                             box(
                                                               title = "Small business employment",
                                                               tagList(
                                                                 HTML("Small businesses in B.C. employed around <b>1,135,300 people</b> in 2022. This accounts for 51 per cent of private sector jobs in the province."),
                                                                 br(),br(),
                                                                 actionButton("explore4", "Explore small business employment", icon = icon("users"))
                                                               ),
                                                               width = 4
                                                             )),
                                                    tags$div(id = "grey",



                                                             box(
                                                               title = "Self-employment growth",
                                                               tagList(
                                                                 HTML("In 2022, there were <b>423,800 self-employed people</b> in B.C., 0.8 per cent higher than in 2021. However, self-employment fell by 0.9 per cent compared to 2017."),
                                                                 br(),br(),
                                                                 actionButton("explore5", "Explore small business employment", icon = icon("users"))
                                                               ),
                                                               width = 4
                                                             )),
                                                    tags$div(id = "grey", box(
                                                      title = "Self-employment for women",
                                                      tagList(
                                                        HTML("In 2022, <b>38.3 per cent</b> of all self-employed people in B.C. were <b>women</b>, ranking fourth among provinces."),
                                                        br(),br(),
                                                        actionButton("explore6", "Explore self-employed", icon = icon("user"))
                                                      ),
                                                      width = 4
                                                    ))),


                                                  # row 3 of landing page boxes
                                                  fluidRow(

                                                    tags$div(id = "grey", box(
                                                      title = "Self-employment for Indigenous people",
                                                      tagList(
                                                        HTML("In 2022, only <b>9.5 per cent of all Indigenous workers were self-employed</b>, compared to a self-employment rate of 15.7 per cent for non-Indigenous workers."),
                                                        br(),br(),
                                                        actionButton("explore7", "Explore self-employed", icon = icon("user"))
                                                      ),
                                                      width = 4
                                                    )),

                                                    tags$div(id = "blue", box(
                                                      title = "Small business wages",
                                                      tagList(
                                                        HTML("Small business employees earned an <b>average annual salary of $53,800</b> in 2022, around $10,300 less than the $64,100 earned by the average large business employee."),
                                                        br(),br(),
                                                        actionButton("explore8", "Explore contribution to economy", icon = icon("usd"))
                                                      ),
                                                      width = 4
                                                    )),
                                                    tags$div(id = "light-blue", box(
                                                      title = "Small business exporters",
                                                      tagList(
                                                        HTML("In 2022 there were <b>6,555</b> BC businesses with fewer than 50 employees that <b>exported goods to international destinations</b>, accounting for 86 per cent of all exporting firms."),
                                                        br(),br(),
                                                        actionButton("explore9", "Explore small business exports", icon = icon("truck"))
                                                      ),
                                                      width = 4
                                                    ))
                                                  )
                                                ),
                                                ## page 1 tab start ----
                                                tabItem(
                                                  tabName = "page1",
                                                  fluidRow(

                                                    box(title = "Figure 1.0.0: Breakdown of businesses in British Columbia, 2022", DTOutput("datatable1"),
                                                        style = "border: 1px solid white;", width = 10
                                                    ),




                                                    box(title = "Figure 1.0.1 - Count of small businesses in British Columbia",
                                                        plotlyOutput("plot1.0.1"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),


                                                    box(title = "Figure 1.1 - Growth of small businesses in British Columbia",
                                                        plotlyOutput("plot1.1"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 1.2a - One, two and five-year growth of B.C. businesses by size",
                                                        width = 10,
                                                        solidHeader = TRUE,
                                                        tabsetPanel(
                                                          tabPanel("1 year", plotlyOutput("plot1.2a1"), style = "width: 4"),
                                                          tabPanel("2 year", plotlyOutput("plot1.2a2")),
                                                          tabPanel("5 year", plotlyOutput("plot1.2a3"))
                                                        ),
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),


                                                    box(title = "Figure 1.3a: Distribution of small businesses by industry, 2022",
                                                        plotlyOutput("plot1.3a"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Primary is comprised of the agriculture, forestry,
                                      fishing, mining, oil and gas industries. The total does not sum to 100% as some businesses
                                      with employees could not be classified by industry.
                                      <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 1.3b: Distribution of small businesses with and without employees by industry, 2022",
                                                        plotlyOutput("plot1.3b"), width = 10, br(),
                                                        HTML("<b><small><small></b> <p>Notes: Primary is comprised of the agriculture, forestry,
                                      fishing, mining, oil and gas industries. Self-employment in utilities is less than 1500. Industries
                                      do not sum to 100% as some businesses with employees could not be classified by industry.
                                      <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                    box(title = "Figure 1.4: Small businesses by industry, proportions with and without employees, 2022", plotlyOutput("plot1.4"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Primary is comprised of the agriculture, forestry,
                                      fishing, mining, oil and gas industries. Utilities is not shown because the number of small businesses
                                      with employees is <200 and self-employment without paid help is very small and suppressed for confidentiality reasons.
                                      <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 1.5: Number of net new small businesses - fastest growing sectors in B.C, 2017-2022", plotlyOutput("plot1.5"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                      <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                    box(title = "Figure 1.6: Sector growth rates for number of small businesses with employees, BC, 2017-2020", plotlyOutput("plot1.6"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                      <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")


                                                    ),

                                                    box(title = "Figure 1.7: Small businesses per capita by province, 2022", plotlyOutput("plot1.7"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 1.8: Small business growth by province, 2022", plotlyOutput("plot1.8"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 1.9: Small business and population distribution by region in British Columbia, 2022", plotOutput("plot1.9", height = "470px"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 1.10: Small businesses per 1,000 persons", plotlyOutput("plot1.10"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")


                                                    ),

                                                    box(title = "Figure 1.11a: Small businesses by region, 2022", plotlyOutput("plot1.11a"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")


                                                    ),
                                                    box(title = "Figure 1.11b: Small businesses by region, growth 2017-2022", plotlyOutput("plot1.11b"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    )
                                                  )),

                                                ## page 1 tab end ----

                                                ## page 2 tab start----
                                                tabItem(
                                                  tabName = "page2",
                                                  fluidRow(

                                                    box(title = "Figure 2.0.0: asfdsafa, 2022", DTOutput("datatable2"),
                                                        style = "border: 1px solid white;", width = 10
                                                    ),


                                                    box(title = "Figure 2.1 Share of total employment in British Columbia, 2022", plotlyOutput("plot2.1"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),



                                                    box(title = "Figure 2.3: Share of employment by establishment size, 2022", plotlyOutput("plot2.3"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),


                                                    box(title = "Figure 2.4b: Year-over-year growth in private sector employment", plotlyOutput("plot2.4b"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 2.5a: One-year small business employment change, by province, 2020-2021", plotlyOutput("plot2.5a"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 2.5b: Five-year small business employment change by province, 2017-2022", plotlyOutput("plot2.5b"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 2.6: Small Business as a percent of private-sector employment by province, 2017-2022", plotlyOutput("plot2.6"), width = 10,
                                                    br(),
                                                    HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),


                                                     box(title = "Figure 2.7a: Five-year small business employment change by province, 2017-2022", plotlyOutput("plot2.7a"), width = 10,
                                                     br(),
                                                     HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),

                                                    box(title = "Figure 2.7b: Five-year small business employment change by province, 2017-2022", plotlyOutput("plot2.7b"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")

                                                    ),


                                                    box(title = "Figure 2.7c: Five-year small business employment change by province, 2017-2022", plotlyOutput("plot2.7c"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    )
                                                  )),

                                                ## page 2 tab end ----




                                                ## page 3 tab start ----
                                                tabItem(
                                                  tabName = "page3",
                                                  fluidRow(

                                                    box(title = "Figure 3.01: Self-employment as a per cent of total employment by province, 2022", plotlyOutput("plot3.01"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                        <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                    box(title = "Figure 3.02: Self-employment per cent change by province, 2017-2022", plotlyOutput("plot3.02"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                    box(title = "Figure 3.03a: Self-employment per cent change for regions in British Columbia, 2017-2022", plotlyOutput("plot3.03a"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                         <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                    box(title = "Figure 3.03b: Self-employment per cent change for regions in British Columbia, 2021-2022", plotlyOutput("plot3.03b"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                         <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                    box(title = "Figure 3.1a: Number of self-employed business owners in British Columbia, 2022", plotlyOutput("plot3.1a"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                        <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),



                                                    box(title = "Figure 3.1b: Number of self-employed business owners in British Columbia, 2022", plotlyOutput("plot3.1b"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                         <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                  box(title = "Fig3.2: Number of self-employed with paid help compared to self-employed without paid help, British Columbia, 2017-2022", plotlyOutput("plot3.2"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                        <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                    box(title = "Fig3.3: Age distribution of self-employed workers compared to employees, British Columbia, 2022", plotlyOutput("plot3.3"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: </small></small>")
                                                    ),

                                                    box(title = "Fig3.3b: Share of British Columbian workers who are self-employed, by age", plotlyOutput("plot3.3b"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: </small></small>")
                                                    ),

                                                    box(title = "Figure 3.4: Proportion of self-employed who are women by province, 2022", plotlyOutput("plot3.4"), width = 10,
                                                        br(),
                                                        HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                        <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                    ),

                                                  box(title = "Figure 3.5: Proportion of self-employed who are women, by region", plotlyOutput("plot3.5"), width = 10,
                                                      br(),
                                                      HTML("<b><small><small></b> <p>Notes: Excludes self-employed without paid help.
                                                      <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                  ),

                                                  box(title = "Figure 3.6: Percent of working, off-reserve indigenous and non-indigenous people who are self-employed in BC, 2017-2022", plotlyOutput("plot3.6"), width = 10,
                                                      br(),
                                                      HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                  ),

                                                  box(title = "Figure 3.7a: Hours worked, self-employed compared to employees, British Columbia, 2022", plotlyOutput("plot3.7a"), width = 10,
                                                      br(),
                                                      HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                  ),

                                                  box(title = "Figure 3.7b: Usual hours worked, self-employed by sex, British Columbia, 2022", plotlyOutput("plot3.7b"), width = 10,
                                                      br(),
                                                      HTML("<b><small><small></b> <p>Source: BC Stats using data supplied by Statistics Canada.</small></small>")
                                                  ),
                                                ),
                                               ), 
                                               ## page 3 tab end ----
                                               ## page 3 subtab women start ----
                                               tabItem(
                                                 tabName = "women",
                                                 "page 3 - women"
                                               ),
                                               ## page 3 subtab women end -----
                                               ## page 3 subtab indigenous start ----
                                               tabItem(
                                                 tabName = "indigenous",
                                                 "page 3 - indigenous"
                                               ),
                                               ## page 3 subtab indigenous end ----
                                               ## page 4 tab start ----
                                               tabItem(
                                                 tabName = "page4",
                                                 "page 4"
                                               ),
                                               ## page 4 tab end ----
                                               ## page 5 tab start ----
                                               tabItem(
                                                 tabName = "page5",
                                                 "page 5"
                                               )
                                               ## page 5 tab end ----





                                              ), ## end of tabs ----
                                            ), ## end of dashboard body ----
                              ) ## end of dashboard page ----
             )),

      bcsapps::bcsFooterUI(id = 'footer')



    ))

# Define server logic
server <- function(input, output, session) {



  ## Change links to false to remove the link list from the header
  bcsapps::bcsHeaderServer(id = 'header', links = TRUE)

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

  ## download button ----
  output$download_data <- downloadHandler(
    filename = "bc-small-business-profile-data.xlsx",
    content = function(file) {
      file.copy("data/bc-small-business-profile-data.xlsx", file)
    }
  )

  ## color definition ----
  #custom_colors <- c("#FDB813", "#005182", "#92B6D3", "#0E84B1", "#14997C","#96C2B3")
  custom_colors <- c(yellow= "#fcb814", light_green = "#95c1b2", green = "#15987b",
                     light_blue =  "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082",
                     navy = "#143047")
  custom_colors_rgb <- list(yellow= c(252,184,20), light_green = c(149,193,178), green = c(21,152,123),
                            light_blue=c(146,181,210), med_blue=c(14,131,176), dark_blue = c(1,80,130),
                            navy = c(20,48,71))



  #datatable1.0.0----

  # Render the table
  output$datatable1 <- renderDT({
    # Create your dataframe with the desired data
    table_data <- data$data_11
    # Create the datatable
    datatable(table_data,
              rownames = FALSE,
              ## colnames = c("", "Number of businesses", "Per cent of all businesses*", "Per cent of small businesses*"),
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                paging = FALSE,
                dom = 't',
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
                columnDefs = list(list(width = '200px', targets = 0),
                                  list(width = '50px', targets = 1),
                                  list(width = '75px', targets = 2),
                                  list(width = '100px', targets = 3))
              ),
              ## add caption
              caption = htmltools::tags$caption(
                style = 'caption-side: bottom;',
                '*Figures do not add to 100% due to rounding'
              )
    )  %>%
      ## helper functions for formatting
      formatRound("Number of businesses", mark = ",", digits = 0) %>%  ## add commas to large numbers
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(c(1,2,3,4), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2,3,4), textAlign = "right") %>%
      formatStyle(columns = c(1,2,3,4),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(8,15,16), "#c4d6e7"),
                  color = styleRow(rows = c(8,15,16), "#015082"),
                  fontWeight = styleRow(rows = c(8,15,16), "bold")) %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(2,3), "30px"))
  })


  # plot1.0.1----
  output$plot1.0.1 <- renderPlotly({

    data_001 <- data$data_001

    data_001$Type <- factor(data_001$Type, levels = rev(c("Small businesses without employees (Self-employed without paid help)",
                                                          "Small businesses with employees (Fewer than 50)",
                                                          "Large Businesses (Businesses with 50 or more)")))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot1.0.1 <- plot_ly(data_001, y = ~Type, x = data_001$`Percentage`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot1.0.1 <- plot1.0.1 %>% layout(title = '',
                                      yaxis = list(title = ''),
                                      showlegend = FALSE
    )


  })








  # plot1.1----
  output$plot1.1 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()

    # Create the stacked bar chart with custom colors
    plot1.1 <- plot_ly(data$data_09, x = ~years, y = ~count, color = ~category, type = "bar", textposition = 'inside',
                       colors = custom_colors) %>%
      layout(title = "",
             xaxis = list(title = "Years"),
             yaxis = list(title = "Employee Count"),
             barmode = "relative",
             showlegend = TRUE,
             legend = list(orientation = "h", x = 0, y = 1.3))

    # Display the chart
    plot1.1

  })



  # plot1.2a1 ----

  output$plot1.2a1 <- renderPlotly({
    # Create the plot
    plot1.2a1 <- plot_ly(data = data$data_10, x = ~`1-yr growth rate`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400)

    # Customize the layout
    layout <- list(
      xaxis = list(title = "1 Yr"),
      yaxis = list(title = ""),
      barmode = "relative",
      bargap = 0.1,
      autosize = TRUE
    )

    # Combine the plot and layout
    plot1.2a1 <- plot1.2a1 %>% layout(layout)

    # Display the plot
    plot1.2a1

  })


  # plot1.2a2 ----


  output$plot1.2a2 <- renderPlotly({
    # Create the plot
    plot1.2a2 <- plot_ly(data = data$data_10, x = ~`2-yr growth rate`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400)

    # Customize the layout
    layout <- list(
      xaxis = list(title = "2 Yr"),
      yaxis = list(title = " "),
      barmode = "relative",
      bargap = 0.1,
      autosize = TRUE
    )

    # Combine the plot and layout
    plot1.2a2 <- plot1.2a2 %>% layout(layout)

    # Display the plot
    plot1.2a2

  })


  # plot1.2a3 ----

  output$plot1.2a3 <- renderPlotly({
    # Create the plot
    plot1.2a3 <- plot_ly(data = data$data_10, x = ~`5-yr growth rate`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400)

    # Customize the layout
    layout <- list(
      xaxis = list(title = "5 Yr"),
      yaxis = list(title = ""),
      barmode = "relative",
      bargap = 0.1,
      autosize = TRUE
    )

    # Combine the plot and layout
    plot1.2a3 <- plot1.2a3 %>% layout(layout)

    # Display the plot
    plot1.2a3

  })


  # plot1.3a ----

  output$plot1.3a <- renderPlotly({

    data_12 <- data$data_12

    data_12$type <-factor(data_12$type, levels = rev(c("Construction", "Primary*", "Manufacturing", "Utilities",
                                                       "Professional, scientific and technical services",
                                                       "Health & Social Services", "Finance, Insurance & Real Estate",
                                                       "Trade", "Other Services", "Transportation & Storage",
                                                       "Business, building, and other supports",
                                                       "Information, Culture & Recreation", "Accomodation & Food")))

    plot1.3a <- plot_ly(data_12, x = ~number, type = "bar", y = ~type,
                        marker = list(color = "#005182"), name = "",
                        orientation = 'h')

    plot1.3a <- layout(plot1.3a,
                       legend = list(orientation = "h", x = -2, y = 1.2),
                       xaxis = list(tickformat = '.0')
    )

    # Display the plot
    plot1.3a
  })





  # plot1.3b ----

  output$plot1.3b <- renderPlotly({

    data_13_result <- data$data_13
    data_13_result <- data_13_result[order(data_13_result$`Small businesses with no paid employees`),]

    data_13_result$segment <- factor(data_13_result$segment, levels = data_13_result$segment)

    plot1.3b <- plot_ly(data_13_result, x = data_13_result$`Small businesses with no paid employees`,
                        y = data_13_result$segment,

                        name = 'Small businesses with no paid employees (Total 299,800, 59%)',
                        marker = list(color = "#005182"),
                        type = "bar",
                        orientation = 'h') %>%

      add_trace(y = data_13_result$segment, x = data_13_result$`Small businesses with 1-49 employee`,
                name = 'Small businesses with 1-49 employees (Total 204,300, 37%)', type = 'bar',
                marker = list(color = "#FDB813")
      )
    plot1.3b <- layout(plot1.3b,
                       legend = list(orientation = "h", x = -2, y = 1.2),
                       xaxis = list(tickformat = '.0')


    )




    plot1.3b


  })



  # plot1.4----

  output$plot1.4 <- renderPlotly({

    data_14 <- data$data_14[order(-data$data_14$`1-49 employees`),  ]
    data_14$Category <- factor(data_14$Category, levels = rev(data_14$Category))

    plot1.4<- plot_ly(data_14, y = data_14$Category, type = "bar", x = data_14$`No paid employees`, marker = list(color = "#005182"), name = "No paid employees", orientation = 'h')
    plot1.4 <- add_trace(plot1.4, x = data_14$`1-49 employees`, name = "1-49 employees", marker = list(color = "#FDB813"),
                         plot1.4 <- layout(plot1.4, barmode = "stack")

    )
    plot1.4 <- layout(plot1.4,
                      legend = list(orientation = "h", x = -2, y = 1.2),
                      xaxis = list(tickformat = '.0')


    )



    # Display the chart
    plot1.4
  })

  # plot 1.5----
  output$plot1.5 <- renderPlotly({

    data_15 <- data$data_15

    data_15$type <-factor(data_15$type, levels = rev(c("Professional, scientific and technical services", "Specialty trade contractors",
                                                       "Ambulatory health care services", "Real estate", "Social assistance",
                                                       "Non-Standard Sectors", "High tech total", "Tourism", "Secondary manufacturing")))

    plot1.5 <- plot_ly(data_15, x = ~number, type = "bar", y = ~type,
                       marker = list(color = "#005182"), name = "adsfadsf",
                       orientation = 'h')


    plot1.5 <- layout(plot1.5,
                      legend = list(orientation = "h", x = -2, y = 1.2),
                      xaxis = list(tickformat = '.0')
    )





    # Display the plot
    plot1.5
  })

  # plot 1.6----

  output$plot1.6 <- renderPlotly({

    data_16 <- data$data_16

    data_16$type <-factor(data_16$type, levels = rev(c("Beverage and tobacco product manufacturing", "Social assistance",
                                                       "Motion picture and sound recording industries", "Private households",
                                                       "Couriers and messengers", "Non-Standard Sectors", "High Technology", "Tourism",
                                                       "Secondary Manufacturing")))

    plot1.6 <- plot_ly(data_16, x = ~number, type = "bar", y = ~type,
                       marker = list(color = "#005182"), name = "adsfadsf",
                       orientation = 'h')


    plot1.6 <- layout(plot1.6,
                      legend = list(orientation = "h", x = -2, y = 1.2),
                      xaxis = list(tickformat = '.0',
                                   title = ""))
    # Display the plot
    plot1.6
  })



  # plot1.7----
  output$plot1.7 <- renderPlotly({

    ## divide by 100 to be able to make y-axis percents
    canada_average <- 0.823

    plot_data <- data$data_17 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PEI", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot1.7 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.01,
        y = 0.99,
        text = "— Canadian Average 82.3%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })


  # plot1.8----
  output$plot1.8 <- renderPlotly({

    ## divide by 100 to be able to make y-axis percents
    canada_average <- 0.015

    plot_data <- data$data_18 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PEI", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot1.8 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.01,
        y = 0.99,
        text = "— Canadian Average 1.5%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })

  # plot1.9 ----

  output$plot1.9 <- renderPlot({

    plot_data <- data$data_19 %>%
      mutate(label = paste(geo, "\n",sb_perc, "SB\n", pop_perc,"population"),
             geo = factor(geo, levels = c("North Coast &\nNechako", "Cariboo", "Kootenay",
                                          "Vancouver\nIsland/ Coast", "Mainland/Southwest", "Thompson-\nOkanagan",
                                          "Northeast")),
             text_color = case_when(geo %in%  c("Vancouver\nIsland/ Coast", "Mainland/Southwest", "North Coast &\nNechako") ~ "black",
                                    TRUE ~ "white")) %>%
      arrange(geo)

    ggplot(data = plot_data) +
      geom_sf(aes(fill = geo), color = "white", linewidth = 0.5) +
      geom_sf_text(aes(label = label, color = text_color),
                   size = 4, lineheight = 0.8, fontface = "bold",
                   ##northcoast, vi, mainland, cariboo, kootenay, t-o, northeast
                   nudge_x = c(120000,-280000,150000,-90000,0,-10000,20000),
                   nudge_y = c(-190000,-120000,-180000,-100000,-50000,20000,0)
      ) +
      scale_fill_manual(values = custom_colors %>% unname()) +
      scale_color_manual(values = c(white = "white", black = "black")) +
      theme_void() +
      theme(legend.position = "none",
            text = element_text(face = "bold"))



  })



  # plot1.10----
  output$plot1.10 <- renderPlotly({

    data_20 <- data$data_20

    data_20$region <- factor(data_20$region, levels = rev(c("Cariboo", "Kootenay", "North Coast & Nechako",
                                                            "Vancouver Island/ Coast", "Northeast",
                                                            "Thompson - Okanagan", "Mainland/ Southwest")))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot1.10 <- plot_ly(data_20, y = ~region, x = data_20$`Total, 2022`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot1.10 <- plot1.10 %>% layout(title = '',
                                    yaxis = list(title = 'Value'),
                                    showlegend = FALSE
    )


  })


  # plot1.11a----
  output$plot1.11a <- renderPlotly({

    data_21a <- data$data_21a

    data_21a$region <- factor(data_21a$region, levels = rev(c(   "Provincial Total",
                                                               "Mainland/Southwest",
                                                               "Vancouver Island/Coast",
                                                               "Thompson-Okanagan",
                                                               "Kootenay",
                                                               "Cariboo",
                                                               "North Coast & Nechako",
                                                               "Northeast")))








    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot1.11a <- plot_ly(data_21a, y = ~region, x = data_21a$`Total, 2022`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot1.11a <- plot1.11a %>% layout(title = '',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE
    )


  })

  # plot1.11b----
  output$plot1.11b <- renderPlotly({

    data_21b <- data$data_21b

    data_21b$region <- factor(data_21b$region, levels = rev(c(   "Provincial Total",
                                                               "Mainland/Southwest",
                                                               "Vancouver Island/Coast",
                                                               "Thompson-Okanagan",
                                                               "Kootenay",
                                                               "Cariboo",
                                                               "North Coast & Nechako",
                                                               "Northeast")))








    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot1.11b <- plot_ly(data_21b, y = ~region, x = data_21b$`Growth rate`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot1.11b <- plot1.11b %>% layout(title = '',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE
    )


  })



  #datatable2.0----

  # Render the table
  output$datatable2 <- renderDT({

    # Create your dataframe with the desired data

    table_data2 <- data$data_21c



    # Create the datatable
    datatable(table_data2,
              rownames = FALSE,
              colnames = c("...1", "Employment", "Per cent of small business", "Per cent of private sector",
                           "One year change (2021-2022) Number", "One year change (2021-2022) Per cent",
                           "Five  year change (2021-2022) Number", "Five year change (2021-2022) Per cent" ),
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                paging = FALSE,
                dom = 't',
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
                columnDefs = list(list(width = '200px', targets = 0),
                                  list(width = '50px', targets = 1),
                                  list(width = '75px', targets = 2),
                                  list(width = '100px', targets = 3))
              ),
              ## add caption
              caption = htmltools::tags$caption(
                style = 'caption-side: bottom;',
                '*Figures do not add to 100% due to rounding'
              )
    )  %>%
      ## helper functions for formatting
      formatRound("Number of businesses", mark = ",", digits = 0) %>%  ## add commas to large numbers
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(c(1,2,3,4), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2,3,4), textAlign = "right") %>%
      formatStyle(columns = c(1,2,3,4),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(8,15,16), "#c4d6e7"),
                  color = styleRow(rows = c(8,15,16), "#015082"),
                  fontWeight = styleRow(rows = c(8,15,16), "bold")) %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(2,3), "30px"))
  })


  # plot2.1 ----
  output$plot2.1 <- renderPlotly({

    data_22 <- data$data_22

    data_22$sector <- factor(data_22$sector, levels = rev(c("Small Business",
                                                            "Large Business",
                                                            "Public Sector")))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.1 <- plot_ly(data_22, y = ~sector, x = data_22$`%`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot2.1 <- plot2.1 %>% layout(title = '',
                                  yaxis = list(title = ''),
                                  showlegend = FALSE
    )


  })

  # plot2.3 ----
  output$plot2.3 <- renderPlotly({

    data_25 <- data$data_25

    data_25$sector <- factor(data_25$sector, levels = rev(c("Large businesses",
                                                            "Small businesses with employees",
                                                            "Small businesses without employees",
                                                            "Public Sector")))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.3 <- plot_ly(data_25, y = ~sector, x = data_25$`%`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot2.3 <- plot2.3 %>% layout(title = '',
                                  yaxis = list(title = ''),
                                  showlegend = FALSE
    )


  })










  # plot2.4b----

  output$plot2.4b <- renderPlotly({

    df_long1 <- data$data_26_result %>%
      pivot_longer(-years, names_to = "Category", values_to = "value") %>%
      mutate(value = as.numeric(value),
             Category = factor(Category, levels = c("Large business", "Small business employees", "Self-employed with no paid help")))

    custom_colors1 <- custom_colors[c("yellow", "med_blue", "dark_blue")] %>% unname()

    plot2.4b <- plot_ly(df_long1, y = ~value, x = ~years, color = ~Category,
                        type = "bar", orientation = 'v', colors = custom_colors1,
                        text = ~paste(Category, ":", format(value, big.mark = ",")),
                        textposition = "none",
                        hoverinfo = 'text') %>%
      layout(title = "",
             yaxis = list(title = ""),
             xaxis = list(title = ""),
             barmode = "relative", ## stack overlaps so use relative
             legend = list(x = 0, y = 1),
             hovermode = "x unified",
             ## to show all label regardless of length
             hoverlabel = list(namelength = -1)) %>%
      add_annotations(
        x = 0.04,
        y = 1.01,
        text = "Number of jobs",
        xref = "paper",
        yref = "paper",
        xanchor = "right",
        yanchor = "bottom",
        showarrow = F
      )


    # Display the chart
    plot2.4b

  })

  # plot2.5a----


  output$plot2.5a <- renderPlotly({
    ## divide by 100 to be able to make y-axis percents
    canada_average <- .018

    plot_data <- data$data_27 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.5a <- plot_ly(plot_data,
                        x = ~Province,
                        y = ~Percent,
                        type = "bar",
                        marker = list(color = ~selected_color),
                        text = ~paste(Province,":",Label),
                        textposition = "none",
                        hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.01,
        y = 0.99,
        text = "— Canadian Average 1.8%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })

  # plot2.5b----


  output$plot2.5b <- renderPlotly({
    ## divide by 100 to be able to make y-axis percents
    canada_average <- .018

    plot_data <- data$data_28 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.5b <- plot_ly(plot_data,
                        x = ~Province,
                        y = ~Percent,
                        type = "bar",
                        marker = list(color = ~selected_color),
                        text = ~paste(Province,":",Label),
                        textposition = "none",
                        hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.01,
        y = 0.99,
        text = "— Canadian Average 1.8%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })



  # plot2.6----


  output$plot2.6 <- renderPlotly({
    ## divide by 100 to be able to make y-axis percents
    canada_average <- .466

    plot_data <- data$data_29 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.6 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.01,
        y = 0.99,
        text = "— Canadian Average 46.6%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })


  # plot2.7a----
  output$plot2.7a <- renderPlotly({

    data_30 <- data$data_30

    custom_colors2 <- c(yellow= "#fcb814",navy = "#143047")

    data_30$area <- factor(data_30$area, levels = rev(c(    "Arts, entertainment and recreation",
                                                                "Accommodation and food services",
                                                                "Management of companies and enterprises",
                                                                "Information and cultural industries",
                                                                "Transportation and warehousing",
                                                                "Wholesale trade",
                                                                "Finance and insurance",
                                                                "Forestry and logging",
                                                                "Public administration",
                                                                "Mining, quarrying, oil and gas")))




    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.7a <- plot_ly(data_30, y = ~area, x = data_30$`percent`, type = "bar", marker = list(color = custom_colors2), orientation = 'h')

    plot2.7a <- plot2.7a %>% layout(title = '',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE
    )


  })









  # plot2.7b----
  output$plot2.7b <- renderPlotly({

    data_31 <- data$data_31

    custom_colors2 <- c(yellow= "#fcb814",navy = "#143047")

    data_31$area <- factor(data_31$area, levels = rev(c(    "Arts, entertainment and recreation",
                                                            "Accommodation and food services",
                                                            "Management of companies and enterprises",
                                                            "Information and cultural industries",
                                                            "Transportation and warehousing",
                                                            "Wholesale trade",
                                                            "Finance and insurance",
                                                            "Forestry and logging",
                                                            "Public administration",
                                                            "Mining, quarrying, oil and gas")))




    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.7b <- plot_ly(data_31, y = ~area, x = data_31$`percent`, type = "bar", marker = list(color = custom_colors2), orientation = 'h')

    plot2.7b <- plot2.7b %>% layout(title = '',
                                    yaxis = list(title = 'Value'),
                                    showlegend = FALSE
    )


  })

  # plot2.7c----
  output$plot2.7c <- renderPlotly({

    data_32 <- data$data_32

    custom_colors2 <- c(yellow= "#fcb814",navy = "#143047")

    data_32$area <- factor(data_32$area, levels = rev(c(    "Arts, entertainment and recreation",
                                                            "Accommodation and food services",
                                                            "Management of companies and enterprises",
                                                            "Information and cultural industries",
                                                            "Transportation and warehousing",
                                                            "Wholesale trade",
                                                            "Finance and insurance",
                                                            "Forestry and logging",
                                                            "Public administration",
                                                            "Mining, quarrying, oil and gas")))




    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.7c <- plot_ly(data_32, y = ~area, x = data_32$`percent`, type = "bar", marker = list(color = custom_colors2), orientation = 'h')

    plot2.7c <- plot2.7c %>% layout(title = '',
                                    yaxis = list(title = 'Value'),
                                    showlegend = FALSE
    )


  })


















  # plot3.01----


  output$plot3.01 <- renderPlotly({
    ## divide by 100 to be able to make y-axis percents
    canada_average <- .135

    plot_data <- data$data_38 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot3.01 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.55,
        y = 0.88,
        text = "— Canadian Average 13.5%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })




  # plot3.02----


  output$plot3.02 <- renderPlotly({
    ## divide by 100 to be able to make y-axis percents
    canada_average <- -.031

    plot_data <- data$data_39 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot3.02 <- plot_ly(plot_data,
                        x = ~Province,
                        y = ~Percent,
                        type = "bar",
                        marker = list(color = ~selected_color),
                        text = ~paste(Province,":",Label),
                        textposition = "none",
                        hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.55,
        y = 0.28,
        text = "— Canadian Average -3.1%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })




  # plot3.03a----
  output$plot3.03a <- renderPlotly({
    bc_average <- 0.08
    data_40 <- data$data_40

    custom_colors2 <- c(yellow= "#fcb814",navy = "#143047")

    data_40$area <- factor(data_40$area, levels = rev(c(    "Northeast",
                                                            "North Coast & Nechako",
                                                            "Cariboo",
                                                            "Kootenay",
                                                            "Thompson-Okanagan",
                                                            "Mainland/Southwest",
                                                            "Vancouver Island/Coast")))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot3.03a <- plot_ly(data_40, y = ~area, x = data_40$`percent`, type = "bar", marker = list(color = custom_colors2), orientation = 'h')

    plot3.03a <- plot3.03a %>% layout(xaxis = list(title = ""),
                                           yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
                                           shapes = list(vline(bc_average))) %>% ## add line
                                      add_annotations( ## add BC average text
                                        x = 0.01,
                                        y = 0.99,
                                        text = "— BC Average +0.8%",
                                        xref = "paper",
                                        yref = "paper",
                                        xanchor = "left",
                                        yanchor = "bottom",
                                        showarrow = F
                                      )




  })


  # plot3.03b----
  output$plot3.03b <- renderPlotly({
    bc_average <- -.009
    data_41 <- data$data_41

    custom_colors2 <- c(yellow= "#fcb814",navy = "#143047")

    data_41$area <- factor(data_41$area, levels = rev(c(    "Northeast",
                                                            "North Coast & Nechako",
                                                            "Cariboo",
                                                            "Kootenay",
                                                            "Thompson-Okanagan",
                                                            "Mainland/Southwest",
                                                            "Vancouver Island/Coast")))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot3.03b <- plot_ly(data_41, y = ~area, x = data_41$`percent`, type = "bar", marker = list(color = custom_colors2), orientation = 'h')

    plot3.03b <- plot3.03b %>% layout(xaxis = list(title = ""),
                                      yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
                                      shapes = list(vline(bc_average))) %>% ## add line
      add_annotations( ## add BC average text
        x = 0.01,
        y = 0.99,
        text = "— BC Average -0.9%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })


  # plot3.1a----

  output$plot3.1a <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.1a <- plot_ly(data$data_42, x = ~help_type, y = ~counts, color = ~type, type = "bar", textposition = 'inside',
                        colors = custom_colors) %>%
      layout(barmode = 'stack')

  })



  # plot3.1b----

  output$plot3.1b <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.1b <- plot_ly(data$data_42, x = ~type, y = ~counts, color = ~help_type, type = "bar", textposition = 'inside',
                        colors = custom_colors) %>%
      layout(barmode = 'stack')

  })



  # plot3.2----

  output$plot3.2 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.2 <- plot_ly(data$data_43, x = ~years, y = ~counts, color = ~help_type, type = "bar", textposition = 'inside',
                        colors = custom_colors) %>%


    layout(title = "",
           legend = list(orientation = "h", x = 0, y = 1.2),
           xaxis = list(title = "Year"),
           yaxis = list(title = "",
                        tickformat = ",",
                        tickprefix = "",
                        ticksuffix = "K",
                        dtick = 100),
           barmode = "group")


  })





  # plot3.3----


  output$plot3.3 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.3 <- plot_ly(data$data_44, x = ~counts, y = ~agegroup, color = ~emp_type, type = "bar", textposition = 'inside',
                       colors = custom_colors, orientation = 'h') %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),

             barmode = "relative")


  })





  # plot3.3b----

  output$plot3.3b <- renderPlotly({
    line_chart <- plot_ly(data$data_35_result, x = ~years, y = data$data_35_result$`15-24`, type = "scatter", mode = "lines",  name = "15-24 years old", line = list(color = "yellow")) %>%
      add_trace(y = data$data_35_result$`25-34`, type = 'scatter', mode = "lines", name = "25-34 years", line = list(color = "#FDB813")) %>%
      add_trace(y = data$data_35_result$`35-44`, type = 'scatter', mode = "lines", name = "35-44 years", line = list(color = "#005182")  ) %>%
      add_trace(y = data$data_35_result$`45-54`, type = 'scatter', mode = "lines", name = "45-54 years", line = list(color = "#92B6D3")  ) %>%
      add_trace(y = data$data_35_result$`55-64`, type = 'scatter', mode = "lines", name = "55-64 years", line = list(color = "#0E84B1")  ) %>%
      add_trace(y = data$data_35_result$`65+`, type = 'scatter', mode = "lines", name = "65+ years", line = list(color = "#14997C")  )

    plot3.3b <- layout(line_chart,
                       xaxis = list(title = ""),
                       yaxis = list(
                         tickvals = seq(0, 1, 0.05),
                         ticktext = paste0(seq(0, 100, 5), "%"),
                         legend = list(title = "Age Group")
                       )
    )

  })





  # plot3.4----
  output$plot3.4 <- renderPlotly({

    ## divide by 100 to be able to make y-axis percents
    canada_average <- 0.371

    plot_data <- data$data_45 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot3.4 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.01,
        y = 0.99,
        text = "— Canadian Average 37.1%",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

    plot3.4
  })




  # plot3.5 ----

  output$plot3.5 <- renderPlotly({

    data_46 <- data$data_46

    data_46$region <-factor(data_46$region, levels = rev(c(    "Northeast",
                                                               "Mainland/Southwest",
                                                               "Thompson-Okanagan",
                                                               "Vancouver Island/Coast",
                                                               "Cariboo",
                                                               "Kootenay",
                                                               "North Coast & Nechako",
                                                               "Total")))

    plot3.5 <- plot_ly(data_46, x = data_46$`2017`,y = data_46$region, name = '2017',
                marker = list(color = "#005182"),
                type = "bar", orientation = 'h') %>%

      add_trace(y = data_46$region, x = data_46$`2022`, name = '2022', type = 'bar',
                marker = list(color = "#FDB813")
      )
    plot3.5 <- layout(plot3.5,
                       legend = list(orientation = "v", x = 0, y = 1.2),
                       xaxis = list(tickformat = '.0'),
                      barmode = "group"


    )




  })


  # plot3.6----

  output$plot3.6 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.6 <- plot_ly(data$data_47, x = ~year, y = ~counts, color = ~indig, type = "bar", textposition = 'inside',
                       colors = custom_colors) %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             xaxis = list(title = "Year"),
             yaxis = list(title = "",
                          tickformat = ",",
                          tickprefix = "",
                          ticksuffix = "K",
                          dtick = 100),
             barmode = "group")


  })


  # plot3.7a----


  output$plot3.7a <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.7a <- plot_ly(data$data_48, x = ~counts, y = ~hours, color = ~work_week, type = "bar", textposition = 'inside',
                       colors = custom_colors, orientation = 'h') %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),

             barmode = "relative")


  })





  # plot3.7b----


  output$plot3.7b <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.7b <- plot_ly(data$data_49, x = ~counts, y = ~hours, color = ~sex, type = "bar", textposition = 'inside',
                        colors = custom_colors, orientation = 'h') %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),

             barmode = "relative")


  })
















}

# Run the app
shinyApp(ui, server)
