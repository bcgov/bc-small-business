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
    box(title = "Horizontal Bar Chart (Add to 100%)", plotlyOutput("hbar_chart_100"), width = 6)
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

  output$bar_chart <- renderPlotly({
    bar_chart <- plot_ly(data_02, x = ~Category, y = ~Value, type = "bar")
    bar_chart
  })

  output$hbar_chart <- renderPlotly({
    hbar_chart <- plot_ly(data_03, x = ~Value, y = ~Category, type = "bar", orientation = "h")
    hbar_chart
  })

  output$hbar_chart_100 <- renderPlotly({
    hbar_chart_100 <- plot_ly(data_04, x = ~Value, y = ~Category, type = "bar", orientation = "h") %>%
      layout(barmode = "stack")
    hbar_chart_100
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
