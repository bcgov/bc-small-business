# Load required libraries
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)

# Test dataframe
df <- data.frame(
  Category = c("A", "B", "C", "D", "E"),
  Value = c(10, 20, 30, 40, 50)
)

# Define UI
ui <-

  shiny::fluidPage(
    theme = "styles.css",
    HTML("<html lang='en'>"),
    fluidRow(


      ## Replace appname with the title that will appear in the header
      bcsapps::bcsHeaderUI(id = 'header', appname = "Small Business in BC"),

      column(width = 12,
             style = "margin-top:100px",

             ""
      )
    ),
  shiny::tags$html(lang = "en",
                       dashboardPage(skin = "black",
                         dashboardHeader(title = ""),
                         dashboardSidebar(minified = TRUE, collapsed = FALSE,
                           sidebarMenu(
                             menuItem("Home", tabName = "home"),
                             menuItem("1 Small Business Growth", tabName = "page1"),
                             menuItem("2 Small Business Employment", tabName = "page2"),
                             menuItem("3 Self-Employed", tabName = "page3"),
                             menuItem("4 Contribution to Economy", tabName = "page4"),
                             menuItem("5 Small Business Exports", tabName = "page4")
                           )
                         ),
                         dashboardBody(
                           shiny::tags$head(
                             shiny::tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
                           ),
                           tabItems(
                             tabItem(
                               tabName = "home",
                               fluidRow(
                                 box(
                                   title = "Box 1",
                                   "Custom content for Box 1",
                                   width = 4
                                 ),
                                 box(
                                   title = "Box 2",
                                   "Custom content for Box 2",
                                   width = 4
                                 ),
                                 box(
                                   title = "Box 3",
                                   "Custom content for Box 3",
                                   width = 4
                                 )
                               )
                             ),
                             tabItem(
                               tabName = "page1",
                               fluidRow(
                                 box(title = "Figure 1.1 - Count of small businesses in British Columbia", plotlyOutput("plot1.1"), width = 10),
                                 box(title = "Figure 1.2a - One, two and five-year growth of B.C. businesses by size",
                                     width = 10,
                                     solidHeader = TRUE,
                                     tabsetPanel(
                                       tabPanel("1 year", plotlyOutput("plot1.2a1"), style = "width: 4"),
                                       tabPanel("2 year", plotlyOutput("plot1.2a2")),
                                       tabPanel("5 year", plotlyOutput("plot1.2a3"))
                                     )
                                  ),

                                box(title = "Figure 1.2b: Breakdown of businesses in British Columbia, 2022", DTOutput("datatable"),
                                       style = "border: 1px solid white;", width = 10
                                   ),

                                box(title = "Figure 1.3a: Distribution of small businesses by industry, 2022",
                                   plotlyOutput("plot1.3a"), width = 10


                             ),

                             box(title = "Figure 1.3b: Distribution of small businesses with and without employees by industry, 2022",
                                 plotlyOutput("plot1.3b"), width = 10
                             ),

                             box(title = "Figure 1.4: Small businesses by industry, proportions with and without employees, 2022", plotlyOutput("plot1.4"), width = 10

                               ),

                             box(title = "Figure 1.5: Number of net new small businesses - fastest growing sectors in B.C, 2017-2022", plotlyOutput("plot1.5"), width = 10
                             ),

                             box(title = "Figure 1.6: Sector growth rates for number of small businesses with employees, BC, 2017-2020", plotlyOutput("plot1.6"), width = 10
                             ),

                             box(title = "Figure 1.7: Small businesses per capita by province, 2022", plotlyOutput("plot1.7"), width = 10
                             ),

                             box(title = "Figure 1.8: Small business growth by province, 2022", plotlyOutput("plot1.8"), width = 10
                             ),

                             box(title = "Figure 1.9: Small business and population distribution by region in British Columbia, 2022", plotlyOutput("plot1.9"), width = 10
                             ),

                             box(title = "Figure 1.10: Small businesses per 1,000 persons", plotlyOutput("plot1.10"), width = 10
                             )
                           )),



                             tabItem(
                               tabName = "page2",
                               fluidRow(

                                 box(title = "Figure 2.1 Share of total employment in British Columbia, 2022", plotlyOutput("plot2.1"), width = 10

                                 ),

                                 box(title = "Figure xx: Number of net new small businesses - fastest growing sectors in B.C, 2017-2022", plotlyOutput(""), width = 10
                                 ),

                                 box(title = "Figure 2.3a: Share of British Columbia businesses and organizations by size, 2017-2020", plotlyOutput("plot2.3a"), width = 10
                                 ),

                                 box(title = "Figure 2.3b: Share of employment by establishment size, 2022", plotlyOutput("plot2.3b"), width = 10
                                 ),

                                 box(title = "Figure xx: Small business growth by province, 2022", plotlyOutput(""), width = 10
                                 ),

                                 box(title = "Figure 2.4b: Year-over-year growth in private sector employment", plotlyOutput("plot2.4b"), width = 10
                                 ),

                                 box(title = "Figure 2.5a: One-year small business employment change, by province, 2020-2021", plotlyOutput("plot2.5a"), width = 10
                                 ),

                                 box(title = "Figure 2.5b: Five-year small business employment change by province, 2017-2022", plotlyOutput("plot2.5b"), width = 10
                                 ),

                                 box(title = "Horizontal Bar Chart", plotlyOutput("hbar_chart"), width = 6)
                               )
                             ),

                             tabItem(
                               tabName = "page4",
                               fluidRow(
                                 box(title = "Line Chart", plotlyOutput("line_chart"), width = 6),
                                 box(title = "Area Chart", plotlyOutput("area_chart"), width = 6)
                               ),
                               fluidRow(
                                 box(title = "Static Table", DTOutput("static_table"))
                               )
                             )
                           ),
                           ),
                       ))  )


