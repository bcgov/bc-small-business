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


          box(title = "Fig 1: Share of Businesses by Employment Size in British Columbia, 2022 (page 1)",
              plotlyOutput("pie_chart"), width = 5,
              style = "border: 1px solid white;"
      ),

        box(title = "Fig 2: Business bankruptcy rates by province, 2021 (page 5)", plotlyOutput("bar_chart"), width = 5,
            style = "border: 1px solid white;"
        )
    )
      ),



  # second page

    tabPanel("2 Small Business Employment",

      fluidRow(
        box(title = "Figure 3: Distribution of small businesses with and without employees by industry, 2022 (page 15)", plotlyOutput("hbar_chart"), width = 5,
            style = "border: 1px solid white;"
        ),

        box(title = "Figure 4: Count of small businesses in British Columbia (page 13)", plotlyOutput("stacked_barchart"), width = 5,
            style = "border: 1px solid white;"
        )
      )
      ),


   # third page

    tabPanel("3 Self-Employed",

      fluidRow(
        box(title = "Figure 5: Share of British Columbian workers who are self-employed, by age (page 32)", plotlyOutput("line_chart"), width = 6,
            style = "border: 1px solid white;"
        ),
        box(title = "Figure 6: Value of goods exports for large and small businesses (page 3)", plotlyOutput("area_chart"), width = 6,
            style = "border: 1px solid white;"
        )
      )
    ),


  # fourth page

    tabPanel("4 Contribution to Economy",

      fluidRow(
        box(title = "Figure 7: Number of self-employed business owners in British Columbia, 2022 (page 30)", gt_output("my_table"),
            style = "border: 1px solid white;"
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
                marker = list(color = 'rgba(58, 71, 80, 1.0)',
                              line = list(color = 'rgba(58, 71, 80, 1.0)',
                                          width = 1)))
    hbar_chart <- layout(hbar_chart,
                         legend = list(orientation = "h", x = -2, y = 1.2),
                         xaxis = list(tickformat = '.0%'))
    hbar_chart









  })

  output$stacked_barchart <- renderPlotly({
    stacked_barchart <- plot_ly(data_09_result, x = data_09_result$years, y = data_09_result$`No employees`,
                                type = 'bar',   name = 'no employees', color = "#FFFF00") %>%
      add_trace(y = data_09_result$`1-4 employees`, type = 'bar', barmode = 'stack', name = '1-4 employees', color = "#0000FF")  %>%
      add_trace(y = data_09_result$`5-9 employees`, type = 'bar', barmode = 'stack', name = '5-9 employees', color = "#f5f5f5") %>%
      add_trace(y = data_09_result$`10-19 employees`, type = 'bar', barmode = 'stack', name = '10-19 employees', color = "#478fff")  %>%
      add_trace(y = data_09_result$`20-49 employees`, type = 'bar', barmode = 'stack', name = '20-49 employees', color = "#ffffff")





    stacked_barchart <- stacked_barchart %>% layout(barmode = 'stack')

    #                        yaxis = list(tickmode = "linear", tick0 = 0, dtick = 100000),
                #               legend = list(orientation = "h", x = 0, y = 1.2))
    stacked_barchart





  })

  output$line_chart <- renderPlotly({
    line_chart <- plot_ly(data_35_result, x = ~years, y = data_35_result$`15-24`, type = "scatter", mode = "lines",  name = "15-24 years old", line = list(color = "yellow")) %>%
      add_trace(y = data_35_result$`25-34`, type = 'scatter', mode = "lines", name = "25-34 years", line = list(color = "lightgreen")) %>%
     add_trace(y = data_35_result$`35-44`, type = 'scatter', mode = "lines", name = "35-44 years", line = list(color = "darkgreen")  ) %>%
     add_trace(y = data_35_result$`45-54`, type = 'scatter', mode = "lines", name = "45-54 years", line = list(color = "lightblue")  ) %>%
     add_trace(y = data_35_result$`55-64`, type = 'scatter', mode = "lines", name = "55-64 years", line = list(color = "darkblue")  ) %>%
     add_trace(y = data_35_result$`65+`, type = 'scatter', mode = "lines", name = "65+ years", line = list(color = "black")  )

    line_chart <- layout(line_chart,
                         xaxis = list(title = ""),
                         yaxis = list(
                           tickvals = seq(0, 1, 0.05),
                           ticktext = paste0(seq(0, 100, 5), "%"),
                         legend = list(title = "Age Group")
                         )
    )


    line_chart
  })



  output$area_chart <- renderPlotly({

    area_chart <- plot_ly(data_04_result, x = ~years, y = data_04_result$`Small business exports`, type = "scatter", mode = "lines",  name = "Small business exports", line = list(color = "#234075"), stackgroup = 'one') %>%
      add_trace(y = data_04_result$`Large business exports`, type = "scatter", mode = "lines",  name = "Large business exports", line = list(color = "blue")) %>%

      layout(title = "",

             yaxis = list(title = "Value in Billions")
    )


    area_chart
  })


  # Render the table
  output$my_table <- render_gt({


  # Create the gt table
    tbl <- gt(data_02)

    # Add a header row with blue background and white text
    tbl <- tbl |>
      tab_header(
        title = md(""),

      )
    tbl <- tbl |>
      tab_source_note(
        source_note = "Source: This is where the data comes from"

      )




    return(tbl)
  })
}



shiny::shinyApp(ui = ui, server = server)
