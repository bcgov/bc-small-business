ui <- function(req) {
  shiny::fluidPage(
    theme = "styles.css",
    HTML("<html lang='en'>"),
    fluidRow(


    ## Replace appname with the title that will appear in the header
    bcsapps::bcsHeaderUI(id = 'header', appname = "Small Business in BC"),

    column(width = 12,
           style = "margin-top:100px",

           "xxx"
           )
  ),



  fluidRow(
    box(title = "Pie Chart", plotlyOutput("pie_chart"), width = 6),
    box(title = "Bar Chart", plotlyOutput("bar_chart"), width = 6)
  ),

  fluidRow(
    box(title = "Horizontal Bar Chart", plotlyOutput("hbar_chart"), width = 6),
    box(title = "Stacked Bar Chart", plotlyOutput("stacked_barchart"), width = 6)
  ),
  fluidRow(
    box(title = "Line Chart", plotlyOutput("line_chart"), width = 6),
    box(title = "Area Chart", plotlyOutput("area_chart"), width = 6)
  ),
  fluidRow(
    box(title = "Static Table", gt_output("my_table"))
  ),

  fluidRow(


    bcsapps::bcsFooterUI(id = 'footer')
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
                         textinfo = "label+percent", showlegend = FALSE,
                         textposition = "outside", insidetextfont = list(color= "#FFFFFF"), type = "pie")
    pie_chart
  })

  canada_average <- .6

  output$bar_chart <- renderPlotly({
    bar_chart <- plot_ly(data_08, x = ~Province, y = ~Percent, type = "bar")
    bar_chart <- bar_chart %>%
      add_trace(y = canada_average, type = 'scatter', mode = 'lines', name = 'Canadian Average = 0.6')
    bar_chart <- bar_chart %>% layout(title = 'Bankruptcies per 1,000 Businesses',
                                      yaxis = list(title = 'Value'),
                                      showlegend = FALSE)



  })

  output$hbar_chart <- renderPlotly({
    hbar_chart <- plot_ly(data_03, x = ~Value, y = ~Category, type = "bar", orientation = "h")
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
    line_chart <- plot_ly(data_05, x = ~Category, y = ~Value, type = "scatter", mode = "lines")
    line_chart
  })



  output$area_chart <- renderPlotly({

    area_chart <- plot_ly(data_04_result, x = ~years, y = data_04_result$`Small business exports`, type = "scatter", mode = "lines", fillcoler = "#455555" , name = "Small B", stackgroup = 'one') %>%
      add_trace(y = data_04_result$`Large business exports`, type = "scatter", mode = "lines", fillcolor = "tozeroy", name = "Large B") %>%

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
