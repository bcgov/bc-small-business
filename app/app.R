# Load required libraries
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(ggplot2)
library(sf)
library(tidyr)

data <- readRDS("data/data.rds")
last_updated <- "V1.1 Aug 24, 2023"


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
                                            dashboardHeader(title = ""),
                                            ## dashboard sidebar ----
                                            dashboardSidebar(minified = FALSE, collapsed = FALSE,
                                                             sidebarMenu(style = "position: fixed; overflow: visible;",
                                                               id = "tabs", ## to be able to update with buttons on landing page
                                                               menuItem("Home", tabName = "home", icon = icon("home")),

                                                               menuItem("Small Business Growth", tabName = "page1", icon = icon("line-chart")),
                                                               menuItem("Small Business Employment", tabName = "page2",icon = icon("users")),
                                                               menuItem("Self-Employed", tabName = "page3", icon = icon("user"),
                                                                        menuSubItem("Main", tabName = "main"),
                                                                        menuSubItem("Women", tabName = "women"),
                                                                        menuSubItem("Indigenous people", tabName = "indigenous")),
                                                               menuItem("Contribution to Economy", tabName = "page4", icon = icon("usd")),
                                                               menuItem("Small Business Exports", tabName = "page5", icon = icon("truck")),
                                                               menuItem("Other Indicators", tabName = "page0", icon = icon("file-text")),
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
                                              tags$head(
                                                # Custom CSS to hide content initially and style the toggle button
                                                tags$style(HTML("
        .hidden-content {
          display: none;
        }
        .toggle-button {
          cursor: pointer;
          color: blue;
        }
      ")),
                                                # JavaScript to toggle visibility
                                                tags$script(HTML("
        $(document).on('click', '.toggle-button', function() {
          $('.hidden-content').toggle();
          $(this).text($(this).text() == '+' ? '-' : '+');
        });
      "))
                                              ),


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



                                                ## page 0 tab start ----
                                                tabItem(
                                                  tabName = "page0",

                                       #                       "page 0",
                                                  fluidRow(

                                                    box(title = "Figure K1 - Small businesses tax rates by province, 2022",
                                                        plotlyOutput("plotK1"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure K2 - Total building permits per capita, 2022",
                                                        plotlyOutput("plotK2"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats</small>")

                                                    ),

                                                    box(title = "Figure K3 - Bankruptcies per 1,000 businesses",
                                                        plotlyOutput("plotK3"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> Innovation, Science and Economic Development Canada / Prepared by BC Stats.</small>")

                                                    ),

)),
                                                ## page 0 tab end ----






                                                ## page 1 tab start ----
                                                tabItem(
                                                  tabName = "page1",
                                                  fluidRow(

                                                    box(title = "Figure 1.0.0: Breakdown of businesses in British Columbia, 2022", DTOutput("datatable1"),
                                                        style = "border: 1px solid white;", width = 10,
                                                        br(),
                                                        HTML("<b><small>Note: </b>Figures do not add to 100% due to rounding.
                                                             <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),



                                                    box(title = "Figure 1.1 - Count of small businesses in British Columbia",
                                                        plotlyOutput("plot1.1"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 1.0.1 - Share of businesses and organizations by size, 2022",
                                                        plotlyOutput("plot1.0.1"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),
#
#
#                                                     box(title = "jsut 1.2a1 - Count of small businesses in British Columbia",
#                                                         plotlyOutput("plot1.2test"), width = 10,
#                                                         br(),
#                                                         HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
#
#                                                     ),
#


                                                    box(title = "Figure 1.2a - One, two and five-year growth of B.C. businesses by size",
                                                        width = 10,
                                                        solidHeader = TRUE,
                                                        tabsetPanel(
                                                          tabPanel("1 year", plotlyOutput("plot1.2a1"), style = "width: 4"),
                                                          tabPanel("2 year", plotlyOutput("plot1.2a2")),
                                                          tabPanel("5 year", plotlyOutput("plot1.2a3"))
                                                        ),
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),



                                                    box(title = "Figure 1.3a: Distribution of small businesses by industry, 2022",
                                                      plotlyOutput("plot1.3a"), width = 10, br(),
                                                        HTML("<b><small></b> <p><b>Note:</b> Primary* is comprised of the agriculture, forestry,
                                      fishing, mining, oil and gas industries. The total does not sum to 100% as some businesses
                                      with employees could not be classified by industry.
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 1.3b: Distribution of small businesses with and without employees by industry, 2022",
                                                        plotlyOutput("plot1.3b"), width = 10, br(),
                                                        HTML("<b><small></b> <p><b>Note:</b> Primary is comprised of the agriculture, forestry,
                                      fishing, mining, oil and gas industries. Self-employment in utilities is less than 1500. Industries
                                      do not sum to 100% as some businesses with employees could not be classified by industry.
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                    ),

                                                    box(title = "Figure 1.4: Small businesses by industry, proportions with and without employees, 2022", plotlyOutput("plot1.4"), width = 10,
                                                        br(),
                                                        HTML("<small>
                                                       <p><b>Note:</b> Primary is comprised of the agriculture, forestry, fishing, mining, oil and gas industries.
                                                       <p><b>Note:</b> Utilities is not shown because the number of small businesses with employees is <200 and self-employment without paid help is very small and suppressed for confidentiality reasons.
                                                       <p><b>Source:</b> BC Stats using data supplied by Statistics Canada
                                                       <p><b>Description:</b> This chart shows the percentage of businesses with no employees compared to buisinesses with employees for select industries.
                                                             </small>")

                                                    ),
#
#                                                     box(title = "Figure 1.5: Fastest growing industries by number of net new small businesses with employees, British Columbia, 2017-2022", plotlyOutput("plot1.5"), width = 10,
#                                                         br(),
#                                                         HTML("<small>
#                                                        <p><b>Note:</b> Excludes self-employed without paid help.
#                                                        <p><b>Source:</b> BC Stats using data supplied by Statistics Canada
#                                                        <p><b>Description:</b> This chart shows the five industries with the most net new businesses in the last five years in British Columbia. The number of net new businesses is also shown for non-standard industries.
#                                                        <p><b>Definitions: <i>Tourism</i></b> includes industries such as transportation, accommodation, food services and other tourismrelated activities. Further information on the tourism sector is available at BC Stats.
#                                                        <p><b>     <i>High technology</i></b> industries may employ a high proportion of scientists and researchers or invest a high proportion of revenues in research and development. Other industries that produce
#                                                        high technology products are also included. Further information on the high technology sector is available online at BC Stats.
#                                                        <p><b>     <i>Secondary manufacturing</i></b> industries are those that produce goods from the products of other manufacturers. For example, a sawmill is a manufacturing operation, but not a secondary manufacturer,
#                                                              because its logs do not come from another manufacturer. On the other hand, a factory producing wooden doors with lumber obtained from sawmills is a secondary manufacturer.
#                                                         </small>")
#                                                     ),
#
                                                    box(title = "Figure 1.5: Fastest growing industries by number of net new small businesses with employees, British Columbia, 2017-2022",
                                                        HTML("<p><small><i>This chart shows the five industries with the most net new businesses in the last five years in British Columbia.
                                                        The number of net new businesses is also shown for non-standard industries.</i></small>"), plotlyOutput("plot1.5"), width = 10,
                                                        br(),
                                                        tags$span("+", class = "toggle-button"),


                                                        HTML("<small>
                                                       <p><b>Note:</b> Excludes self-employed without paid help.
                                                       <p><b>Source:</b> BC Stats using data supplied by Statistics Canada</small>"),



                                                        tags$div(HTML("<small><p><b>Definitions: <i>Tourism</i></b> includes industries such as transportation, accommodation, food services and other tourism related activities. Further information on the tourism sector is available at BC Stats.
                                                        <p><b>     <i>High technology</i></b> industries may employ a high proportion of scientists and researchers or invest a high proportion of revenues in research and development. Other industries that produce
                                                        high technology products are also included. Further information on the high technology sector is available online at BC Stats.
                                                        <p><b>     <i>Secondary manufacturing</i></b> industries are those that produce goods from the products of other manufacturers. For example, a sawmill is a manufacturing operation, but not a secondary manufacturer,
                                                        because its logs do not come from another manufacturer. On the other hand, a factory producing wooden doors with lumber obtained from sawmills is a secondary manufacturer.</small>"),
                                                                 class = "hidden-content")
                                                    ),
                                                    box(title = "Figure 1.6: Sector growth rates for number of small businesses with employees, British Columbia, 2017-2020", plotlyOutput("plot1.6"), width = 10,
                                                        br(),
                                                        HTML("<small>
                                                       <p><b>Note:</b> Excludes self-employed without paid help.
                                                       <p><b>Source:</b> BC Stats using data supplied by Statistics Canada"),
                                                        fluidRow(box(title = HTML("<p><b>Description:</b></small>"),
                                                                     HTML("<p>This chart shows the five industries with the highest growth
                                                                     rate in the number of net new businesses in the
                                                                     last five years in British Columbia. Net new business
                                                                     growth rates are also shown for non-standard industries.
                                                             </small>"),
                                                                     collapsible = TRUE, collapsed = TRUE))),




                                                    box(title = "Figure 1.7: Small businesses per capita by province, 2022", plotlyOutput("plot1.7"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 1.8: Small business growth by province, 2022", plotlyOutput("plot1.8"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 1.9: Small business and population distribution by region in British Columbia, 2022", plotOutput("plot1.9", height = "470px"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 1.10: Small businesses per 1,000 persons", plotlyOutput("plot1.10"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")


                                                    ),

                                                    box(title = "Figure 1.11a: Small businesses by region, 2022", plotlyOutput("plot1.11a"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")


                                                    ),
                                                    box(title = "Figure 1.11b: Small businesses by region, growth 2017-2022", plotlyOutput("plot1.11b"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                    )
                                                  )),

                                                ## page 1 tab end ----

                                                ## page 2 tab start----
                                                tabItem(
                                                  tabName = "page2",
                                                  fluidRow(

                                                    box(title = "Figure 2.0.0: Private sector employment in British Columbia by size of business, 2022", DTOutput("datatable2"),
                                                        style = "border: 1px solid white;", width = 10,
                                                        br(),
                                                        HTML("<b><small><p>Note:</b> Includes the self-employed with and without paid help.
                                                             <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 2.1 Share of total employment in British Columbia, 2022", plotlyOutput("plot2.1"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),



                                                    box(title = "Figure 2.3: Share of employment by establishment size, 2022", plotlyOutput("plot2.3"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),



                                                    box(title = "Figure 2.4b: Year-over-year growth in private sector employment", plotlyOutput("plot2.4b"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),


                                                    box(title = "Figure 2.5a: Five-year small business employment growth by province, 2017-2021", plotlyOutput("plot2.5a"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 2.5b: One-year small business employment growth by province, 2021-2022", plotlyOutput("plot2.5b"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 2.6: Small Business as a percent of private-sector employment by province, 2017-2022", plotlyOutput("plot2.6"), width = 10,
                                                    br(),
                                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),


                                                     box(title = "Figure 2.7a: One-year top and bottom industries for small business employment growth in British Columbia, 2021-2022", plotlyOutput("plot2.7a"), width = 10,
                                                     br(),
                                                     HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),

                                                    box(title = "Figure 2.7b: Two-year top and bottom industries for small business employment growth in British Columbia, 2020-2022", plotlyOutput("plot2.7b"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                                    ),


                                                    box(title = "Figure 2.7c: Five-year top and bottom industries for small business employment growth in British Columbia, 2017-2022", plotlyOutput("plot2.7c"), width = 10,
                                                        br(),
                                                        HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                    )
                                                  )),

                                                ## page 2 tab end ----




                                                ## page 3 tab start ----
                                                tabItem(
                                                  tabName = "page3", #"page 3",


                                                ),

                                               ## page 3 tab end ----

                                               ## page 3 subtab main start ----
                                               tabItem(
                                                 tabName = "main",
                                            #     "page 3 - main",

                                                 fluidRow(


                                                     box(title = "Figure 3.01: Self-employment as a per cent of total employment by province, 2022", plotlyOutput("plot3.01"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Note:</b> Excludes self-employed without paid help.
                                                        <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                     ),

                                                     box(title = "Figure 3.02: Self-employment per cent change by province, 2017-2022", plotlyOutput("plot3.02"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                     ),

                                                     box(title = "Figure 3.03a: Self-employment per cent change for regions in British Columbia, 2017-2022", plotlyOutput("plot3.03a"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                     ),

                                                     box(title = "Figure 3.03b: Self-employment per cent change for regions in British Columbia, 2021-2022", plotlyOutput("plot3.03b"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                     ),

                                                     box(title = "Figure 3.1a: Number of self-employed business owners in British Columbia, 2022", plotlyOutput("plot3.1a"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                     ),



                                                     box(title = "Figure 3.1b: Number of self-employed business owners in British Columbia, 2022", plotlyOutput("plot3.1b"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                     ),

                                                     box(title = "Fig3.2: Number of self-employed with paid help compared to self-employed without paid help, British Columbia, 2017-2022", plotlyOutput("plot3.2"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                     ),

                                                     box(title = "Fig3.3: Age distribution of self-employed workers compared to employees, British Columbia, 2022", plotlyOutput("plot3.3"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats</small>")
                                                     ),

                                                     box(title = "Fig3.3b: Share of British Columbian workers who are self-employed, by age", plotlyOutput("plot3.3b"), width = 10,
                                                         br(),
                                                         HTML("<b><small> <p>Notes</b>: Figures do not add to 100% due to rounding.
                                                              <p><b><b>Source:</b></b> Statistics Canada / Prepared by BC Stats</small>")
                                                     ),


                                                     box(title = "Figure 3.7a: Hours worked, self-employed compared to employees, British Columbia, 2022", plotlyOutput("plot3.7a"), width = 10,
                                                         br(),
                                                         HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100% due to rounding.<p>
                                                         <b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                     ),





                                                 ),
                                               ),
                                               ## page 3 subtab main end -----




                                               ## page 3 subtab women start ----
                                               tabItem(
                                                 tabName = "women",
                                           #      "page 3 - women",

                                                 fluidRow(

                                                   box(title = "Figure 3.4: Proportion of self-employed who are women by province, 2022", plotlyOutput("plot3.4"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Excludes unpaid family workers.
                                                        <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),

                                                   box(title = "Figure 3.5: Proportion of self-employed who are women, by region", plotlyOutput("plot3.5"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Includes unpaid family workers.
                                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),

                                                   box(title = "Figure 3.7b: Usual hours worked, self-employed by sex, British Columbia, 2022", plotlyOutput("plot3.7b"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100% due to rounding.<p>
                                                         <b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                   ),

                                                 ),
                                               ),
                                               ## page 3 subtab women end -----
                                               ## page 3 subtab indigenous start ----
                                               tabItem(
                                                 tabName = "indigenous",
                                             #    "page 3 - indigenous",


                                                 fluidRow(

                                                   box(title = "Figure 3.6: Percent of working, off-reserve Indigenous and non-Indigenous people who are self-employed in BC, 2017-2022", plotlyOutput("plot3.6"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                                   ),



                                                 ),
                                               ),
                                               ## page 3 subtab indigenous end ----
                                               ## page 4 tab start ----
                                               tabItem(
                                                 tabName = "page4",
                                        #         "page 4",

                                                 fluidRow(

                                                   box(title = "Figure 4.1: Small business contribution to GDP by province, 2022", plotlyOutput("plot4.1"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Gross Domestic Product (GDP) refers to the
                                                       total market value of all the goods and services produced within national
                                                       or provincial borders during a specified period. The growth rates of GDP
                                                       provide an indication of how well an industry or an economy is doing.

                                                        <p><b>Source:</b> BC Stats.</small>")
                                                   ),

                                                   box(title = "Figure 4.2: Average annual earnings, British Columbia, 2017-2022", plotlyOutput("plot4.2"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Average annual earnings Refers to the
                                                            gross taxable payroll of an employee, expressed on an annual basis,
                                                            including pay for overtime.

                                                           <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),


                                                   box(title = "Figure 4.3: Average annual earnings by industry in B.C., 2022", plotlyOutput("plot4.3"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada. </small>")
                                                   ),

                                                   box(title = "Figure 4.4: Difference in average annual earnings for small and large businesses by industry, British Columbia, 2017 and 2022", plotlyOutput("plot4.4"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),

                                                   box(title = "Figure 4.5: Average annual earnings by province, 2022", plotlyOutput("plot4.5"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),

                                                   box(title = "Figure 4.6: Small business share of total payroll by province, 2022", plotlyOutput("plot4.6"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),




                                               )),
                                               ## page 4 tab end ----
                                               ## page 5 tab start ----
                                               tabItem(
                                                 tabName = "page5",
                                             #    "page 5",

                                                 fluidRow(

                                                   box(title = "Figure 5.1: Number of British Columbia exporters and value of exports, 2017-2022", DTOutput("datatable5.1"),
                                                       style = "border: 1px solid white;", width = 10
                                                   ),

                                                   box(title = "Figure 5.2: Growth in small business exporters and exports by province, 2017-2022", DTOutput("datatable5.2"),
                                                       style = "border: 1px solid white;", width = 10
                                                   ),

                                                   box(title = "Figure 5.3b: Share of businesses by destination of exports, 2022", plotlyOutput("plot5.3b"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Excludes self-employed without paid help.
                                                        <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),

                                                   box(title = "Figure 5.3: Share of export value by destination of exports, 2022", plotlyOutput("plot5.3"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100 per cent due to rounding.
                                                        <p><b>Source:</b> Statistics Canada / Prepared by BC Stats. </small>")
                                                   ),
                                                   box(title = "Figure 5.4: Destination share of value of small businesss exports by province, 2022", plotlyOutput("plot5.4"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b>
                                                        <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),
                                                   box(title = "Figure 5.5: Export intensity for small businesses by province, 2022", plotlyOutput("plot5.5"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b> <p><b>Note:</b> Export intensity refers to the average value of exports per business.

                                                        <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),

                                                   box(title = "Figure 5.04: Value of goods exports for small and large businesses, 2022", plotlyOutput("plot5.04"), width = 10,
                                                       br(),
                                                       HTML("<b><small></b><p><b>Note:</b> A small business exporter is defined as an enterprise with fewer than 50 employees
                                                       that exports goods out of the country, regardless of the value of exports.

                                                        <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                                   ),


                                                 ),





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
     custom_colors <- c(yellow= "#fcb814", light_green = "#95c1b2", green = "#15987b",
       light_blue =  "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082",navy = "#143047")


  custom_colors_rgb <- list(yellow= c(252,184,20), light_green = c(149,193,178), green = c(21,152,123),
                            light_blue=c(146,181,210), med_blue=c(14,131,176), dark_blue = c(1,80,130),
                            navy = c(20,48,71))



  # plotK1----
  output$plotK1 <- renderPlotly({

 data$data_K1$Rate <- data$data_K1$Rate / 100

    plot_data <- data$data_K1 %>%
      mutate(Label = paste0(round_half_up(Rate*100, digits = 1), "%"),

             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))



    plotK1 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Rate,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "Tax Rate", tickformat = ".1%") ## make y-axis percents

      )


  })



  # plotK2----
  output$plotK2 <- renderPlotly({

    ## divide by 100 to be able to make y-axis percents
    canada_average <- 3316

    plot_data <- data$data_K2 %>%
      mutate(Label = paste0(round_half_up(`2022`, digits = 1), "2022"),

             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plotK2 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~`2022`,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "$"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.35,
        y = 0.85,
        text = "<b>— All of Canada = $3,316 per capita</b>",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })


  # plotK3----
  output$plotK3 <- renderPlotly({

    canada_average <- 0.6


    plot_data <- data$data_K3 %>%
      mutate(Label = paste0(round_half_up(Rate, digits = 1), ""),

             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))



    plotK3 <- plot_ly(plot_data,
                      x = ~Province,
                      y = ~Rate,
                      type = "bar",
                      marker = list(color = ~selected_color),
                      text = ~paste(Province,":",Label),
                      textposition = "none",
                      hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = ".1f"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line

             add_annotations( ## add canadian average text
               x = 0.05,
               y = 0.33,
               text = "<b>0.6 = Canadian Average</b>",
               xref = "paper",
               yref = "paper",
               xanchor = "left",
               yanchor = "bottom",
               showarrow = F
             )
  })




  #datatable1.0.0----

  # Render the table
  output$datatable1 <- renderDT({

    # Create your dataframe with the desired data
    table_data <- data$data_11 %>%
      mutate(`Per cent of small businesses1` = ifelse(`Per cent of small businesses1` == "-", "0", `Per cent of small businesses1`)) %>%
      rename_at(vars(ends_with("1")), str_replace_all, "1", "*")

    # Create the datatable
    datatable(table_data,
              rownames = FALSE,
              colnames = c("", names(table_data)[-1]),
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
                columnDefs = list(list(width = '300px', targets = 0))
              ),
              ## add caption
              # caption = htmltools::tags$caption(
              #   style = 'caption-side: bottom;',
              #   '*Figures do not add to 100% due to rounding'
              # )
    )  %>%
      ## helper functions for formatting
      formatRound(c("Number of businesses", "Growth 2021-2022 (#)", "Growth 2017-2022 (#)"), mark = ",", digits = 0) %>%  ## add commas to large numbers
      formatPercentage("Per cent of all businesses*") %>%
      formatPercentage("Per cent of small businesses*", zero.print = "-") %>%
      formatPercentage(c("Growth 2021-2022 (%)", "Growth 2017-2022 (%)"), digits = 1) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2,5,7), textAlign = "right") %>%
      formatStyle(c(3,4,6,8), textAlign = "center") %>%
      formatStyle(columns = 1:ncol(table_data),
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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot1.0.1 <- plot_ly(data_001, y = ~Type, x = data_001$`Percentage`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot1.0.1 <- plot1.0.1 %>%

      layout(title = '',
             xaxis = list(tickformat = ".0%"),
             yaxis = list(title = ""),


                                      showlegend = FALSE) %>%

    add_annotations( ## add requested additional info on chart
      x = -.5,
      y = 0.99,
      text = "<b>Total businesses and organizations = 513,300</b>",
      xref = "paper",
      yref = "paper",
      xanchor = "left",
      yanchor = "bottom",
      showarrow = F
    )


  })








  # plot1.1----
  output$plot1.1 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()

    # Create the stacked bar chart with custom colors
    plot1.1 <- plot_ly(data$data_09, x = ~years, y = ~count, color = ~category, type = "bar", textposition = 'inside',
                       colors = custom_colors) %>%
      layout(title = "",
             xaxis = list(title = ""),
             yaxis = list(title = "Employees"),
             barmode = "relative",
             showlegend = TRUE,
             legend = list(orientation = "h", x = 0, y = 1.3))


  })








  # plot1.2a1 ----


  output$plot1.2a1 <- renderPlotly({


    data$data_10$`employee count` <-factor(data$data_10$`employee count`, levels = (c("300 or more employees",
                                                                               "250 to 299 employees",
                                                                               "200 to 249 employees",
                                                                               "150 to 199 employees",
                                                                               "100 to 149 employees",
                                                                               "50 to 99 employees",
                                                                               "Total large businesses",
                                                                               "30 to 49 employees",
                                                                               "20 to 29 employees",
                                                                               "10 to 19 employees",
                                                                               "5 to 9 employees",
                                                                               "1 to 4 employees",
                                                                               "Self-employed w/o paid help",
                                                                               "0 to 4 employees",
                                                                               "Total small businesses",
                                                                               "Total all businesses"
    )))






    # Create the plot
    plot1.2a1 <- plot_ly(data = data$data_10, x = ~`1-yr growth`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400) %>%


    layout(title = "",
           legend = list(orientation = "h", x = 0, y = 1.2),
           yaxis = list(title = ""),
           xaxis = list(title = "", tickformat = "0"),

           barmode = "relative")


  })


  # plot1.2a2 ----


  output$plot1.2a2 <- renderPlotly({


    data$data_10$`employee count` <-factor(data$data_10$`employee count`, levels = (c("300 or more employees",
                                                                                         "250 to 299 employees",
                                                                                         "200 to 249 employees",
                                                                                         "150 to 199 employees",
                                                                                         "100 to 149 employees",
                                                                                         "50 to 99 employees",
                                                                                         "Total large businesses",
                                                                                         "30 to 49 employees",
                                                                                         "20 to 29 employees",
                                                                                         "10 to 19 employees",
                                                                                         "5 to 9 employees",
                                                                                         "1 to 4 employees",
                                                                                         "Self-employed w/o paid help",
                                                                                         "0 to 4 employees",
                                                                                         "Total small businesses",
                                                                                         "Total all businesses"
    )))



    # Create the plot
    plot1.2a2 <- plot_ly(data = data$data_10, x = ~`2-yr growth`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400) %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0"),

             barmode = "relative")

  })


  # plot1.2a3 ----

  output$plot1.2a3 <- renderPlotly({


    data$data_10$`employee count` <-factor(data$data_10$`employee count`, levels = (c("300 or more employees",
                                                                                         "250 to 299 employees",
                                                                                         "200 to 249 employees",
                                                                                         "150 to 199 employees",
                                                                                         "100 to 149 employees",
                                                                                         "50 to 99 employees",
                                                                                         "Total large businesses",
                                                                                         "30 to 49 employees",
                                                                                         "20 to 29 employees",
                                                                                         "10 to 19 employees",
                                                                                         "5 to 9 employees",
                                                                                         "1 to 4 employees",
                                                                                         "Self-employed w/o paid help",
                                                                                         "0 to 4 employees",
                                                                                         "Total small businesses",
                                                                                         "Total all businesses"
    )))




    # Create the plot
    plot1.2a3 <- plot_ly(data = data$data_10, x = ~`5-yr growth`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400) %>%


    layout(title = "",
           legend = list(orientation = "h", x = 0, y = 1.2),
           yaxis = list(title = ""),
           xaxis = list(title = "", tickformat = "0"),

           barmode = "relative")

  })




  # plot1.3a ----

  output$plot1.3a <- renderPlotly({

    data_12 <- data$data_12

    # Determine which x values to highlight just Non-Standard Sectors)
    highlight_label <- c("Goods Sector", "Services Sector")

    # Create custom tick labels
    custom_ticktext <- sapply(data_12$type, function(val) {
      if (val %in% highlight_label) {
        paste0("<span style='color: #005182'><b>", val, "<b></span>")
      } else {
        as.character(val)
      }
    })





    data_12$type <-factor(data_12$type, levels = rev(c("Goods Sector", "Construction", "Primary*", "Manufacturing", "Utilities",
                                                       "Services Sector", "Professional, scientific and technical services",
                                                       "Health & Social Services", "Finance, Insurance & Real Estate",
                                                       "Trade", "Other Services", "Transportation & Storage",
                                                       "Business, building and other support services",
                                                       "Information, Culture & Recreation", "Education Services",
                                                       "Accomodation & Food")))

    plot1.3a <- plot_ly(data_12, x = ~`%`, type = "bar", y = ~type,
                        marker = list(color = "#005182"), name = "",
                        orientation = 'h')

    plot1.3a <- layout(plot1.3a,
                       legend = list(orientation = "h", x = -2, y = 1.2),
                       xaxis = list(title = "", tickformat = '0.1%'),
                       yaxis = list(title = "", tickvals = ~type, ticktext = custom_ticktext)
    )

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
                       legend = list(orientation = "h", x = 0, y = 1.2),
                       xaxis = list(title = "", tickformat = '0.1%')


    )




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
                      legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
                      xaxis = list(tickformat = '0.1%')


    )



    # Display the chart
    plot1.4
  })

  # plot 1.5----
  output$plot1.5 <- renderPlotly({

    data_15 <- data$data_15

        # Determine which x values to highlight just Non-Standard Sectors)
    highlight_label <- "Non-Standard Sectors"

    # Create custom tick labels
    custom_ticktext <- sapply(data_15$type, function(val) {
      if (val %in% highlight_label) {
        paste0("<span style='color: #005182'><b>", val, "<b></span>")
      } else {
        as.character(val)
      }
    })

    custom_colors2 <- c( "#005182",  "#005182", "#005182", "#005182",
                         navy = "#143047",  navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047" )


    data_15$type <-factor(data_15$type, levels = rev(c("Professional, scientific and technical services", "Specialty trade contractors",
                                                       "Ambulatory health care services", "Real estate", "Social assistance",
                                                       "Non-Standard Sectors", "High tech total", "Tourism", "Secondary manufacturing")))

    plot1.5 <- plot_ly(data_15, x = ~number, type = "bar", y = ~type,
                       marker = list(color = custom_colors2), name = "adsfadsf",
                       orientation = 'h')


    plot1.5 <- layout(plot1.5,
                      legend = list(orientation = "h", x = -2, y = 1.2),
                      xaxis = list(tickformat = '', title = ""),
                      yaxis = list(title = "", tickvals = ~type, ticktext = custom_ticktext)



    )



  })

  # plot 1.6----

  output$plot1.6 <- renderPlotly({

    data_16 <- data$data_16

    custom_colors2 <- c( "#005182",  "#005182", "#005182", "#005182",
                         navy = "#143047",  navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047" )


    # Determine which x values to highlight just Non-Standard Sectors)
    highlight_label <- "Non-Standard Sectors"

    # Create custom tick labels
    custom_ticktext <- sapply(data_16$type, function(val) {
      if (val %in% highlight_label) {
        paste0("<span style='color: #005182'><b>", val, "<b></span>")
      } else {
        as.character(val)
      }
    })



    plot1.6 <- plot_ly(data_16, x = ~number, type = "bar", y = ~type,
                       marker = list(color = custom_colors2), name = "adsfadsf",
                       orientation = 'h')


    plot1.6 <- layout(plot1.6,
                      legend = list(orientation = "h", x = -2, y = 1.2),
                      xaxis = list(tickformat = '0.1%', title = ""),
                      yaxis = list(title = "", tickvals = ~type, ticktext = custom_ticktext))



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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

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
        x = 0.55,
        y = 0.85,
        text = "<b>— Canadian Average 81.7%</b>",
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
    canada_average <- 0.019

    plot_data <- data$data_18 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PEI", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

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
        x = 0.09,
        y = 0.63,
        text = "<b>— Canadian Average 1.9%</b>",
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

    data_20$region <- factor(data_20$region, levels = rev(c("Cariboo", "North Coast & Nechako", "Kootenay",
                                                      "Northeast",      "Vancouver Island/ Coast",
                                                            "Thompson - Okanagan", "Mainland/ Southwest")))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot1.10 <- plot_ly(data_20, y = ~region, x = data_20$`Total, 2022`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot1.10 <- plot1.10 %>% layout(title = '',
                                    yaxis = list(title = ''),
                                    showlegend = FALSE
    )

    # plot1.10 <- plot1.10 %>%
    #   add_text(text = paste0(data_20$`Total, 2022`, ""),
    #            textposition = "right",
    #            textfont = list(weight = "bold"))
    #


  })


  # plot1.11a----
  output$plot1.11a <- renderPlotly({




    custom_colors11 <- c(yellow= "#fcb814", light_green = "#95c1b2", green = "#15987b",
                       light_blue =  "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082",navy = "#143047")

    data_21a <- data$data_21a

    data_21a$region <- factor(data_21a$region, levels = rev(c( "Provincial Total",
                                                               "Mainland/Southwest",
                                                               "Vancouver Island/Coast",
                                                               "Thompson-Okanagan",
                                                               "Kootenay",
                                                               "Cariboo",
                                                               "North Coast & Nechako",
                                                               "Northeast")))








    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot1.11a <- plot_ly(data_21a, y = ~region, x = data_21a$`Total, 2022`, type = "bar",
                         marker = list(color = custom_colors11), orientation = 'h')

    plot1.11a <- plot1.11a %>% layout(title = '',
                                      xaxis = list(title = 'Number of Businesses'),
                                      yaxis = list(title = ""),
                                      showlegend = FALSE
    )









  })

  # plot1.11b----
  output$plot1.11b <- renderPlotly({

    custom_colors11 <- c(yellow= "#fcb814", light_green = "#95c1b2", green = "#15987b",
                         light_blue =  "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082",navy = "#143047")

    data_21b <- data$data_21b
    data_21b$`Growth rate` <- round(data_21b$`Growth rate` , 2)

    data_21b$region <- factor(data_21b$region, levels = rev(c(   "Provincial Total",
                                                               "Mainland/Southwest",
                                                               "Vancouver Island/Coast",
                                                               "Thompson-Okanagan",
                                                               "Kootenay",
                                                               "Cariboo",
                                                               "North Coast & Nechako",
                                                               "Northeast")))


    plot1.11b <- plot_ly(data_21b, y = ~region, x = data_21b$`Growth rate`, type = "bar",
                         marker = list(color = custom_colors11), orientation = 'h')

    plot1.11b <- plot1.11b %>% layout(title = '',
                                      xaxis = list(title = 'Percentage Growth', tickformat = "0%"),
                                      yaxis = list(title = ""),
                                      showlegend = FALSE
    )







  })



  #datatable2.0----

  # Render the table
  output$datatable2 <- renderDT({

    # Create your dataframe with the desired data
    table_data2 <- data$data_21c

    # create a custom table header
    h_1 <- data$data_21c_headings$names[1]
    h_2 <- data$data_21c_headings$names[2]
    heading2 = htmltools::withTags(table(
      class = 'display',
      thead(
        tr(
          th(rowspan = 2, ''),
          th(rowspan = 2, 'Employment'),
          th(rowspan = 2, 'Per cent of small business'),
          th(rowspan = 2, 'Per cent of private sector'),
          th(colspan = 2, h_1),
          th(colspan = 2, h_2)
        ),
        tr(
          lapply(rep(c('Number', 'Per cent'), 2), th)
        )
      )
    ))

    ## create a datatable
    datatable(table_data2 %>% mutate(per_cent_of_small_business = ifelse(per_cent_of_small_business == "-", 0, per_cent_of_small_business)),
              container = heading2,
              rownames = FALSE,
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                paging = FALSE,
                dom = 't',
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
                columnDefs = list(list(width = '300px', targets = 0),
                                  list(width = '75px', targets = 3))
              )#,
              # ## add caption
              # caption = htmltools::tags$caption(
              #   style = 'caption-side: bottom;',
              #   '*Figures do not add to 100% due to rounding'
              # )
    )  %>%
      ## helper functions for formatting
      formatRound(c("employment", "number", "number_2"), mark = ",", digits = 0) %>%  ## add commas to large numbers
      formatPercentage(c("per_cent_of_small_business", "per_cent_of_private_sector"), zero.print = "-") %>%
      formatPercentage(c("per_cent","per_cent_2"), digits = 1) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:8, backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2,5,7), textAlign = "right") %>%
      formatStyle(c(3,4,6,8),textAlign = "center") %>%
      formatStyle(columns = 1:8,
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = nrow(table_data2), "#c4d6e7"),
                  color = styleRow(rows = nrow(table_data2), "#015082"),
                  fontWeight = styleRow(rows = nrow(table_data2), "bold")) %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(2,3), "30px"))
  })

  # plot2.1 ----
  output$plot2.1 <- renderPlotly({

    data_22 <- data$data_22

    data_22$sector <- factor(data_22$sector, levels = rev(c("Small Business",
                                                            "Large Business",
                                                            "Public Sector")))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot2.1 <- plot_ly(data_22, y = ~sector, x = data_22$`%`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot2.1 <- plot2.1 %>% layout(title = '',
                                  yaxis = list(title = ''),
                                  xaxis = list(title = '', tickformat = "0.1%"),
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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot2.3 <- plot_ly(data_25, y = ~sector, x = data_25$`%`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

    plot2.3 <- plot2.3 %>% layout(title = '',
                                  yaxis = list(title = ''),
                                  xaxis = list(title = '', tickformat = "0.1%"),
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
             yaxis = list(title = "Number of jobs"),
             xaxis = list(title = "", tickvals = ~years, ticktext = ~years),
             barmode = "relative", ## stack overlaps so use relative
             legend = list(x = 0, y = 1),
             hovermode = "x unified",
             ## to show all label regardless of length
             hoverlabel = list(namelength = -1)) # %>%
      # add_annotations(
      #   x = 0.04,
      #   y = 1.01,
      #   text = "Number of jobs",
      #   xref = "paper",
      #   yref = "paper",
      #   xanchor = "right",
      #   yanchor = "bottom",
      #   showarrow = F
      # )


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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot2.5a <- plot_ly(plot_data,
                        x = ~Province,
                        y = ~Percent,
                        type = "bar",
                        marker = list(color = ~selected_color),
                        text = ~paste(Province,":",Label),
                        textposition = "none",
                        hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "% Growth", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.11,
        y = 0.59,
        text = "<b>— Canadian Average 1.8%</b>",
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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot2.5b <- plot_ly(plot_data,
                        x = ~Province,
                        y = ~Percent,
                        type = "bar",
                        marker = list(color = ~selected_color),
                        text = ~paste(Province,":",Label),
                        textposition = "none",
                        hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "% Growth", tickformat = "0%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.5,
        y = 0.57,
        text = "<b>— Canadian Average 1.8%</b>",
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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

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
        x = 0.41,
        y = 0.89,
        text = "<b>— Canadian Average 46.6%</b>",
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
    data_30$`percent` <- data_30$`percent` / 100

    custom_colors2 <- c(yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",
                        navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047"  )

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




    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot2.7a <- plot_ly(data_30, y = ~area, x = data_30$`percent`, type = "bar", text = ~count, color = ~topbottom, colors = c("#143047", "#fcb814"), orientation = 'h')

    plot2.7a <- plot2.7a %>% layout(title = '',
                                    legend = list(orientation = "h", x = 0, y = 1.2),
                                    yaxis = list(title = ''),
                                    xaxis = list(tickformat = "0.1%"),
                                    showlegend = TRUE
                                    )



  })









  # plot2.7b----
  output$plot2.7b <- renderPlotly({

    data_31 <- data$data_31
    data_31$`percent` <- data_31$`percent` / 100

    custom_colors2 <- c(yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",
                        navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047" )


    data_31$area <- factor(data_31$area, levels = rev(c(   "Arts, entertainment and recreation",
                                                           "Accommodation and food services",
                                                           "Educational services",
                                                           "Other services (except public administration)",
                                                           "Health care and social assistance",
                                                           "Forestry and logging",
                                                           "Finance and insurance",
                                                           "Wholesale trade",
                                                           "Mining, quarrying, oil and gas",
                                                           "Public administration"

    )))




    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot2.7b <- plot_ly(data_31, y = ~area, x = data_31$`percent`, type = "bar", text = ~count, color = ~topbottom, colors = c("#143047", "#fcb814"), orientation = 'h')

    plot2.7b <- plot2.7b %>% layout(title = '',
                                    legend = list(orientation = "h", x = 0, y = 1.2),
                                    yaxis = list(title = ''),
                                    xaxis = list(tickformat = "0.1%"),
                                    showlegend = TRUE
    )


  })

  # plot2.7c----
  output$plot2.7c <- renderPlotly({

    data_32 <- data$data_32
    data_32$`percent` <- data_32$`percent` / 100


    custom_colors2 <- c(yellow= "top 5",yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",yellow= "#fcb814",
                        navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047", navy = "#143047" )

    data_32$area <- factor(data_32$area, levels = rev(c(  "Professional, scientific and technical services",
                                                          "Educational services",
                                                          "Health care and social assistance",
                                                          "Construction",
                                                          "Arts, entertainment and recreation",
                                                          "Information and cultural industries",
                                                          "Wholesale trade",
                                                          "Forestry and logging",
                                                          "Mining, quarrying, oil and gas",
                                                          "Public administration"
    )))


    plot2.7c <- plot_ly(data_32, y = ~area, x = data_32$`percent`, type = "bar", text = ~count, color = ~topbottom, colors = c("#143047", "#fcb814"), orientation = 'h')

    plot2.7c <- plot2.7c %>% layout(title = '',
                                    legend = list(orientation = "h", x = 0, y = 1.2),
                                    yaxis = list(title = ''),
                                    xaxis = list(tickformat = "0.1%"),
                                    showlegend = TRUE
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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

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
        text = "<b>— Canadian Average 13.5%</b>",
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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

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
        x = 0.65,
        y = 0.28,
        text = "<b>— Canadian Average -3.1%</b>",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })




  # plot3.03a----
  output$plot3.03a <- renderPlotly({
    bc_average <- 0.008
    data_40 <- data$data_40

    data_40$`percent` <- data_40$`percent` /100
    custom_colors3<- c(light_blue =  "#92b5d2")

    data_40$area <- factor(data_40$area, levels = rev(c(    "Northeast",
                                                            "North Coast & Nechako",
                                                            "Cariboo",
                                                            "Kootenay",
                                                            "Thompson-Okanagan",
                                                            "Mainland/Southwest",
                                                            "Vancouver Island/Coast")))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot3.03a <- plot_ly(data_40, y = ~area, x = data_40$`percent`, type = "bar", marker = list(color = custom_colors3), orientation = 'h')

    plot3.03a <- plot3.03a %>% layout(xaxis = list(title = "", tickformat = "0.1%", gridwidth = 2),## make axis percents
                                           yaxis = list(title = ""),
                                           shapes = list(vline(bc_average))) %>% ## add line
                                      add_annotations( ## add BC average text
                                        x = 0.5,
                                        y = .99,
                                        text = "<b>— Provincial Average +0.8%</b>",
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
    data_41$`percent` <- data_41$`percent` /100

    custom_colors3<- c(light_blue =  "#92b5d2")

    data_41$area <- factor(data_41$area, levels = rev(c(    "Northeast",
                                                            "North Coast & Nechako",
                                                            "Cariboo",
                                                            "Kootenay",
                                                            "Thompson-Okanagan",
                                                            "Mainland/Southwest",
                                                            "Vancouver Island/Coast")))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot3.03b <- plot_ly(data_41, y = ~area, x = data_41$`percent`, type = "bar", marker = list(color = custom_colors3), orientation = 'h')

    plot3.03b <- plot3.03b %>% layout(xaxis = list(title = "", tickformat = "0.1%", gridwidth = 2),## make axis percents
                                      yaxis = list(title = ""),
                                      shapes = list(vline(bc_average))) %>% ## add line
      add_annotations( ## add BC average text
        x = 0.4,
        y = .99,
        text = "<b>— Provincial Average -0.9%</b>",
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

    data$data_42$counts <- data$data_42$counts /1000

    plot3.1a <- plot_ly(data$data_42, x = ~help_type, y = ~counts, color = ~type, type = "bar",
                        colors = custom_colors) %>%
      layout(xaxis = list(title = ""),
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = "Thousands", tickformat = "0"),
             barmode = "stack"
      )

  })



  # plot3.1b----

  output$plot3.1b <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()
    data$data_42$counts <- data$data_42$counts /1000

    plot3.1b <- plot_ly(data$data_42, x = ~type, y = ~counts, color = ~help_type, type = "bar", textposition = 'inside',
                        colors = custom_colors) %>%
      layout(xaxis = list(title = ""),
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = "Thousands", tickformat = "0"),
             barmode = "stack"
      )

  })



  # plot3.2----

  output$plot3.2 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.2 <- plot_ly(data$data_43, x = ~years, y = ~counts, color = ~help_type, type = "bar", textposition = 'inside',
                        colors = custom_colors) %>%


    layout(title = "",
           legend = list(orientation = "h", x = 0, y = 1.2),
           xaxis = list(title = ""),
           yaxis = list(title = "",
                        tickformat = ",",
                        tickprefix = "",
                        ticksuffix = "K",
                        dtick = 100),
           barmode = "group")


  })





  # # plot3.3----
  #
  #
  # output$plot3.3 <- renderPlotly({
  #
  #
  #
  #   custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")]
  #
  #
  #   plot3.3 <- plot_ly(data$data_44, x = ~counts, y = ~agegroup, color = ~emp_type, type = "bar", textposition = 'inside',
  #                      colors = custom_colors, orientation = 'h') %>%
  #
  #
  #     layout(title = "",
  #            legend = list(orientation = "h", x = 0, y = 1.2),
  #           yaxis = list(title = "Age"),
  #           xaxis = list(title = "",
  #                        tickvals = c(-.2, -.1, 0, .1, .2),
  #                        ticktext = c(.2, .1, 0, .1, .2),
  #                        tickformat = "0.1%"),
  #
  #            barmode = "relative")
  #
  #
  # })

  # plot3.3try3----


  output$plot3.3 <- renderPlotly({


    df <- data$data_44

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()

    df$counts <- df$counts *100

        df %>%
      mutate(counts = ifelse(test = emp_type == "Self-employed", yes = -counts, no = counts)) %>%
      mutate(abs_pop = abs(counts)) %>%

      plot_ly( x= ~counts, y=~agegroup, color=~emp_type, colors = custom_colors) %>%
      add_bars(orientation = 'h', hoverinfo = 'text', text = ~paste(sprintf("%.1f%%", abs_pop))) %>%
      layout(barmode = 'overlay',
         #   legend = list(orientation = "h", x = .5, y = 1.2)
         #   , categoryorder = "array", categoryarray = c("Self-employed", "Employees"),
             yaxis = list(title = ""),
            xaxis = list(title = "",
                         tickmode = 'array',
                         tickformat = "0.1%",
                         tickvals = c(-20, -10,  0, 10, 20),
                        ticktext = c('20%', '10%', '0', '10%', '20%'),
                        autorange = "reversed"


))





  })


  # # plot 3.3try2
  #
  #
  #
  # output$plot3.3 <- renderPlotly({
  #
  # se_positive <-  data$data_44$`se_positive`
  #
  # # Create age-sex pyramid plot
  # plot3.3 <- plot_ly() %>%
  #   add_trace(x = data$data_44$Employees, y = data$data_44$`agegroup`, type = "bar", overtext = se_positive, name = "Employees", marker = list(color = "#FDB813")) %>%
  #   add_trace(x = data$data_44$`Self-employed`, y = data$data_44$`agegroup`, type = "bar", name = "Self-employed", marker = list(color = "#005182")) %>%
  #   layout(barmode = 'relative',
  #          xaxis = list(title = "",
  #                       # ticktext = c(.35, .30, .25, .20, .15, .10, 0, .10, .15, .20, .25, .30, .35),
  #                       # tickvals = c(.35, .30, .25, .20, .15, .10, 0, .10, .15, .20, .25, .30, .35),
  #                       tickformat = "0.1%"),  # Custom tick values and labels
  #          yaxis = list(title = "Age"),
  #          title = "")
  #
  #
  #
  #
  #
  # })
  #


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

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot3.4 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0.1%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.2,
        y = 0.9,
        text = "<b>37.1% = Canadian Average </b>",
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


    data_46$`2017` <- data_46$`2017` / 100
    data_46$`2022` <- data_46$`2022` / 100


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
                       xaxis = list(tickformat = '0.1%'),
                      barmode = "group"


    )




  })


  # plot3.6----

  output$plot3.6 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()

    data$data_47$counts <-  data$data_47$counts / 100

    plot3.6 <- plot_ly(data$data_47, x = ~year, y = ~counts, color = ~indig, type = "bar", textposition = 'inside',
                       colors = custom_colors) %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             xaxis = list(title = ""),
             yaxis = list(title = "% Self-employed",
                          tickformat = "0.1%",
                          tickprefix = "",
                          ticksuffix = "" ,
                          dtick = .05),
             barmode = "group")


  })


  # plot3.7a----


  output$plot3.7a <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.7a <- plot_ly(data$data_48, x = ~counts, y = ~hours, color = ~work_week, type = "bar", textposition = 'inside',
                       colors = custom_colors, orientation = 'h') %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             xaxis = list(title = "", tickformat = "0.1%"),
             yaxis = list(title = ""),
             barmode = "relative")


  })





  # plot3.7b----


  output$plot3.7b <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


    plot3.7b <- plot_ly(data$data_49, x = ~counts, y = ~hours, color = ~sex, type = "bar", textposition = 'inside',
                        colors = custom_colors, orientation = 'h') %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             xaxis = list(title = "", tickformat = "0.1%"),
             yaxis = list(title = ""),
             barmode = "relative")


  })


  # plot4.1----
  output$plot4.1 <- renderPlotly({

    ## divide by 100 to be able to make y-axis percents
    canada_average <- 0.30

    plot_data <- data$data_50 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), "%"),
             Percent = Percent/ 100,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PEI", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot4.1 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0.1%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.2,
        y = 0.9,
        text = "<b>— Canadian Average 30%</b>",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })

















# plot4.2----

output$plot4.2 <- renderPlotly({

  custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()


  plot4.2 <- plot_ly(data$data_51, x = ~help_type, y = ~counts, color = ~type, type = "bar", textposition = 'inside',
                      colors = custom_colors) %>%


  layout(title = "",
         legend = list(orientation = "h", x = 0, y = 1.2),
         xaxis = list(title = "Payroll/Employee", tickformat = ""),
         yaxis = list(title = "Thousands", tickformat = "$"),
         barmode = "group") %>%

  add_annotations( ## add canadian average text
    x = 0.01,
    y = 0.79,
    text = "<b>Wage gap 2017 = $9,400 (-17.9%)</b>",
    xref = "paper",
    yref = "paper",
    xanchor = "left",
    yanchor = "bottom",
    showarrow = F
  ) %>%
    add_annotations( ## add canadian average text
      x = 0.5,
      y = 0.99,
      text = "<b>Wage gap 2022 = $10,300 (-16.1%)</b>",
      xref = "paper",
      yref = "paper",
      xanchor = "left",
      yanchor = "bottom",
      showarrow = F
    )





})




  # plot4.3 ----

  output$plot4.3 <- renderPlotly({

    data_52_result <- data$data_52
    # data_52_result <- data_52_result[order(data_52_result$`Small Business`),]
    #
    # data_52_result$segment <- factor(data_52_result$segment, levels = data_52_result$segment)
    #
    #
    data_52_result$segment <- factor(data_52_result$segment, levels = rev(c( "TOTAL, ALL INDUSTRIES",
                                                               "Mining, oil and gas",
                                                               "Utilities",
                                                               "Forestry",
                                                               "Professional & Business Services",
                                                               "Finance, Insurance & Real Estate",
                                                               "Construction",
                                                               "Transportation & Storage",
                                                               "Public Administration",
                                                               "Manufacturing",
                                                               "Information, Culture & Recreation",
                                                               "Health & Social Assistance",
                                                               "Other Services",
                                                               "Wholesale & Retail Trade",
                                                               "Educational Services",
                                                               "Accommodation & Food")))








    plot4.3 <- plot_ly(data_52_result, x = data_52_result$`Small Business`,
                        y = data_52_result$segment,

                        name = 'Small Business',
                        marker = list(color = "#005182"),
                        type = "bar",
                        orientation = 'h') %>%

      add_trace(y = data_52_result$segment, x = data_52_result$`Large Business`,
                name = 'Large Business', type = 'bar',
                marker = list(color = "#FDB813")
      )
    plot4.3 <- layout(plot4.3,
                      legend = list(orientation = "h", x = 0, y = 1.2),
                      xaxis = list(title = "$ Thousands", tickformat = ""),
                      yaxis = list(title = "", tickformat = "$", dtick = "")


    )



  })


  # plot4.4 ----

  output$plot4.4 <- renderPlotly({

    data_53_result <- data$data_53
   #  data_53_result <- data_53_result[order(data_53_result$`2017`),]
   #
   # data_53_result$segment <- factor(data_53_result$segment, levels = data_53_result$segment)


    data_53_result$segment <- factor(data_53_result$segment, levels = rev(c( "TOTAL",
                                                                             "Forestry",
                                                                             "Wholesale & Retail Trade",
                                                                             "Accommodation & Food",
                                                                             "Health & Social Assistance",
                                                                             "Transportation & Storage",
                                                                             "Mining, oil and gas",
                                                                             "Professional & Business Services",
                                                                             "Finance, Insurance & Real Estate",
                                                                             "Manufacturing",
                                                                             "Other Services",
                                                                             "Information, Culture & Recreation",
                                                                             "Public Administration",
                                                                             "Utilities",
                                                                             "Construction",
                                                                             "Educational Services"
                                                                            )))







    plot4.4 <- plot_ly(data_53_result, x = data_53_result$`2017`,
                       y = data_53_result$segment,

                       name = '2017',
                       marker = list(color = "#005182"),
                       type = "bar",
                       orientation = 'h') %>%

      add_trace(y = data_53_result$segment, x = data_53_result$`2022`,
                name = '2022', type = 'bar',
                marker = list(color = "#FDB813")
      )
    plot4.4 <- layout(plot4.4,
                      legend = list(orientation = "h", x = 0, y = 1.2),
                      xaxis = list(title = "$ Thousands", tickformat = ""),
                      yaxis = list(title = "", tickformat = "0.1", dtick = "")



    )



  })

  # plot4.5 ----

  output$plot4.5 <- renderPlotly({

    data_54_result <- data$data_54
    data_54_result <- data_54_result[order(data_54_result$`Small Business`),]

    data_54_result$segment <- factor(data_54_result$segment, levels = data_54_result$segment)

    plot4.5 <- plot_ly(data_54_result, x = data_54_result$`Small Business`,
                       y = data_54_result$segment,

                       name = 'Small Business',
                       marker = list(color = "#005182"),
                       type = "bar",
                       orientation = 'h') %>%

      add_trace(y = data_54_result$segment, x = data_54_result$`Large Business`,
                name = 'Large Business', type = 'bar',
                marker = list(color = "#FDB813")

    )
    plot4.5 <- layout(plot4.5,
                      legend = list(orientation = "h", x = .3, y = 1.2),
                      xaxis = list(title = "$ Thousands", tickformat = "")


    )



  })


  # plot4.6----
  output$plot4.6 <- renderPlotly({

    ## divide by 100 to be able to make y-axis percents
    canada_average <- 0.262

    plot_data <- data$data_55 %>%
      mutate(Label = paste0(round_half_up(Percent*100, digits = 2), "%"),
             Percent = Percent,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "NB", "NS", "PE", "NL")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot4.6 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = "0.1%"), ## make y-axis percents
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.2,
        y = 0.89,
        text = "<b>— 26.2% = Canadian Average</b>",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })



  # plot5.3----

  output$plot5.3 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()

    data$data_56$counts <- data$data_56$counts
    plot5.3 <- plot_ly(data$data_56, x = ~Exporters, y = ~counts, color = ~bus_type, type = "bar", textposition = 'inside',
                       colors = custom_colors) %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             xaxis = list(title = ""),
             yaxis = list(title = "",
                          tickformat = "0.1%",
                          tickprefix = "",
                          ticksuffix = "",
                          dtick = .1),
             barmode = "group")


  })

  # plot5.3b----

  output$plot5.3b <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()

    data$data_56b$counts <- data$data_56b$counts
    plot5.3b <- plot_ly(data$data_56b, x = ~Exporters, y = ~counts, color = ~bus_type, type = "bar", textposition = 'inside',
                       colors = custom_colors) %>%


      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             xaxis = list(title = ""),
             yaxis = list(title = "",
                          tickformat = "0.1%",
                          tickprefix = "",
                          ticksuffix = "",
                          dtick = .1),
             barmode = "group")


  })




  # plot5.4----
  output$plot5.4 <- renderPlotly({

    custom_colors <- custom_colors[c("navy", "dark_blue", "med_blue", "green", "yellow")] %>% unname()

    data$data_57$count <- data$data_57$count /100

    data$data_57$area <-  factor(data$data_57$area, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                           "Atlantic", "CA"))

    # Create the stacked bar chart with custom colors
    plot5.4 <- plot_ly(data$data_57, x = ~area, y = ~count, color = ~category, type = "bar", textposition = 'inside',
                       colors = custom_colors) %>%
      layout(title = "",
             xaxis = list(title = ""),
             yaxis = list(title = "% of total", tickformat = "0%", dtick = "0.1"),
             barmode = "relative",
             showlegend = TRUE,
             legend = list(orientation = "h", x = 0, y = 1.3))

    # Display the chart
    plot5.4

  })



  # plot5.5----
  output$plot5.5 <- renderPlotly({

    ## divide by 100 to be able to make y-axis percents
    canada_average <- 4.4

    plot_data <- data$data_58 %>%
      mutate(Label = paste0(round_half_up(Percent, digits = 1), ""),
             Percent = Percent,
             Province = factor(Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                    "Atlantic")),
             selected_color = ifelse(Province == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    footnote <- "<b>Source:</b> Statistics Canada / Prepared by BC Stats"

    plot5.5 <- plot_ly(plot_data,
                       x = ~Province,
                       y = ~Percent,
                       type = "bar",
                       marker = list(color = ~selected_color),
                       text = ~paste(Province,":",Label),
                       textposition = "none",
                       hoverinfo = 'text') %>%
      layout(
        xaxis = list(title = ""),
        yaxis = list(title = "$ Millions", tickformat = "$"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.51,
        y = 0.32,
        text = "<b>— Canada ($4.4 million)</b>",
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      )

  })





  # plot5.04----
  output$plot5.04 <- renderPlotly({


    data$data_59$count <- data$data_59$count /1000000
    custom_colors2 <- c("#fcb814", "#143047" )


    # Create the stacked bar chart with custom colors
    plot5.04 <- plot_ly(data$data_59, x = ~years, y = ~count, color = ~category, type = "scatter", mode = "lines",
                        stackgroup = "one", line = list(color = custom_colors2 )) %>%
      layout(title = "",
             xaxis = list(title = ""),
             yaxis = list(title = "$ Billions", tickformat = "$"),
             barmode = "stack",
             showlegend = TRUE,
             legend = list(orientation = "h", x = 0, y = 1.3))

    # Display the chart


  })

  #datatable5.1----

  # Render the table
  output$datatable5.1 <- renderDT({

    # Create your dataframe with the desired data
    table_data <- data$data_60 %>%
      janitor::remove_empty()


    # Create the datatable
    datatable(table_data,
              rownames = FALSE,
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
                columnDefs = list(list(width = '180px', targets = 0))
              )
    )    %>%
      # ## helper functions for formatting
      formatRound(2:7, rows = c(1,2,3,5,6,7), mark = ",", digits = 0) %>%  ## add commas to large numbers
      formatPercentage(c("One year growth rate", "Five year growth rate"), rows = c(1,2,3,5,6,7), digits = 1) %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:ncol(table_data), backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(1:ncol(table_data),
                  color = styleRow(4, "white"),
                  backgroundColor =styleRow(4, '#0e83b0'),
                  textAlign = styleRow(4, "center"),
                  borderStyle = styleRow(4, "solid"),
                  borderWidth = styleRow(4, "1px"),
                  borderColor = styleRow(4, "white"),
                  fontWeight = styleRow(4,"bold")) %>%
      formatStyle(2:7, textAlign = "right") %>%
      formatStyle(8:9, textAlign = "center") %>%
      formatStyle(columns = 1:ncol(table_data),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(3,7), "#c4d6e7"),
                  color = styleRow(rows = c(3,7), "#015082"),
                  fontWeight = styleRow(rows = c(3,7), "bold"))
  })


  #datatable5.2----

  # Render the table
  output$datatable5.2 <- renderDT({

    # Create your dataframe with the desired data
    table_data3 <- data$data_61 %>%
      row_to_names(2) %>%
      clean_names() %>%
      select(-c(x2017,x2021,x2017_2,x2021_2))

    # create a custom table header
    heading2 = htmltools::withTags(table(
      class = 'display',
      thead(
        tr(
          th(rowspan = 1, ''),
          th(colspan = 3, "Number of Exporters"),
          th(colspan = 3,  "Value of Exports ($ millions)")
        ),
        tr(
          lapply(c("", rep(c('2022', 'One-year growth rate', 'Five-year growth rate'), 2)), th)
        )
      )
    ))

    ## create a datatable
    datatable(table_data3,
              container = heading2,
              rownames = FALSE,
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
                 columnDefs = list(list(width = '180px', targets = 0))
              ),
              ## add caption
              caption = htmltools::tags$caption(
                style = 'caption-side: bottom;',
                '*Figures do not add to 100% due to rounding'
              )
      )  %>%
      ## helper functions for formatting
       formatRound(c(2,5), mark = ",", digits = 0) %>%  ## add commas to large numbers
      formatPercentage(c(3,4,6,7), digits = 1) %>%
       ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:7, backgroundColor = "#e6edf4", borderColor = "white") %>%
       formatStyle(c(2,5), textAlign = "right") %>%
       formatStyle(c(3,4,6,7),textAlign = "center")

  })





}

# Run the app
shinyApp(ui, server)
