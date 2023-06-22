#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Load required libraries
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(readxl)
library(ggplot2)
library(DT)



# Define the UI
ui <- dashboardPage(
  
  #skin = "red", 
 

  
  
  
  
  
  
  
  dashboardHeader(title = "Small Business in BC Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Executive Summary", tabName = "tab1"),
      menuItem("Some Key Indicators", tabName = "tab2"),
      menuItem("Small Business and Covid", tabName = "tab3"),
      menuItem("Small Business Growth", tabName = "tab4"),
      menuItem("Small Business Employment", tabName = "tab5"),
      menuItem("Self-Employed", tabName = "tab6"),
      menuItem("Contribution to Economy", tabName = "tab7"),
      menuItem("Small Business Exporters", tabName = "tab8")
      
      
    )
  ),
  dashboardBody(

    
    
    
    
    
    
    tabItems(
      # Tab 1
      tabItem(tabName = "tab1",
              fluidRow(
                box(title = "Pie Chart", width = 7,
                    plotOutput("pie_chart"))
              )
      ),
      
      # Tab 2
      tabItem(tabName = "tab2",
              fluidRow(
                box(title = "Static Table", width = 6,
                    solidHeader = TRUE,
                    dataTableOutput("table1")),
                
                box(title = "Table 2", width = 6,
                    dataTableOutput("data_table2"))
                
              )
      ),
      
      # Tab 3ff
      tabItem(tabName = "tab3",
              fluidRow(
                box(title = "Line Chart",
                    plotOutput("line_chart"))
              )
      )
    )
  )
)

# Define the server
server <- function(input, output) {
  
  # Tab 1 - Pie Chart
  output$pie_chart <- renderPlot({
    # Create the pie chart using data from Tab1
    pie_data <- data_01  # Replace with your actual data
    
    business <- data_01$`Type of Business`
    percent <- round(data_01$Percentage, 2)
    
    # Perform necessary data processing or aggregation if required
    # pie_data <- ...
    
    # Create the pie chart

    pie_chart <- ggplot(pie_data, aes(x = "", y = percent, fill = business)) +
      geom_bar(width = 2, stat = "identity") +
      coord_polar(theta = "y") +
      scale_fill_manual(values = c("darkblue", "blue", "yellow")) +
      geom_text(aes(label = paste0(business, "\n", percent, "%")), color = "black", size = 4, position = position_stack(vjust = 0.5)) +
      theme_void() +
      labs(title = "Breakdown of businesses in British Columbia, 2022") +
      theme(legend.position = "none")

    
    # Render the pie chart
    print(pie_chart)
  })
  
  
  
  
  # Tab 2 - Table
  output$table1 <- renderDataTable({
    # Render the table using data from Tab2
    data_02
    }, rownames = FALSE, colnames = TRUE)
  
  
  
  
  
  
  
  
  
  # Tab 2 - Table
  output$data_table2 <- renderDataTable({
    # Render the table using data from Tab2
    table_data2 <- data_03  
    
    # Perform necessary data processing or manipulation if required
    # table_data <- ...
    
    # Render the table
    datatable(table_data2)
  })
  
  
  # Render content for tab 3
  output$tab3_table <- renderDataTable({
    # Retrieve data for tab 3 from the Excel file
    tab3_data <- excel_data$tab3
    tab3_data
  })
  
  
  
  
  
} 

  
# Run the Shiny app
shinyApp(ui = ui, server = server)
  
  
  