# Define server logic
server <- function(input, output) {



  ## Change links to false to remove the link list from the header
  bcsapps::bcsHeaderServer(id = 'header', links = TRUE)

  bcsapps::bcsFooterServer(id = 'footer')

  # plot1.1----

  df_long <- data_09_result %>%
    tidyr::gather(key = "Category", value = "value", -years)

  df_long$value <- as.numeric(df_long$value)
  df_long

  custom_colors <- c("#FDB813", "#005182", "#92B6D3", "#0E84B1", "#14997C","#96C2B3")

  output$plot1.1 <- renderPlotly({
    plot1.1 <- plot_ly(df_long, y = df_long$value, x = df_long$years, color = ~Category,
                       type = "bar", orientation = 'v', colors = custom_colors) %>%


      layout(title = "",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Number of dfgf",
                          tickformat = ",.0",
                          tickprefix = "",
                          ticksuffix = "K",
                          dtick = 100000),
             barmode = "stack")



    # Display the chart
    plot1.1

})

  # plot1.2a1 ----

  output$plot1.2a1 <- renderPlotly({
  # Create the plot
  plot1.2a1 <- plot_ly(data = data_10, x = ~`1-yr growth rate`, y = ~`employee count`, type = "bar",
                  orientation = "h",  colors = c("red", "green"),
                  hoverinfo = "x", width = 600, height = 400)

  # Customize the layout
  layout <- list(
    xaxis = list(title = "1 Yr"),
    yaxis = list(title = "Employee Count"),
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
    plot1.2a2 <- plot_ly(data = data_10, x = ~`2-yr growth rate`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400)

    # Customize the layout
    layout <- list(
      xaxis = list(title = "1 Yr"),
      yaxis = list(title = "Employee Count"),
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
    plot1.2a3 <- plot_ly(data = data_10, x = ~`5-yr growth rate`, y = ~`employee count`, type = "bar",
                         orientation = "h",  colors = c("red", "green"),
                         hoverinfo = "x", width = 600, height = 400)

    # Customize the layout
    layout <- list(
      xaxis = list(title = "1 Yr"),
      yaxis = list(title = "Employee Count"),
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
  custom_colors2 <- c("#FFFF99",
                      "#FFFF00",
                      "#FFD700",
                      "#AEEEEE",
                      "#7AC5CD",
                      "#5F9EA0",
                      "#4682B4",
                      "#4169E1",
                      "#0000CD",
                      "#00008B",
                      "#000080",
                      "#000060",
                      "#191970"
                      )

  category12 = data_12$`...1`
  percentage12 = data_12$`%`

  output$plot1.3a <- renderPlotly({
    plot1.3a <- plot_ly(data_12, labels = ~category12, values = ~percentage12,
                         textinfo = "label+percent", marker = list(colors = custom_colors2),
                         textposition = 'outside',   textfont = list(size = 10),

                         type = "pie") %>%
      layout(title =  "",
             width = 510,
             height = 320,
             autosize = FALSE,


             showlegend = FALSE,
             annotations = list(
               list(
                 x = 0,
                 y = -0.15,
                 text = "Source: BC Stats using data supplied by Statistics Canada",
                 showarrow = FALSE
               )
             ))


    plot1.3a

  })


  # plot1.3b ----

  data_13_result <- data_13_result[order(data_13_result$`Small businesses with no paid employees`),]

  data_13_result$segment <- factor(data_13_result$segment, levels = data_13_result$segment)

  output$plot1.3b <- renderPlotly({
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







  output$bar_chart <- renderPlotly({
    bar_chart <- plot_ly(df, x = ~Category, y = ~Value, type = "bar")
    bar_chart
  })

  output$hbar_chart <- renderPlotly({
    hbar_chart <- plot_ly(df, x = ~Value, y = ~Category, type = "bar", orientation = "h")
    hbar_chart
  })





 # plot1.4----

  data_14 <- data_14[order(-data_14$`1-49 employees`),  ]
  data_14$Category <- factor(data_14$Category, levels = rev(data_14$Category))

  output$plot1.4 <- renderPlotly({
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


  data_15$type <-factor(data_15$type, levels = rev(c("Professional, scientific and technical services", "Specialty trade contractors",
                                               "Ambulatory health care services", "Real estate", "Social assistance",
                                               "Non-Standard Sectors", "High tech total", "Tourism", "Secondary manufacturing")))


      output$plot1.5 <- renderPlotly({
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


      data_16$type <-factor(data_16$type, levels = rev(c("Beverage and tobacco product manufacturing", "Social assistance",
                                                         "Motion picture and sound recording industries", "Private households",
                                                         "Couriers and messengers", "Non-Standard Sectors", "High Technology", "Tourism",
                                                         "Secondary Manufacturing")))



      output$plot1.6 <- renderPlotly({
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

      canada_average <- 82.3

      data_17$Province <- factor(data_17$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                              "NB", "NS", "PEI", "NL"))
      selected_colour <- ifelse(data_17$Province == "BC", "#e3a82b", "#95b9c7")


      output$plot1.7 <- renderPlotly({

        footnote <- "Source: Statistics Canada / Prepared by BC Stats"

        plot1.7 <- plot_ly(data_17, x = ~Province, y = ~Percent, type = "bar", marker = list(color = selected_colour))
        plot1.7 <- plot1.7 %>%
          add_trace(y = canada_average, type = 'scatter', mode = 'lines', marker = list(color = "#f5f5f5"), name = 'Canadian Average = 82.3%')

        plot1.7 <- plot1.7 %>% layout(title = '',
                                          yaxis = list(title = 'Value'),
                                          showlegend = FALSE

        )


      })


      # plot1.8----

      canada_average <- 1.5
      data_18$Province <- factor(data_18$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                             "NB", "NS", "PEI", "NL"))
      selected_colour <- ifelse(data_18$Province == "BC", "#e3a82b", "#95b9c7")
      output$plot1.8 <- renderPlotly({
      footnote <- "Source: Statistics Canada / Prepared by BC Stats"

        plot1.8 <- plot_ly(data_18, x = ~Province, y = ~Percent, type = "bar", marker = list(color = selected_colour))
        plot1.8 <- plot1.8 %>%
          add_trace(y = canada_average, type = 'scatter', mode = 'lines', marker = list(color = "#f5f5f5"), name = 'Canadian Average = 82.3%')

        plot1.8 <- plot1.8 %>% layout(title = '',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE
        )


      })

      # plot1.9 TBD----

      canada_average <- 1.5
      data_18$Province <- factor(data_18$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                              "NB", "NS", "PEI", "NL"))
      selected_colour <- ifelse(data_18$Province == "BC", "#e3a82b", "#95b9c7")
      output$plot1.8 <- renderPlotly({
        footnote <- "Source: Statistics Canada / Prepared by BC Stats"

        plot1.8 <- plot_ly(data_18, x = ~Province, y = ~Percent, type = "bar", marker = list(color = selected_colour))
        plot1.8 <- plot1.8 %>%
          add_trace(y = canada_average, type = 'scatter', mode = 'lines', marker = list(color = "#f5f5f5"), name = 'Canadian Average = 82.3%')

        plot1.8 <- plot1.8 %>% layout(title = '',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE
        )


      })

      # plot1.10----


      data_20$region <- factor(data_20$region, levels = rev(c("Cariboo", "Kootenay", "North Coast & Nechako",
                                                              "Vancouver Island/ Coast", "Northeast",
                                                              "Thompson - Okanagan", "Mainland/ Southwest")))

      output$plot1.10 <- renderPlotly({
        footnote <- "Source: Statistics Canada / Prepared by BC Stats"

        plot1.10 <- plot_ly(data_20, y = ~region, x = data_20$`Total, 2022`, type = "bar", marker = list(color = custom_colors), orientation = 'h')

        plot1.10 <- plot1.10 %>% layout(title = '',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE
        )


      })




  output$line_chart <- renderPlotly({
    line_chart <- plot_ly(df, x = ~Category, y = ~Value, type = "scatter", mode = "lines")
    line_chart
  })

  output$area_chart <- renderPlotly({
    area_chart <- plot_ly(df, x = ~Category, y = ~Value, type = "scatter", mode = "lines", fill = "tozeroy")
    area_chart
  })




  # Render the table
  output$datatable <- renderDT({
    # Create your dataframe with the desired data

        data <- data_11



    # Create the datatable
        datatable(data,
                  rownames = FALSE,
                  colnames = c("", "Number of businesses", "Per cent of all businesses*", "Per cent of small businesses*"),
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

  category = data_22$`sector`
  percentage = data_22$`%`

  output$plot2.1 <- renderPlotly({
    plot2.1 <- plot_ly(data_22, labels = ~category, values = ~percentage,
                        textinfo = "label+percent", marker = list(colors = custom_colors),
                        textposition = 'outside',   textfont = list(size = 10),

                        type = "pie") %>%
      layout(title =  "",
             width = 510,
             height = 320,
             autosize = FALSE,


             showlegend = FALSE,
             annotations = list(
               list(
                 x = 0,
                 y = -0.15,
                 text = "Source: BC Stats using data supplied by Statistics Canada",
                 showarrow = FALSE
               )
             ))


    plot2.1

  })

  # plot2.3a ----

  category1 = data_24$sector
  percentage1 = data_24$`%`

  output$plot2.3a <- renderPlotly({
    plot2.3a <- plot_ly(data_24, labels = ~category1, values = ~percentage1,
                       textinfo = "label+percent", marker = list(colors = custom_colors),
                       textposition = 'outside',   textfont = list(size = 10),

                       type = "pie") %>%
      layout(title =  "",
             width = 510,
             height = 320,
             autosize = FALSE,


             showlegend = FALSE,
             annotations = list(
               list(
                 x = 0,
                 y = -0.15,
                 text = "Source: BC Stats using data supplied by Statistics Canada",
                 showarrow = FALSE
               )
             ))


    plot2.3a

  })

  # plot2.3b ----

  category2 = data_25$sector
  percentage2 = data_25$`%`

  output$plot2.3b <- renderPlotly({
    plot2.3b <- plot_ly(data_25, labels = ~category2, values = ~percentage2,
                       textinfo = "label+percent", marker = list(colors = custom_colors),
                       textposition = 'outside',   textfont = list(size = 10),

                       type = "pie") %>%
      layout(title =  "",
             width = 510,
             height = 320,
             autosize = FALSE,


             showlegend = FALSE,
             annotations = list(
               list(
                 x = 0,
                 y = -0.15,
                 text = "Source: BC Stats using data supplied by Statistics Canada",
                 showarrow = FALSE
               )
             ))


    plot2.3b

  })


  # plot2.4b----

  df_long1 <- data_26_result %>%
    tidyr::gather(key = "Category", value = "value", -years)

  df_long1$value <- as.numeric(df_long1$value)
  df_long1

  custom_colors <- c("#FDB813", "#005182", "#92B6D3", "#0E84B1", "#14997C","#96C2B3")

  output$plot2.4b <- renderPlotly({
    plot2.4b <- plot_ly(df_long1, y = df_long1$value, x = df_long1$years, color = ~Category,
                       type = "bar", orientation = 'v', colors = custom_colors) %>%


      layout(title = "",
             xaxis = list(title = "Year"),

             barmode = "stack")

    plot2.4b <- layout(plot2.4b,
                       legend = list(orientation = "h", x = .5, y =1.1)
                     )


    # Display the chart
    plot2.4b

  })

  # plot2.5a----

  canada_average <- 2.9
  data_27$Province <- factor(data_27$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                          "NB", "NS", "PE", "NL"))
  selected_colour <- ifelse(data_27$Province == "BC", "#e3a82b", "#95b9c7")
  output$plot2.5a <- renderPlotly({
    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.5a  <- plot_ly(data_27, x = ~Province, y = ~Percent, type = "bar", marker = list(color = selected_colour))
    plot2.5a  <- plot2.5a  %>%
      add_trace(y = canada_average, type = 'scatter', mode = 'lines', marker = list(color = "#f5f5f5"), name = 'Canadian Average = 82.3%')

    plot2.5a  <- plot2.5a  %>% layout(title = '',
                                  yaxis = list(title = 'Value'),
                                  showlegend = FALSE
    )
    # Display the chart
    plot2.5a

  })


  # plot2.5b----

  canada_average <- 1
  data_28$Province <- factor(data_28$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                          "NB", "NS", "PE", "NL"))
  selected_colour <- ifelse(data_28$Province == "BC", "#e3a82b", "#95b9c7")
  output$plot2.5b <- renderPlotly({
    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    plot2.5b <- plot_ly(data_28, x = ~Province, y = ~Percent, type = "bar", marker = list(color = selected_colour))
    plot2.5b <- plot2.5b %>%
      add_trace(y = canada_average, type = 'scatter', mode = 'lines', marker = list(color = "#f5f5f5"), name = 'Canadian Average = 82.3%')

    plot2.5b <- plot2.5b %>% layout(title = '',
                                  yaxis = list(title = 'Value'),
                                  showlegend = FALSE
    )
    # Display the chart
    plot2.5b

  })


  }

# Run the app
shinyApp(ui, server)
