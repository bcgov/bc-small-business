ui <- function(req) {
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

  navbarPage(
    title = "",


  # first page

    tabPanel("1 Small Business Growth",
      titlePanel(
        h2("Intro Insights could go here"),
        HTML("<ul> <li>
             asdfsadfsadf </li> </ul>")

      ),
      fluidRow(


          box(title = "Fig 1: Share of Businesses by Employment Size in British Columbia, 2022",
              plotlyOutput("pie_chart"), width = 5,
              style = "border: 1px solid white;"
      ),

        box(title = "Fig 2: Business bankruptcy rates by province, 2021", plotlyOutput("bar_chart"), width = 5,
            style = "border: 1px solid white;"
        )
    )
      ),



  # second page

    tabPanel("2 Small Business Employment",

      fluidRow(
        box(title = "Figure 3: Distribution of small businesses with and without employees by industry, 2022", plotlyOutput("hbar_chart"), width = 5,
            style = "border: 1px solid white;"
        ),

        box(title = "Stacked Bar Chart", plotlyOutput("stacked_barchart"), width = 3,
            style = "border: 1px solid black;"
        )
      )
      ),


   # third page

    tabPanel("3 Self-Employed",

      fluidRow(
        box(title = "Line Chart", plotlyOutput("line_chart"), width = 8,
            style = "border: 1px solid black;"
        ),
        box(title = "Area Chart", plotlyOutput("area_chart"), width = 8,
            style = "border: 1px solid black;"
        )
      )
    ),


  # fourth page

    tabPanel("4 Contribution to Economy",

      fluidRow(
        box(title = "Static Table", gt_output("my_table"),
            style = "border: 1px solid black;"
         )

      ),




    bcsapps::bcsFooterUI(id = 'footer')
  ),
  )

)}


server <- function(input, output) {

  ## Change links to false to remove the link list from the header
  bcsapps::bcsHeaderServer(id = 'header', links = TRUE)

  bcsapps::bcsFooterServer(id = 'footer')

  category = data_01$`Type of Business`
  percentage = data_01$Percentage

  output$pie_chart <- renderPlotly({
    pie_chart <- plot_ly(data_01, labels = ~category, values = ~percentage,
                         textinfo = "label+percent", marker = list(colors = ~Colours),
                         textposition = 'inside',  insidetextorientation = 'horizontal', textfont = list(size = 15),

                         type = "pie") %>%
         layout(title =  "",
                width = 500,
                height = 400,
                autosize = FALSE,


                                           showlegend = FALSE,
               annotations = list(
                 list(
                   x = 0,
                   y = -0.1,
                   text = "Source: BC Stats using data supplied by Statistics Canada",
                   showarrow = FALSE
                 )
               ))


    pie_chart
  })






  canada_average <- .6

  data_08$Province <- factor(data_08$Province, levels = unique(data_08$Province))
  selected_colour <- ifelse(data_08$Province == "BC", "#e3a82b", "#95b9c7")


  output$bar_chart <- renderPlotly({

    footnote <- "Source: Statistics Canada / Prepared by BC Stats"

    bar_chart <- plot_ly(data_08, x = ~Province, y = ~Percent, type = "bar", marker = list(color = selected_colour))
    bar_chart <- bar_chart %>%
      add_trace(y = canada_average, type = 'scatter', mode = 'lines', name = 'Canadian Average = 0.6')

    bar_chart <- bar_chart %>% layout(title = 'Bankruptcies per 1,000 Businesses',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE

                                      )








  })

  data_13_result <- data_13_result[order(data_13_result$`Small businesses with no paid employees`, decreasing = TRUE),]

  output$hbar_chart <- renderPlotly({
    hbar_chart <- plot_ly(data_13_result, y = data_13_result$type,
                          x = data_13_result$`Small businesses with no paid employees`,
                          type = "bar",
                          orientation = 'h', name = 'Small businesses with no paid employees (Total 299,800, 59%)
') %>%
      add_trace(x = data_13_result$`Small businesses with 1-49 employees`, name = 'Small businesses with 1-49 employees (Total 204,300, 37%)
',
                marker = list(color = 'rgba(58, 71, 80, 0.6)',
                              line = list(color = 'rgba(58, 71, 80, 1.0)',
                                          width = 1)))
    hbar_chart <- layout(hbar_chart, legend = list(orientation = "h", x = -.5, y = 1.2))
    hbar_chart









  })

  output$stacked_barchart <- renderPlotly({
    stacked_barchart <- plot_ly(data_09_result, x = data_09_result$years, y = data_09_result$`No employees`,
                                type = 'bar',  name = 'no employees') %>%
      add_trace(y = data_09_result$`1-4 employees`, name = 'a few employees')  %>%
      add_trace(y = data_09_result$`5-9 employees`, name = 'even more employees')

    stacked_barchart <- stacked_barchart %>% layout(title = 'my Bar Chart',
                                                    yaxis = list(title = 'Value'),
                                                    barmode = 'stack')

    stacked_barchart





  })

  output$line_chart <- renderPlotly({
    line_chart <- plot_ly(data_35_result, x = ~years, y = data_35_result$`15-24`, type = "scatter", mode = "lines",  name = "15-24 years old") %>%
      add_trace(y = data_35_result$`25-34`, type = 'scatter', mode = "lines", name = "25-34 years") %>%

    layout(title = "Liney McLinechart",
           xaxis = list(title = "Year"),
           yaxis = list(title = "Percent Self-Employed"),
           legend = list(title = "Age Group"))


    line_chart
  })



  output$area_chart <- renderPlotly({

    area_chart <- plot_ly(data_04_result, x = ~years, y = data_04_result$`Small business exports`, type = "scatter", mode = "lines",  name = "Small B", stackgroup = 'one') %>%
      add_trace(y = data_04_result$`Large business exports`, type = "scatter", mode = "lines",  name = "Large B") %>%

      layout(title = " Comparison",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Billions"),
             legend = list(title = "Type of Business"))


    area_chart
  })


  # Render the table
  output$my_table <- render_gt({


  # Create the gt table
  tbl <- gt(data_02)

  # Add a header row with blue background and white text
  tbl <- tbl |>
    tab_header(
      title = md("**Figure3.1 Number of self-employed business owners in British Columbia, 2021**"),

    )
  tbl <- tbl |>
    tab_source_note(
      source_note = "Source: This is where the data comes from"

    )




    return(tbl)
  })
}



shiny::shinyApp(ui = ui, server = server)
