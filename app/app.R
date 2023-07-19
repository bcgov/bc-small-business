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
                             menuItem("4 Contribution to Economy", tabName = "page4")
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

                             box(title = "Figure 1.4: Small businesses by industry, proportions with and without employees, 2022", plotlyOutput("plot1.4"), width = 10)

                           )),



                             tabItem(
                               tabName = "page2",
                               fluidRow(
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

  custom_colors <- c("#FFC300", "#FF5733", "#C70039", "#900C3F", "#581845")

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

  category = data_12$`...1`
  percentage = data_12$`%`

  output$plot1.3a <- renderPlotly({
    plot1.3a <- plot_ly(data_12, labels = ~category, values = ~percentage,
                         textinfo = "label+percent", marker = list(colors = ~Colours),
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

  data_13_result$type <- factor(data_13_result$type, levels = data_13$type)

  output$plot1.3b <- renderPlotly({
    plot1.3b <- plot_ly(data_13_result, y = data_13_result$type,
                          x = data_13_result$`Small businesses with no paid employees`,
                          type = "bar",
                          orientation = 'h', name = 'Small businesses with no paid employees (Total 299,800, 59%)') %>%
      add_trace(x = data_13_result$`Small businesses with 1-49 employees`,
      name = 'Small businesses with 1-49 employees (Total 204,300, 37%)',
                marker = list(color = 'rgba(58, 71, 80, 1.0)',
                              line = list(color = 'rgba(58, 71, 80, 1.0)',
                                          width = 1)))
    plot1.3b <- layout(plot1.3b,
                         legend = list(orientation = "h", x = -2, y = 1.2),
                         xaxis = list(tickformat = '.0%'))
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





 # example----

  data_14 <- data_14[order(-data_14$`1-49 employees`),  ]
  data_14$Category <- factor(data_14$Category, levels = rev(data_14$Category))

  output$plot1.4 <- renderPlotly({
    plot1.4<- plot_ly(data_14, y = data_14$Category, type = "bar", x = data_14$`No paid employees`, marker = list(color = "#3A4750"), name = "No paid employees", orientation = 'h')


    plot1.4 <- add_trace(plot1.4, x = data_14$`1-49 employees`, name = "1-49 employees", marker = list(color = "#009D78"),

    plot1.4 <- layout(plot1.4, barmode = "stack")

)

    # Display the chart
    plot1.4
  })

# end of example ----



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




  }

# Run the app
shinyApp(ui, server)
