# Load required libraries
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(ggplot2)
library(sf)

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

      ## main body column ----
      column(width = 12,
             style = "margin-top:75px",

  shiny::tags$html(lang = "en",
                   ## dashboard page ----
                       dashboardPage(skin = "black",
                         dashboardHeader(title = "", titleWidth = 187),
                         ## dashboard sidebar ----
                         dashboardSidebar(minified = TRUE, collapsed = FALSE,
                           sidebarMenu(
                             id = "tabs", ## to be able to update with buttons on landing page
                             menuItem("Home", tabName = "home"),
                             menuItem("1 Small Business Growth", tabName = "page1"),
                             menuItem("2 Small Business Employment", tabName = "page2"),
                             menuItem("3 Self-Employed", tabName = "page3"),
                             menuItem("4 Contribution to Economy", tabName = "page4"),
                             menuItem("5 Small Business Exports", tabName = "page4")
                           )
                         ),
                         ## dashboard body ----
                         dashboardBody(
                           ## tabs ----
                           tabItems(
                             ## home tab ----
                             tabItem(
                               tabName = "home",
                               fluidRow(
                                 tags$div(id = "green", box(
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
                               fluidRow(
                                 tags$div(id = "yellow", box(
                                   title = "Small business employment",
                                   tagList(
                                     HTML("Small businesses in B.C. employed around <b>1,135,300 people</b> in 2022. This accounts for 51 per cent of private sector jobs in the province."),
                                   br(),br(),
                                   actionButton("explore4", "Explore small business employment", icon = icon("users"))
                                   ),
                                   width = 4
                                 ),
                                 box(
                                   title = "Self-employment growth",
                                   tagList(
                                     HTML("In 2022, there were <b>423,800 self-employed people</b> in B.C., 0.8 per cent higher than in 2021. However, self-employment fell by 0.9 per cent compared to 2017."),
                                   br(),br(),
                                   actionButton("explore5", "Explore small business employment", icon = icon("users"))
                                   ),
                                   width = 4
                                 )),
                                 tags$div(id = "light-green", box(
                                   title = "Self-employment for women",
                                   tagList(
                                     HTML("In 2022, <b>38.3 per cent</b> of all self-employed people in B.C. were <b>women</b>, ranking fourth among provinces."),
                                   br(),br(),
                                   actionButton("explore6", "Explore self-employed", icon = icon("user"))
                                   ),
                                   width = 4
                                 ))),
                               fluidRow(
                                 tags$div(id = "light-green", box(
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
                                 tags$div(id = "light-blue",box(
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
                             ## page 1 tab ----
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

                             box(title = "Figure 1.9: Small business and population distribution by region in British Columbia, 2022", plotOutput("plot1.9", height = "470px"), width = 10
                             ),

                             box(title = "Figure 1.10: Small businesses per 1,000 persons", plotlyOutput("plot1.10"), width = 10
                             )
                           )),



                           ## page 2 tab ----  
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

                           ## page 4 tab ----  
                           tabItem(
                               tabName = "page4",
                               fluidRow(
                                 box(title = "Line Chart", plotlyOutput("line_chart"), width = 6),
                                 box(title = "Area Chart", plotlyOutput("area_chart"), width = 6)
                               ),
                               fluidRow(
                                 box(title = "Static Table", DTOutput("static_table"))
                               )
                             ) ## end of tab 4
                           
                           ), ## end of tabs
                           ), ## end of dashboard body
                       ) ## end of dashboard page
                   )),
  
  bcsapps::bcsFooterUI(id = 'footer')
  
  
  
  ))


# Define server logic
server <- function(input, output, session) {



  ## Change links to false to remove the link list from the header
  bcsapps::bcsHeaderServer(id = 'header', links = TRUE)

  bcsapps::bcsFooterServer(id = 'footer')
  
  ## button navigation ----
  observeEvent(input$explore1, updateTabItems(session, "tabs", selected = "page1"))
  observeEvent(input$explore2, updateTabItems(session, "tabs", selected = "page1"))
  observeEvent(input$explore3, updateTabItems(session, "tabs", selected = "page4"))
  observeEvent(input$explore4, updateTabItems(session, "tabs", selected = "page2"))
  observeEvent(input$explore5, updateTabItems(session, "tabs", selected = "page2"))
  observeEvent(input$explore6, updateTabItems(session, "tabs", selected = "page3"))
  observeEvent(input$explore7, updateTabItems(session, "tabs", selected = "page3"))
  observeEvent(input$explore8, updateTabItems(session, "tabs", selected = "page4"))
  observeEvent(input$explore9, updateTabItems(session, "tabs", selected = "page5"))
  
  ## color definition ----
  #custom_colors <- c("#FDB813", "#005182", "#92B6D3", "#0E84B1", "#14997C","#96C2B3")
  custom_colors <- c(yellow= "#fcb814", light_green = "#95c1b2", green = "#15987b",
                     light_blue =  "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082",
                     navy = "#143047")
  custom_colors_rgb <- list(yellow= c(252,184,20), light_green = c(149,193,178), green = c(21,152,123),
                         light_blue=c(146,181,210), med_blue=c(14,131,176), dark_blue = c(1,80,130),
                         navy = c(20,48,71))
  


  # plot1.1----
  output$plot1.1 <- renderPlotly({
    
    df_long <- data_09_result %>%
      tidyr::gather(key = "Category", value = "value", -years)
    
    df_long$value <- as.numeric(df_long$value)
    df_long
    
    custom_colors <- c("#FDB813", "#005182", "#92B6D3", "#0E84B1", "#14997C","#96C2B3")
    
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
 
  output$plot1.3a <- renderPlotly({
    
    plot_data <- data_12 %>%
      rename(category = `...1`,
             percent = `%`) %>%
      mutate(sector = ifelse(category %in% c("Utilities","Primary*", "Manufacturing", "Construction"),
                             "Goods", "Services"),
             color = ifelse(sector == "Goods", 
                            paste(custom_colors_rgb[["yellow"]], collapse = ","),
                            paste(custom_colors_rgb[["dark_blue"]], collapse = ","))) %>%
      group_by(sector) %>%
      mutate(rank = rank(percent),
             opacity = ifelse(sector == "Goods", rank/4,rank/10),
             plot_color = paste0("rgba(", color, ",", opacity, ")"), ##https://plotly.com/r/marker-style/
      )
    
    plot1.3a <- plot_ly(plot_data) %>%
      add_trace(type = "pie",
                name = "",
                labels = ~category,
                values = ~percent,
                text = ~paste0("<b>",sector," sector</b><br>", category,"<br>", round_half_up(100*percent, digits = 1), "%"),
                marker = list(colors = ~plot_color),
                textposition = "none",
                hoverinfo = 'text') %>%
      layout(title =  "",
             # width = 510,
             # height = 320,
             # autosize = FALSE,
             #showlegend = FALSE,
             annotations = list(
               list(
                 x = 0,
                 y = -0.1,
                 text = "Source: BC Stats using data supplied by Statistics Canada",
                 showarrow = FALSE
               )
             ))


    plot1.3a

  })


  # plot1.3b ----

  output$plot1.3b <- renderPlotly({
    
    data_13_result <- data_13
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







  output$bar_chart <- renderPlotly({
    bar_chart <- plot_ly(df, x = ~Category, y = ~Value, type = "bar")
    bar_chart
  })

  output$hbar_chart <- renderPlotly({
    hbar_chart <- plot_ly(df, x = ~Value, y = ~Category, type = "bar", orientation = "h")
    hbar_chart
  })





 # plot1.4----

  output$plot1.4 <- renderPlotly({
    
    data_14 <- data_14[order(-data_14$`1-49 employees`),  ]
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
        
        canada_average <- 82.3
        
        data_17$Province <- factor(data_17$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                                "NB", "NS", "PEI", "NL"))
        selected_colour <- ifelse(data_17$Province == "BC", "#e3a82b", "#95b9c7")

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
      output$plot1.8 <- renderPlotly({
        
        ## divide by 100 to be able to make y-axis percents
        canada_average <- 0.015
        
        plot_data <- data_18 %>%
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
    
    plot_data <- data_19 %>%
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
  output$plot2.1 <- renderPlotly({
    
    category = data_22$`sector`
    percentage = data_22$`%`
    
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
  output$plot2.3a <- renderPlotly({
    
    category1 = data_24$sector
    percentage1 = data_24$`%`
    
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
  output$plot2.3b <- renderPlotly({
    
    category2 = data_25$sector
    percentage2 = data_25$`%`
    
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

  output$plot2.4b <- renderPlotly({
    
    df_long1 <- data_26_result %>%
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
    
    canada_average <- 2.9
    data_27$Province <- factor(data_27$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                            "NB", "NS", "PE", "NL"))
    selected_colour <- ifelse(data_27$Province == "BC", "#e3a82b", "#95b9c7")
    
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
  output$plot2.5b <- renderPlotly({
    canada_average <- 1
    data_28$Province <- factor(data_28$Province, levels = c("BC", "AB", "SK", "MB", "ON", "QC",
                                                            "NB", "NS", "PE", "NL"))
    selected_colour <- ifelse(data_28$Province == "BC", "#e3a82b", "#95b9c7")
    
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
