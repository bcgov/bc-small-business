# Copyright 2024 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Define UI
ui <-

  shiny::fluidPage(
    theme = "styles.css",
    HTML("<html lang='en'>"),
    fluidRow(

      ## Replace appname with the title that will appear in the header
      bcsapps::bcsHeaderUI(id = 'header', appname = "Small Business Profile"),

      tags$head(tags$link(rel = "shortcut icon", href = "favicon.png")), ## to add BCGov favicon

      ## main body column ----
      column(width = 12,
             style = "margin-top:75px",

             shiny::tags$html(lang = "en",
                              ## dashboard page ----
                              dashboardPage(skin = "blue",
                                            dashboardHeader(title = ""),
                                            ## dashboard sidebar ----
                                            dashboardSidebar(collapsed = FALSE,
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
                                                               menuItem("Previous Reports", href= "https://llbc.ent.sirsidynix.net/client/en_GB/main/search/results?qu=small+business+profile&te=", newtab = TRUE, icon = icon("link")),
                                                               menuItem("Small Business Resources", href= "https://www2.gov.bc.ca/gov/content/employment-business/business/small-business/resources", newtab = TRUE, icon = icon("link")),
                                                         tags$div(style = "text-align:center;color:#b8c7ce",
                                                                        br(),
                                                                        downloadButton(outputId = "download_data", "Download data as excel"),
                                                                        br(), br(),
                                                                 # menuItem(
                                                                  #  div(tags$img(src = "StrongerBC_188.png"))
                                                                #  )  ,
                                                                  br(),
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
                                tags$div(id = "light-blue",
                                         box(
                                           title = list( icon = icon("line-chart"), "Small business counts"),
                                           div(style = "margin-bottom:43px",
                                               HTML("<bottom>There were 513,300 businesses in B.C. in 2022. Of these, 98 per cent (<b>504,200</b>) were <b>small businesses with fewer than 50 employees</b></bottom>."),
                                               actionButton("explore1", "Explore further", icon= icon("line-chart"),
                                                            class = "home-tab-btn")
                                           ),
                                           width = 4
                                         ),
                                         box(
                                           title = list( icon = icon("line-chart"), "Small business growth"),
                                           div(style = "margin-bottom:43px",
                                             HTML("Overall, there was a new 0.2 per cent or <b>1,020 increase in the number of small businesses in 2022</b>. Between 2017 and 2022, the number of small businesses in B.C. grew by 3.1 per cent, for a new increase of 15,100 businesses."),
                                             actionButton("explore2", "Explore further", icon = icon("line-chart"),
                                                          class = "home-tab-btn")
                                           ),
                                           width = 4
                                         )),
                                tags$div(id = "light-blue",
                                         box(
                                           title = list( icon = icon("usd"), "Contribution to the economy"),
                                           div(style = "margin-bottom:43px",
                                             HTML("In 2022, B.C.'s small business sector generate aproximately <b>33 per cent</b> of provincial GDP."),
                                             actionButton("explore3", "Explore further", icon = icon("usd"),
                                                          class = "home-tab-btn")
                                           ),
                                           width = 4
                                         ))),

                              # row 2 of landing page boxes
                              fluidRow(
                                tags$div(id = "light-blue",

                                         box(
                                           title = list(icon = icon("users"), "Small business employment"),
                                           div(style = "margin-bottom:43px",
                                             HTML("Small businesses in B.C. employed around <b>1,135,300 people</b> in 2022. This accounts for 51 per cent of private sector jobs in the province."),
                                             actionButton("explore4", "Explore further", icon = icon("users"),
                                                          class = "home-tab-btn")
                                           ),
                                           width = 4
                                         )),
                                tags$div(id = "light-blue",
                                         box(
                                           title = list( icon = icon("user"), "Self-employment growth"),
                                           div(style = "margin-bottom:43px",
                                             HTML("In 2022, there were <b>423,800 self-employed people</b> in B.C., 0.8 per cent higher than in 2021. However, self-employment fell by 0.9 per cent compared to 2017."),
                                             actionButton("explore5", "Explore further", icon = icon("user"),
                                                          class = "home-tab-btn")
                                           ),
                                           width = 4
                                         ),
                                box(
                                  title = list( icon = icon("user"), "Self-employment for women"),
                                  div(style = "margin-bottom:43px",
                                    HTML("In 2022, <b>38.3 per cent</b> of all self-employed people in B.C. were <b>women</b>, ranking fourth among provinces."),
                                    actionButton("explore6", "Explore further", icon = icon("user"),
                                                 class = "home-tab-btn")
                                  ),
                                  width = 4
                                ))),


                              # row 3 of landing page boxes
                              fluidRow(

                                tags$div(id = "light-blue", box(
                                  title = list( icon = icon("user"), "Self-employment for Indigenous people"),
                                  div(style = "margin-bottom:43px",
                                    HTML("In 2022, only <b>9.5 per cent of all Indigenous workers were self-employed</b>, compared to a self-employment rate of 15.7 per cent for non-Indigenous workers."),
                                    actionButton("explore7", "Explore further", icon = icon("user"),
                                                 class = "home-tab-btn")
                                  ),
                                  width = 4
                                )),

                                tags$div(id = "light-blue", box(
                                  title = list( icon = icon("usd"), "Small business wages"),
                                  div(style = "margin-bottom:43px",
                                    HTML("Small business employees earned an <b>average annual salary of $53,800</b> in 2022, around $10,300 less than the $64,100 earned by the average large business employee."),
                                    actionButton("explore8", "Explore further", icon = icon("usd"),
                                                 class = "home-tab-btn")
                                  ),
                                  width = 4
                                )),
                                tags$div(id = "light-blue", box(
                                  title = list( icon = icon("truck"), "Small business exporters"),
                                  div(style = "margin-bottom:43px",
                                    HTML("In 2022 there were <b>6,555</b> BC businesses with fewer than 50 employees that <b>exported goods to international destinations</b>, accounting for 86 per cent of all exporting firms."),
                                    actionButton("explore9", "Explore further", icon = icon("truck"),
                                                 class = "home-tab-btn")
                                  ),
                                  width = 4
                                ))
                              )
                            ),



                            ## page 0 tab start - Other Indicators ----
                            tabItem(
                              tabName = "page0",

                   #                       "page 0",
                              fluidRow(

                                box(title = "Figure 6.1: Small businesses tax rates by province, 2024",
                                    HTML("<p><small><i>This chart is an overview of the small business tax rates across different provinces.</i></small>"), plotlyOutput("plotK1"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b>B.C. Ministry of Finance / Prepared by BC Stats</small>")
                                    , fluidRow(box(title = HTML("<small><b>Definitions:</b></small>"),
                                                 HTML("<small>
                                                      <p>The lower small business tax rate is applicable to Canadian-controlled private corporations (CCPCs) with active business income eligible for the federal small business deduction. One component of the small business deduction is the business limit.
                                                      As of January 2023, the limit is $500,000 for all provinces and territories except Saskatchewan ($600,000). <p></small>"),
                                                 collapsible = TRUE, collapsed = TRUE))
                                ),

                                box(title = "Figure 6.2: Total building permits per capita, 2023",
                                    HTML("<p><small><i>This chart shows the value of building permits divided by the total population by province.</i></small>"), plotlyOutput("plotK2"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats</small>")
                                    , fluidRow(box(title = HTML("<small><b>Definitions:</b></small>"),
                                                   HTML("<small>
                                                      <p>The value of building permits includes expenditures in materials, labour, profit and overhead.
                                                        The type of structures include new buildings, additions, alterations and renovations. <p></small>"),
                                                   collapsible = TRUE, collapsed = TRUE))
                                ),

                                box(title = "Figure 6.3: Business bankruptcy rates by province, 2023",
                                    HTML("<p><small><i>This chart shows the number of business bankruptcies filed in a year for every 1,000 businesses by province. </i></small>"), plotlyOutput("plotK3"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> Innovation, Science and Economic Development Canada / Prepared by BC Stats.</small>")
                                    , fluidRow(box(title = HTML("<small><b>Definitions:</b></small>"),
                                                   HTML("<small>
                                                      <p>Bankruptcy is a legal process performed under the Bankruptcy and Insolvency Act. A business' assets are assigned to a licence trustee because of inability to pay debts. A business bankruptcy is chiefly attributable to the liabilities incurred as a result of
                                                        carrying on a commercial venture or business, and includes proprietorships, partnerships and Limited Companies.<p></small>"),
                                                   collapsible = TRUE, collapsed = TRUE))
                                ),
                                box(HTML("<p><b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10),

)),
                            ## page 0 tab end ----






                            ## page 1 tab start - Small business growth ----
                            tabItem(
                              tabName = "page1",
                              fluidRow(

                                box(title = paste("Figure 1.1:", data_new %>% filter(Topic_id == "1.01") %>% distinct(Topic) %>% pull()),
                                    HTML("<p><small><i>This table provides a breakdown of the number of businesses in British Columbia by employment size.</i></small>"), DTOutput("datatable1"),
                                    style = "border: 1px solid white;", width = 10,
                                    br(),
                                    HTML("<b><small>Note: </b>Figures do not add to 100 per cent due to rounding.
                                         <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    , fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                   HTML("<small>
                                                      <p>In B.C., a<b> <i>small business</i></b>  is defined as one with fewer than 50 employees, or a business operated by a person who is self-employed, without paid help.
                                                        Businesses with 50 or more employees are considered large businesses. <p>
                                                        <b> <i>Micro-businesses</i></b> are those with fewer than five employees, including self-employed individuals without staff and businesses with 1-4 employees.<p>
                                                        </small>"),
                                                   collapsible = TRUE, collapsed = TRUE))
                                ),



                                box(title = "Figure 1.2: Count of small businesses in British Columbia",
                                    HTML("<p><small><i>This chart shows the number of small businesses broken out by how many people they employ. </i></small>"), plotlyOutput("plot1.1"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),

                                box(title = "Figure 1.3: Share of businesses by employment size in British Columbia, 2022",
                                     HTML("<p><small><i>This chart shows the relative proportion of businesses that are small with employees, small without employees and large.</i></small>"), plotlyOutput("plot1.0.1"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    , fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                   HTML("<small>
                                                      <p>In B.C., a<b> <i>small business</i></b>  is defined as one with fewer than 50 employees, or a business operated by a person who is self-employed, without paid help.
                                                        Businesses with 50 or more employees are considered large businesses. <p>

                                                        </small>"),
                                                   collapsible = TRUE, collapsed = TRUE))
                                ),


                                box(title = "Figure 1.4: One, two and five-year growth of British Columbia businesses by size",
                                     width = 10,
                                    solidHeader = TRUE,
                                    tabsetPanel(
                                      tabPanel("1 year", HTML("<p><small><i>This chart shows the one-year growth of businesses in British Columbia by employee size.</i></small>"),plotlyOutput("plot1.2a1"), style = "width: 4"),
                                      tabPanel("2 year", HTML("<p><small><i>This chart shows the two-year growth of businesses in British Columbia by employee size.</i></small>"),plotlyOutput("plot1.2a2")),
                                      tabPanel("5 year", HTML("<p><small><i>This chart shows the five-year growth of businesses in British Columbia by employee size.</i></small>"),plotlyOutput("plot1.2a3"))
                                    ),
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),



                                box(title = "Figure 1.5: Distribution of small businesses by industry, 2023",
                                    HTML("<p><small><i>This chart shows the relative proportion of small businesses in different industries in British Columbia.</i></small>"), plotlyOutput("plot1.3a"), width = 10, br(),
                                    HTML("<b><small></b>
                                    <p><b>Note:</b> Natural Resources* is comprised of the agriculture, forestry, fishing, mining, oil and gas industries.
                                    <p><b>Note:</b> Utilities comprises <0.1 per cent of small businesses.
                                    <p><b>Note:</b> The total does not sum to 100 per cent as some businesses with employees could not be classified by industry.
                                    <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    , fluidRow(box(title = HTML("<small><b>Definition:</b></small>"),
                                                   HTML("<small>
                                                      Industries in this chart are grouped using the North American Industry Classification System (NAICS).
                                                      NAICS is a classification system used in Canada, the United States and Mexico,
                                                      which is designed to provide common definitions of the industrial structure of the three countries.
                                                        NAICS is Statistics Canada’s comprehensive system encompassing all economic activities.  <p></small>"),
                                                   collapsible = TRUE, collapsed = TRUE))
                                ),

                                box(title = "Figure 1.6: Distribution of small businesses with and without employees by industry, 2023",
                                    HTML("<p><small><i>This chart shows the relative proportion of small businesses in different industries in British Columbia for businesses with and without employees.</i></small>"), plotlyOutput("plot1.3b"), width = 10, br(),
                                    HTML("<b><small></b> <p><b>Note:</b> Natural Resources is comprised of the agriculture, forestry, fishing, mining, oil and gas industries.
                                    <p><b>Note:</b> Self-employment in utilities (small businesses with no paid employees) is less than 1,500 and is suppressed for confidentiality reasons.
                                    <p><b>Note:</b> The total does not sum to 100 per cent as some businesses could not be classified by industry.
                                    <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    , fluidRow(box(title = HTML("<small><b>Definition:</b></small>"),
                                                   HTML("<small>
                                                     Industries in this chart are grouped using the North American Industry Classification System (NAICS).
                                                      NAICS is a classification system used in Canada, the United States and Mexico,
                                                      which is designed to provide common definitions of the industrial structure of the three countries.
                                                        NAICS is Statistics Canada’s comprehensive system encompassing all economic activities.  <p></small>"),
                                                   collapsible = TRUE, collapsed = TRUE))
                                ),

                                box(title = "Figure 1.7: Small businesses by industry, proportions with and without employees, 2022",
                                    HTML("<p><small><i>This chart shows the proportion of small businesses with and without employees within each industry in British Columbia.</i></small>"), plotlyOutput("plot1.4"), width = 10,
                                    br(),
                                    HTML("<small>
                                   <p><b>Note:</b> Natural Resources is comprised of the agriculture, forestry, fishing, mining, oil and gas industries.
                                   <p><b>Note:</b> Utilities is not shown because the number of small businesses with employees is <200 and self-employment without paid help is very small and suppressed for confidentiality reasons.
                                    <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    , fluidRow(box(title = HTML("<small><b>Definition:</b></small>"),
                                                   HTML("<small>
                                                      Industries in this chart are grouped using the North American Industry Classification System (NAICS).
                                                      NAICS is a classification system used in Canada, the United States and Mexico,
                                                      which is designed to provide common definitions of the industrial structure of the three countries.
                                                        NAICS is Statistics Canada’s comprehensive system encompassing all economic activities.  <p></small>"),
                                                   collapsible = TRUE, collapsed = TRUE))
                                ),

                                box(title = "Figure 1.8: Fastest-growing industries by number of net new small businesses with employees, British Columbia, 2017-2022",

                                    HTML("<p><small><i>This chart shows the five industries with the most net new businesses in the last five years in British Columbia.
                                         The number of net new businesses is also shown for non-standard industries.</i></small>"), plotlyOutput("plot1.5"),
                                    width = 10, br(),
                                    HTML("<small>
                                   <p><b>Note:</b> Excludes self-employed without paid help.
                                   <p><b>Source:</b> BC Stats using data supplied by Statistics Canada</small>"),

                                    fluidRow(box(title = HTML("<small><b>Definitions:</b></small>"),
                                                 HTML("<small>
                                               <b> <p><i>Tourism</i></b> includes industries such as transportation, accommodation, food services and other tourism related activities. Further information on the tourism sector is available at BC Stats.
                                                 <p><b> <i>High technology</i></b> industries may employ a high proportion of scientists and researchers or invest a high proportion of revenues in research and development. Other industries that produce
                                    high technology products are also included. Further information on the high technology sector is available online at BC Stats.
                                                 <p><b> <i>Secondary manufacturing</i></b> industries are those that produce goods from the products of other manufacturers. For example, a sawmill is a manufacturing operation, but not a secondary manufacturer,
                                    because its logs do not come from another manufacturer. On the other hand, a factory producing wooden doors with lumber obtained
                                                      from sawmills is a secondary manufacturer.<p></small>"),
                                                 collapsible = TRUE, collapsed = TRUE))
                                     ),

                                box(title = "Figure 1.9: Fastest-growing industries by per cent growth in small businesses with employees, British Columbia, 2017-2022",

                                    HTML("<p><small><i>This chart shows the five industries with the highest growth rate in the number of net new businesses in the last five years in British Columbia.
                                         Net new business growth rates are also shown for non-standard industries.</i></small>"), plotlyOutput("plot1.6"), width = 10,
                                    br(),
                                    HTML("<small>
                                   <p><b>Note:</b> Excludes self-employed without paid help.
                                   <p><b>Source:</b> BC Stats using data supplied by Statistics Canada</small>"),

                                    fluidRow(box(title = HTML("<small><b>Definitions:</b></small>"),
                                                 HTML("<small>
                                                <b> <p><i>Tourism</i></b> includes industries such as transportation, accommodation, food services and other tourism related activities. Further information on the tourism sector is available at BC Stats.
                                                 <p><b> <i>High technology</i></b> industries may employ a high proportion of scientists and researchers or invest a high proportion of revenues in research and development. Other industries that produce
                                    high technology products are also included. Further information on the high technology sector is available online at BC Stats.
                                                 <p><b> <i>Secondary manufacturing</i></b> industries are those that produce goods from the products of other manufacturers. For example, a sawmill is a manufacturing operation, but not a secondary manufacturer,
                                    because its logs do not come from another manufacturer. On the other hand, a factory producing wooden doors with lumber obtained
                                                      from sawmills is a secondary manufacturer.<p></small>"),
                                                 collapsible = TRUE, collapsed = TRUE))
                                ),

                                box(title = "Figure 1.10: Small businesses per 1,000 people by province, 2022",
                                    HTML("<p><small><i>This chart shows the number of small businesses per 1,000 people by province.</i></small>"), plotlyOutput("plot1.7"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),

                                box(title = "Figure 1.11: Small business growth by province, 2017-2022",
                                    HTML("<p><small><i>This chart illustrates the annual change in the number of small business for each province. </i></small>"), plotlyOutput("plot1.8"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),

                                box(title = "Figure 1.12: Small business and population distribution by region in British Columbia, 2022",
                                    HTML("<p><small><i>This chart provides a detailed view of small business and population distributions around British Columbia.</i></small>"), plotOutput("plot1.9", height = "470px"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),

                                box(title = "Figure 1.13: Small businesses per 1,000 people by region in British Columbia, 2022",
                                    HTML("<p><small><i>This chart shows the number of small business per 1,000 people by development region in British Columbia.</i></small>"), plotlyOutput("plot1.10"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")


                                ),

                                box(title = "Figure 1.14: Number of small businesses by region, 2022",
                                    HTML("<p><small><i>This chart shows the number of small businesses by development region in British Columbia.</i></small>"), plotlyOutput("plot1.11a"), width = 10,
                                    br(),
                                    HTML("<b><small></b>
                                         <p><b>Note:</b> Figures do not add to the total because the provincial total
                                         includes some businesses for which the region is unknown.
                                         <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>"

                                         )


                                ),
                                box(title = "Figure 1.15: Net change in number of small businesses by region, 2017-2022",
                                    HTML("<p><small><i>This chart shows the net annual change in the number of small businesses by development region in British Columbia.
                                         That is, the difference between the number of small businesses between the latest annual data and the previous year. </i></small>"), plotlyOutput("plot1.11b"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                ),
                                box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10),

                              )),

                            ## page 1 tab end ----

                            ## page 2 tab start----
                            tabItem(
                              tabName = "page2",
                              fluidRow(

                                box(title = "Figure 2.1: Private sector employment in British Columbia by size of business, 2022",
                                    HTML("<p><small><i>This table shows the breakdown of employees in the private sector for small and large businesses.</i></small>"), DTOutput("datatable2"),
                                    style = "border: 1px solid white;", width = 10,
                                    br(),
                                    HTML("<b><small><p>Note:</b> Includes the self-employed with and without paid help.
                                         <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    ,
                                    fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                 HTML("<small><b><i>Public sector employees </b></i>are employees in public administration at the federal, provincial, territorial, municipal, First Nations and other Indigenous governments as well as in Crown corporations, liquor control boards, and other government institutions such as schools (including universities), hospitals and public libraries.
                                                 <br><b><i>Private sector employees</i></b> includes all employees are those who do not work in a government institution,
                                                 or other government controlled business such as Crown corporations, liquor control boards, public education, hospitals and public libraries.
                                         </small>"),
                                                 collapsible = TRUE, collapsed = TRUE))
                                ),

                                box(title = "Figure 2.2 Share of total employment in British Columbia, 2022", HTML("<p><small><i>This chart shows the proportion of employees who work in the public sector, small and large businesses.</i></small>"), plotlyOutput("plot2.1"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    ,
                                    fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                 HTML("<small><b><i>Public sector employees </b></i>are employees in public administration at the federal, provincial, territorial, municipal, First Nations and other Indigenous governments as well as in Crown corporations, liquor control boards, and other government institutions such as schools (including universities), hospitals and public libraries.
                                                 <br><b><i>Private sector employees</i></b> includes all employees are those who do not work in a government institution,
                                                 or other government controlled business such as Crown corporations, liquor control boards, public education, hospitals and public libraries.
                                         </small>"),
                                                 collapsible = TRUE, collapsed = TRUE))
                                ),



                                box(title = "Figure 2.3: Share of employment by establishment size, 2022", HTML("<p><small><i>This chart shows the proportion of employees who work in the public sector, small businesses with and without employees, and large businesses.</i></small>"), plotlyOutput("plot2.3"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                    ,
                                    fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                 HTML("<small><b><i>Public sector employees </b></i>are employees in public administration at the federal, provincial, territorial, municipal, First Nations and other Indigenous governments as well as in Crown corporations, liquor control boards, and other government institutions such as schools (including universities), hospitals and public libraries.
                                                 <br><b><i>Private sector employees</i></b> includes all employees are those who do not work in a government institution,
                                                 or other government controlled business such as Crown corporations, liquor control boards, public education, hospitals and public libraries.
                                         </small>"),
                                                 collapsible = TRUE, collapsed = TRUE))
                                ),



                                box(title = "Figure 2.4: Year-over-year growth in private sector employment", HTML("<p><small><i>This chart shows the annual growth in the number of people employed in the private sector by business size.</i></small>"), plotlyOutput("plot2.4b"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),


                                box(title = "Figure 2.5: One-year small business employment change, by province, 2021-2022", HTML("<p><small><i>This chart shows the annual rate of growth in small businesses employment by province.</i></small>"), plotlyOutput("plot2.5a"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),

                                box(title = "Figure 2.6: Five-year small business employment change by province, 2017-2022", HTML("<p><small><i>This chart shows the five-year rate of growth in small businesses employment by province.</i></small>"), plotlyOutput("plot2.5b"), width = 10,
                                    br(),
                                    HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),

                                box(title = "Figure 2.7: Small business as a per cent of private sector employment by province, 2022", HTML("<p><small><i>This chart shows employees in small businesses as a proportion of total private sector employment by province.</i></small>"), plotlyOutput("plot2.6"), width = 10,
                                br(),
                                HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                ),


                                 box(title = "Figure 2.8: One-year top and bottom industries for small business employment growth in British Columbia", HTML("<p><small><i>This chart shows the five industries with the largest rate of employment growth in the last  year in British Columbia. It also shows the five industries with the lowest rate of employment growth in the last year.</i></small>"), plotlyOutput("plot2.7a"), width = 10,
                                 br(),
                                 HTML("<b><small><p>Note:</b> Public administration employment here measures small government entities such as small municipal and Indigenous government organizations.
                                         <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>"))
                                     ,


                                box(title = "Figure 2.9: Two-year top and bottom industries for small business employment growth in British Columbia", HTML("<p><small><i>This chart shows the five industries with the largest rate of employment growth in the last two years in British Columbia. It also shows the five industries with the lowest rate of employment growth in the last two years.</i></small>"), plotlyOutput("plot2.7b"), width = 10,
                                    br(),
                                    HTML("<b><small><p>Note:</b> Public administration employment here measures small government entities such as small municipal and Indigenous government organizations.
                                         <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>"))
                                     ,


                                box(title = "Figure 2.10: Five-year top and bottom industries for small business employment growth in British Columbia", HTML("<p><small><i>This chart shows the five industries with the largest rate of employment growth in the last five years in British Columbia. It also shows the five industries with the lowest rate of employment growth in the last five years.</i></small>"), plotlyOutput("plot2.7c"), width = 10,
                                    br(),
                                    HTML("<b><small><p>Note:</b> Public administration employment here measures small government entities such as small municipal and Indigenous government organizations.
                                         <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>"))
                                   ,


                                box(HTML("<b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10),

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


                                 box(title = "Figure 3.1: Self-employment as a per cent of total employment by province, 2022", HTML("<p><small><i>This chart shows the different levels of self-employment as a percentage of total employment across the provinces and compared to the Canadian average. </i></small>"), plotlyOutput("plot3.01"), width = 10,
                                     br(),
                                     HTML("<p><b><small>Source:</b> Statistics Canada / Prepared by BC Stats</small>")
                                     ,
                                     fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                  HTML("<small><b><i>Self-employed </b></i>are persons whose job consisted mainly of operating a business,
                                                  farm or professional practice, alone or in partnership.
                                         </small>"),
                                                  collapsible = TRUE, collapsed = TRUE))


                                 ),

                                 box(title = "Figure 3.2: Self-employment per cent change by province, 2017-2022", HTML("<p><small><i>This chart shows the growth of self-employment in the last five years by province. </i></small>"), plotlyOutput("plot3.02"), width = 10,
                                     br(),
                                     HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")

                                     ,
                                     fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                  HTML("<small><b><i>Self-employed </b></i>are persons whose job consisted mainly of operating a business,
                                                  farm or professional practice, alone or in partnership.
                                         </small>"),
                                                  collapsible = TRUE, collapsed = TRUE))


                                 ),

                                 box(title = "Figure 3.3: One-year and five-year self-employment per cent change for regions in British Columbia",
                                     width = 10,
                                     solidHeader = TRUE,
                                     tabsetPanel(
                                       tabPanel("One-year", HTML("<p><small><i>This chart shows the growth of self-employment in the last year by development region. </i></small>"), plotlyOutput("plot3.03a"), style = "width: 4"),
                                       tabPanel("Five-year", HTML("<p><small><i>This chart shows the growth of self-employment in the last five years by development region. </i></small>"), plotlyOutput("plot3.03b"))

                                     ),
                                     br(),
                                     HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                     ,
                                     fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                  HTML("<small><b><i>Self-employed </b></i>are persons whose job consisted mainly of operating a business,
                                                  farm or professional practice, alone or in partnership.
                                         </small>"),
                                                  collapsible = TRUE, collapsed = TRUE))



                                 ),


                                 box(title = "Figure 3.4: Number of self-employed persons with and without paid help in British Columbia, 2022", HTML("<p><small><i>This chart shows self-employed persons with and without paid help by incorporation status. </i></small>"), plotlyOutput("plot3.1a"), width = 10,
                                     br(),
                                     HTML("<b><small>Note:</b> Excludes unpaid family workers


                                         <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")

                                     ,
                                     fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                  HTML("<small><b><i>Incorporated businesses </b></i>consist of those organized and maintained as legal corporations. A corporation is created (incorporated) by
                                                  one or more shareholders who have ownership of the corporation, represented by their holding of common stock.
                                                  <p>
                                                  <b><i>Unincorporated businesses </b></i>consist of those not organized and maintained as legal corporations, and wherein the tie between members need not be a legally enforceable contract.
                                                  <p>
                                         </small>"),
                                                  collapsible = TRUE, collapsed = TRUE))


                                 ),

                                 box(title = "Figure 3.5: Number of self-employed persons in British Columbia by incorporation status, 2022", HTML("<p><small><i>This chart shows self-employed persons by incorporation status with and without paid help.  </i></small>"), plotlyOutput("plot3.1b"), width = 10,
                                     br(),
                                     HTML("<b><small>Note:</b> Excludes unpaid family workers


                                         <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                     ,
                                     fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                  HTML("<small><b><i>Incorporated businesses </b></i>consist of those organized and maintained as legal corporations. A corporation is created (incorporated) by
                                                  one or more shareholders who have ownership of the corporation, represented by their holding of common stock.
                                                  <p>
                                                  <b><i>Unincorporated businesses </b></i>consist of those not organized and maintained as legal corporations, and wherein the tie between members need not be a legally enforceable contract.
                                                  <p>
                                         </small>"),
                                                  collapsible = TRUE, collapsed = TRUE))

                                 ),

                                 box(title = "Figure 3.6: Number of self-employed with paid help compared to self-employed without paid help, British Columbia, 2017-2022", HTML("<p><small><i>This chart compares the number of self-employed persons with paid help and those without paid help for selected years.</i></small>"), plotlyOutput("plot3.2"), width = 10,
                                     br(),
                                     HTML("<b><small>Note:</b> Excludes unpaid family workers


                                         <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")
                                 )
                                 ,

                                 box(title = "Figure 3.7: Age distribution of self-employed workers compared to employees, British Columbia, 2022", HTML("<p><small><i>This chart compares the proportion of persons who are self-employed and those who are employed by age.</i></small>"), plotlyOutput("plot3.3"), width = 10,
                                     br(),
                                     HTML("<b><small> <p>Notes</b>: Figures do not add to 100 per cent due to rounding.
                                          <p><b><b>Source:</b></b> Statistics Canada / Prepared by BC Stats</small>")

                                 ),

                                 box(title = "Figure 3.8: Share of British Columbian workers who are self-employed, by age", HTML("<p><small><i>This chart shows the distribution of persons who are self-employed by age over time.</i></small>"), plotlyOutput("plot3.3b"), width = 10,
                                     br(),
                                     HTML("<b><small> <p>Notes</b>: Figures do not add to 100 per cent due to rounding.
                                          <p><b><b>Source:</b></b> Statistics Canada / Prepared by BC Stats</small>")
                                 ),


                                 box(title = "Figure 3.9: Hours worked, self-employed compared to employees, 2022", HTML("<p><small><i>This chart compares the number of usual hours worked per week for self-employed indivuals and employees.</i></small>"), plotlyOutput("plot3.7a"), width = 10,
                                     br(),
                                     HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100 per cent due to rounding.<p>
                                     <b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>"),

                                     fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                  HTML("<small><b>Usual work hours</b> refers to the employed person's normal paid or contract hours, not counting any overtime.
                                         </small>"),
                                                  collapsible = TRUE, collapsed = TRUE))
                                 ),





                             ),
                           ),
                           ## page 3 subtab main end -----




                           ## page 3 subtab women start ----
                           tabItem(
                             tabName = "women",
                       #      "page 3 - women",

                             fluidRow(

                               box(title = "Figure 3.10: Proportion of self-employed who are women by province, 2022", HTML("<p><small><i>This chart shows shows the proportion of self-employed persons who identify as women by province.</i></small>"), plotlyOutput("plot3.4"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Note:</b> Excludes unpaid family workers.
                                    <p><b>Source:</b> Statistics Canada / Prepared by BC Stats</small>")
                               ),

                               box(title = "Figure 3.11: Proportion of self-employed who are women, by region, 2017 and 2022", HTML("<p><small><i>This chart shows the proportion of self-employed persons who identify as women by development region.</i></small>"), plotlyOutput("plot3.5"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Note:</b> Includes unpaid family workers.
                                  <p><b>Source:</b>  Statistics Canada / Prepared by BC Stats.</small>")
                               ),

                               box(title = "Figure 3.12: Hours worked among self-employed men and women, British Columbia, 2022", HTML("<p><small><i>This chart compares the number of usual hours worked per week for self-employed persons by sex.</i></small>"), plotlyOutput("plot3.7b"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100 per cent due to rounding.<p>
                                     <b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>"),


                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b>Usual work hours</b> refers to the employed person's normal paid or contract hours, not counting any overtime.
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))






                               ),

                             ),
                           ),
                           ## page 3 subtab women end -----
                           ## page 3 subtab indigenous start ----
                           tabItem(
                             tabName = "indigenous",
                         #    "page 3 - indigenous",


                             fluidRow(

                               box(title = "Figure 3.13: Per cent of working, off-reserve Indigenous and non-Indigenous people who are self-employed in British Columbia, 2017-2022", HTML("<p><small><i>This chart shows persons who are self-employed as a percentage of total employment for off-reserve Indigenous and Non-Indigenous populations.</i></small>"), plotlyOutput("plot3.6"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <b>Note:</b> This data is only available for the off-reserve Indigenous population.
                                        <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")

                                                                                            ,
                                     fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                  HTML("<small><b><i>Indigenous Persons </b></i>are those who indicate that they identify as an Indigenous person, and/or are registered under the Indian Act, and/or are a member of a First Nation or Indian band.
                                                  <p>
                                                  <b><i>Off reserve </b></i>includes all census subdivisions in Canada not legally affiliated with First Nations or Indian bands.
                                                  <p>
                                         </small>"),
                                                  collapsible = TRUE, collapsed = TRUE))
                               ),



                             ),
                           ),
                           ## page 3 subtab indigenous end ----
                           ## page 4 tab start ----
                           tabItem(
                             tabName = "page4",
                    #         "page 4",

                             fluidRow(

                               box(title = "Figure 4.1: Small business contribution to GDP by province, 2022", HTML("<p><small><i>This chart shows the percentage of GDP that is attributable to small business activities.</i></small>"), plotlyOutput("plot4.1"), width = 10,
                                   br(),
                                   HTML("<small>
                                    <p><b>Source:</b> BC Stats.</small>")

                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b><i>Gross Domestic Product (GDP) </b></i> refers to the total market value of all the goods and services produced within national or provincial borders during a specified period.
                                                The growth rates of GDP provide an indication of how well an industry or an economy is doing.
                                                  <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))



                               ),

                               box(title = "Figure 4.2: Changes in average annual earnings in British Columbia, 2017-2022", HTML("<p><small><i>This chart shows the average annual earnings for employes of small and large businesses for selected years.</i></small>"), plotlyOutput("plot4.2"), width = 10,
                                   br(),
                                   HTML("<b><small></b>

                                       <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b><i>Average annual earnings </b></i> refers to the gross taxable payroll of an employee,
                                                expressed on an annual basis, including pay for overtime.
                                                  <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
                               ),


                               box(title = "Figure 4.3: Small business average annual earnings and wage gap by industry, 2022", HTML("<p><small><i>This chart shows the average annual earnings for employes of small and large businesses by industry.</i></small>"), plotlyOutput("plot4.3"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <b>Note: </b>The level of small-business employment in the utilities sector is very small, less than 3 per cent of total.<p>
                                        <b>Source:</b> BC Stats using data supplied by Statistics Canada. </small>")

                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b><i>Average annual earnings </b></i> refers to the gross taxable payroll of an employee,
                                                expressed on an annual basis, including pay for overtime.
                                                  <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
                               ),




                               box(title = "Figure 4.4: Small business wage gaps by industry, British Columbia, 2017 and 2022", HTML("<p><small><i>This chart shows the difference in the average annual earnings for employes of small and large businesses by industry for selected years.</i></small>"), plotlyOutput("plot4.4"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")
                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b><i>Average annual earnings </b></i> refers to the gross taxable payroll of an employee,
                                                expressed on an annual basis, including pay for overtime.
                                                  <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))

                                     ),

                               box(title = "Figure 4.5: Average annual earnings by province, 2022", HTML("<p><small><i>This chart illustrates the difference in average annual earnings between small and large businesses by province.</i></small>"), plotlyOutput("plot4.5"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b><i>Average annual earnings </b></i> refers to the gross taxable payroll of an employee,
                                                expressed on an annual basis, including pay for overtime.
                                                  <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
                               ),

                               box(title = "Figure 4.6: Small business share of total payroll by province, 2022", HTML("<p><small><i>This chart shows the proportion of total provincial payrolls attributable to small businesses.</i></small>"), plotlyOutput("plot4.6"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>")

                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b><i>Payroll </b></i> includes regular pay, overtime and bonuses, commissions and all other types of special payments. The payroll concept excludes dollar amounts that are taxable allowances and benefits, certain types of non-wage compensation, as well as employer contributions to employment insurance, Canada and Quebec pension plans, provincial medical plans, workers’ compensation and other welfare plans.
                                                  <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
                               ),
                               box(HTML("<p><b><center>Feedback:</b> SmallBusinessBranch@gov.bc.ca </center>"), width = 10),

                             )),
                           ## page 4 tab end ----
                           ## page 5 tab start ----
                           tabItem(
                             tabName = "page5",
                         #    "page 5",

                             fluidRow(


                               box(title = "Figure 5.1: Number of British Columbia exporters and value of exports, British Columbia",
                                   width = 10,
                                   solidHeader = TRUE,
                                   tabsetPanel(
                                     tabPanel("Values", HTML("<p><small><i>This table shows the number of exporters and the value of exports in British Columbia by business size for selected years.</i></small>"),DTOutput("datatable5.1"), style = "width: 4"),
                                     tabPanel("Percentages", HTML("<p><small><i>This table shows the number of exporters and the value of exports in British Columbia by business size for selected years, as a proportion of the total.</i></small>"),DTOutput("datatable5.1b"))
                                   ),
                                   br(),
                                   HTML("<b><small></b> <p><b>Source:</b> Statistics Canada/Prepared by BC Stats.</small>"),
                                       fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                    HTML("<small>An <b><i>exporter</b></i> is defined as an enterprise that sells goods out of the country, regardless of the value of exports.<p>
                                                      <p><b><i>Value of exports</b></i> is measured in Canadian dollars. Value is as recorded in official customs documents, typically the actual selling price used for company accounting purposes. Canadian exports to overseas countries
                                                      are valued including domestic freight charges to the port of exit point but excluding discounts and allowances, and international insurance. <p>
                                             </small>"),
                                                    collapsible = TRUE, collapsed = TRUE))
                               ),






                               box(title = "Figure 5.2: Growth in small business exporters and exports by province and territory",
                                   HTML("<p><small><i>This table shows the growth in the number of exporters and the value of exports in British Columbia by business size for selected years.</i></small>"), DTOutput("datatable5.2"),
                                   style = "border: 1px solid white;", width = 10
                                   ,
                                   HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100 per cent due to rounding.</small>"),
                                   HTML("<b><small></b> <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>"),
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small>An <b><i>exporter</b></i> is defined as an enterprise that sells goods out of the country, regardless of the value of exports.<p>
                                                      <p><b><i>Value of exports</b></i> is measured in Canadian dollars. Value is as recorded in official customs documents, typically the actual selling price used for company accounting purposes. Canadian exports to overseas countries
                                                      are valued including domestic freight charges to the port of exit point but excluding discounts and allowances, and international insurance. <p>
                                             </small>"),
                                                collapsible = TRUE, collapsed = TRUE))

                               ),

                               box(title = "Figure 5.3: Share of business exporters by destination of exports, 2022", HTML("<p><small><i>This chart shows the proportion of exporters in British Columbia by business size by destination of exports.</i></small>"), plotlyOutput("plot5.3b"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100 per cent due to rounding.
                                    <p><b>Source:</b> Statistics Canada / Prepared by BC Stats</small>"),

                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small>An <b><i>exporter</b></i> is defined as an enterprise that sells goods out of the country, regardless of the value of exports.
                                                 <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
                               ),

                               box(title = "Figure 5.4: Share of export value by destination of exports, 2022", HTML("<p><small><i>This chart shows the proportion of the value of exports in British Columbia by business size by destination of exports..</i></small>"), plotlyOutput("plot5.3"), width = 10,
                                   br(),
                                   HTML("<b><small></b> <p><b>Note:</b> Figures do not add to 100 per cent due to rounding.
                                    <p><b>Source:</b> Statistics Canada / Prepared by BC Stats. </small>"),
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><p><b><i>Value of exports</b></i> is measured in Canadian dollars. Value is as recorded in official customs documents, typically the actual selling price used for company accounting purposes. Canadian exports to overseas countries
                                   are valued including domestic freight charges to the port of exit point but excluding discounts and allowances, and international insurance. <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))





                               ),
                               box(title = "Figure 5.5: Destination share of value of small business exports by province, 2022", HTML("<p><small><i>This chart shows the proportion of the value of exports by small business exporters by destination of exports by province.</i></small>"), plotlyOutput("plot5.4"), width = 10,
                                   br(),
                                   HTML("<b><small></b>
                                    <p><b>Source:</b> BC Stats using data provided by Statistics Canada.</small>")

                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definitions:</b></small>"),
                                                HTML("<small>A <b><i>small business exporter</b></i> is defined as an enterprise with fewer than 50 employees that exports goods out of the country, regardless of the value of exports. <p>
                                                  <p><b><i>Value of exports</b></i> is measured in Canadian dollars. Value is as recorded in official customs documents, typically the actual selling price used for company accounting purposes. Canadian exports to overseas countries
                                                  are valued including domestic freight charges to the port of exit point but excluding discounts and allowances, and international insurance. <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
                               ),
                               box(title = "Figure 5.6: Export intensity for small businesses by province, 2022", HTML("<p><small><i>This chart illustrates the export intensity for small businesses by province.</i></small>"), plotlyOutput("plot5.5"), width = 10,
                                   br(),
                                   HTML("<small><b>Source:</b> BC Stats using data supplied by Statistics Canada.</small>"),

                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small>    <p><b><i>Export intensity</b></i> refers to the average value of exports per business.<p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
                               ),

                               box(title = "Figure 5.7: Value of goods exports for large and small businesses", HTML("<p><small><i>This chart shows the value of goods exported by British Columbia exporters by size over time. </i></small>"), plotlyOutput("plot5.04"), width = 10,
                                   br(),
                                   HTML("<small>

                                    <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</small>")


                                   ,
                                   fluidRow(box(title = HTML("<small><p><b>Definition:</b></small>"),
                                                HTML("<small><b><i>Value of exports</b></i> is measured in Canadian dollars. Value is as recorded in official customs documents, typically the actual selling price used for company accounting purposes. Canadian exports to overseas countries
                                                  are valued including domestic freight charges to the port of exit point but excluding discounts and allowances, and international insurance. <p>
                                         </small>"),
                                                collapsible = TRUE, collapsed = TRUE))
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

  observeEvent(input$tabs, shinyjs::runjs("window.scrollTo(0,0)"))

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
                     light_blue =  "#92b5d2", med_blue = "#0e83b0", dark_blue = "#015082",
                     navy = "#143047")

  custom_colors_rgb <- list(yellow= c(252,184,20), light_green = c(149,193,178), green = c(21,152,123),
                            light_blue=c(146,181,210), med_blue=c(14,131,176), dark_blue = c(1,80,130),
                            navy = c(20,48,71))

  region_colors <- c("Provincial Total" = "#000000",
                     "Cariboo" = "#95c1b2","Kootenay" = "#15987b","Mainland/Southwest" = "#0e83b0",
                     "North Coast & Nechako" = "#fcb814","Northeast" = "#143047","Thompson-Okanagan" = "#015082",
                     "Vancouver Island/Coast" = "#92b5d2")

  size_colors <- c("Small Business" = "#95c1b2", "Small businesses" = "#95c1b2",
                   "Small businesses with employees" = "#95c1b2",
                   "Small businesses with employees (Fewer than 50)" = "#95c1b2",
                   "Small businesses without employees (Self-employed without paid help)" = "#15987b",
                   "Small businesses without employees" = "#15987b",
                   "Large Business" = "#fcb814", "Large Businesses" = "#fcb814",
                   "Large businesses" = "#fcb814", "Large Businesses (Businesses with 50 or more)" = "#fcb814",
                   "Public Sector" = "#92b5d2")

# plotK1----
  ## Figure 6.1 Small business tax rates by province
  output$plotK1 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == 6.01) %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~Category,
            y = ~Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "Tax Rate", tickformat = "0.1%")) %>%
      plotly_custom_layout()

  })

  # plotK2----
  ## Figure 6.2: Total building permits per capita
  output$plotK2 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "6.02") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(Label = dollar(Value),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "$0,"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.35,
        y = 0.85,
        text = paste("<b>— All of Canada =", dollar(canada_average, accuracy = 1) ,"per capita</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plotK3----
  ## Figure 6.3: Business bankruptcy rates by province
  output$plotK3 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "6.03") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = 100*as.numeric(Value)) ## Check on this

    canada_average <- prep_data %>%
      filter(Category == "CAN") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CAN") %>%
      mutate(Label = round_half_up(Value, digits = 1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~Category,
            y = ~Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = ".1f"),
             shapes = list(hline(canada_average))) %>% ## add line
      ## add canadian average text
      add_annotations(x = 0.05,
                      y = 0.33,
                      text = paste0("<b>",round_half_up(canada_average, digits = 1)," = Canadian Average</b>"),
                      xref = "paper",
                      yref = "paper",
                      xanchor = "left",
                      yanchor = "bottom",
                      showarrow = F) %>%
      plotly_custom_layout()
  })

  # datatable1.1----
  ## Figure 1.1: Breakdown of businesses in British Columbia
  output$datatable1 <- renderDT({

    table_data <- data_new %>%
      filter(Topic_id == "1.01") %>%
      select(Category, Variable, Value) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for mixed type columns
      mutate_at(c(3,4), ~ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x)))) %>%
      mutate_at(c(6,8), ~ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x), accuracy = 0.1))) %>%
      mutate_at(c(2,5,7), ~ifelse(str_detect(.x, "<"), .x, comma(as.numeric(.x)))) %>%
      suppressWarnings()

    # Create the datatable
    datatable(table_data,
              rownames = FALSE,
              colnames = c("", names(table_data)[-1]),
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                scrollX = TRUE,
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
                  "}"),
                ## column widths
                columnDefs = list(list(width = '300px', targets = 0))))  %>%
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
  ## Figure 1.3: Share of businesses by employment size in British Columbia
  output$plot1.0.1 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "1.03") %>%
      mutate(Value = as.numeric(Value))

    total <- prep_data %>%
      filter(Variable == "Count", Category == "Total") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Variable == "Per cent" & Category != "Total") %>%
      mutate(Label = percent(Value),
             Category2 = str_replace_all(Category, "\\(", "\\\n\\("),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            y = ~Category2,
            x = ~Value,
            color = ~Category,
            colors = size_colors,
            type = "bar",
            orientation = 'h',
            text = ~paste0(Category2,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = '',
             xaxis = list(title = "", tickformat = ".0%"),
             yaxis = list(title = ""),
             showlegend = FALSE) %>%
      add_annotations( ## add requested additional info on chart
        x = 0,
        y = 0.99,
        text = paste0("<b>Total businesses and organizations = ", comma(total_count), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F) %>%
      plotly_custom_layout()

  })

  # plot1.1----
  ## Figure 1.2: Count of small businesses in British Columbia
  output$plot1.1 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.02" & Category != "Total small businesses") %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    # Create the stacked bar chart with custom colors
    plot_ly(plot_data,
            x = ~Variable,
            y = ~Value,
            color = ~Category,
            type = "bar",
            colors = custom_colors %>% unname() %>% rev(),
            text = ~paste0(Category,": ",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = "",
             xaxis = list(title = ""),
             yaxis = list(title = "", tickformat = ","),
             barmode = "relative",
             showlegend = TRUE,
             legend = list(orientation = "h", x = 0, y = 1.3),
             hovermode="x unified") %>%
      plotly_custom_layout()

  })

  # plot1.2a1 ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 1 year
  output$plot1.2a1 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "1-yr growth") %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            type = "bar",
            orientation = "h",
            text = ~paste0(Category,": ",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0,"),
             barmode = "relative",
             hovermode = 'y') %>%
      plotly_custom_layout()


  })

  # plot1.2a2 ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 2 year
  output$plot1.2a2 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "2-yr growth") %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
              x = ~Value,
              y = ~Category,
              type = "bar",
              orientation = "h",
              text = ~paste0(Category,": ",Label),
              textposition = "none",
              hoverinfo = 'text') %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0,"),
             barmode = "relative",
             hovermode = 'y') %>%
      plotly_custom_layout()
  })


  # plot1.2a3 ----
  ## Figure 1.4: One, two and five-year growth of British Columbia businesses by size
  ## 5 year
  output$plot1.2a3 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.04" & Variable == "5-yr growth") %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            type = "bar",
            orientation = "h",
            text = ~paste0(Category,": ",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0,"),
             barmode = "relative",
             hovermode = 'y') %>%
      plotly_custom_layout()

  })

  # plot1.3a ----
  ## Figure 1.5: Distribution of small businesses by industry
  output$plot1.3a <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "1.05" & Variable == "%") %>%
      select(Category, Value, Category2)

    ## Add in Goods and Service sector dummy rows
    plot_data <- bind_rows(
      data.frame(Category = "Goods Sector", Value = "0"),
      prep_data %>% filter(Category2 == "Goods Sector"),
      data.frame(Category = "Services Sector", Value = "0"),
      prep_data %>% filter(Category2 == "Services Sector")
    )  %>%
      mutate(Value = as.numeric(Value),
             Label = ifelse(Category %in% c("Goods Sector", "Services Sector"), "", percent(Value)),
             Category = fct_inorder(Category),
             custom_ticktext = ifelse(Category %in% c("Goods Sector", "Services Sector"),
                                      paste0("<span style='color: #005182'><b>", Category, "<b></span>"),
                                      as.character(Category)))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            type = "bar",
            marker = list(color = "#005182"),
            orientation = 'h',
            text = ~paste0(Category,": ",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(legend = list(orientation = "h", x = -2, y = 1.2),
             xaxis = list(title = "", tickformat = '0%'),
             yaxis = list(title = "",
                          tickvals = ~Category,
                          ticktext = ~custom_ticktext,
                          autorange = "reversed"),
             hovermode = 'y') %>%
      plotly_custom_layout()

  })

  # plot1.3b ----
  ## Figure 1.6: Distribution of small businesses with and without employees by industry
  output$plot1.3b <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.06" & Category != "Overall") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value, accuracy = 0.1),
             Variable = str_remove_all(Variable, " percent"),
             Variable_label = str_remove_all(Variable, "(Small businesses with )|( \\(([:space:]|[:graph:])*$)")) %>%
      arrange(desc(Variable), desc(Value)) %>%
      mutate(Category = fct_inorder(Category),
             Variable = fct_inorder(Variable))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
            type = "bar",
            orientation = 'h',
            text = ~paste0(Variable_label, ": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
             xaxis = list(title = "", tickformat = '0%'),
             yaxis = list(title = "", autorange = "reversed"),
             hovermode="y unified") %>%
      plotly_custom_layout()

  })

  # plot1.4----
  ## Figure 1.7: Small businesses by industry, proportions with and without employees
  output$plot1.4 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.07" & !str_detect(Variable, "Total") & str_detect(Variable, "percent")) %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value, accuracy = 0.1),
             Variable = str_remove_all(Variable, " percent")) %>%
      arrange(desc(Variable), desc(Value)) %>%
      mutate(Category = fct_inorder(Category),
             Variable = fct_inorder(Variable))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
            type = "bar",
            orientation = 'h',
            text = ~paste0(Variable, ": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
             xaxis = list(title = "", tickformat = '0%'),
             yaxis = list(title = ""),
             barmode = "stack",
             hovermode="y unified") %>%
      plotly_custom_layout()

  })

  # plot 1.5----
  ## Figure 1.8: Fastest-growing industries by number of net new small businesses with employees
  output$plot1.5 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "1.08" & nchar(Variable) > 4) %>%
      select(Category, Value, Category2) %>%
      mutate(Value = as.numeric(Value))

    ## Add in Non-Standard Sectors dummy row
    plot_data <- bind_rows(
      prep_data %>% filter(Category2 == "Industry") %>% mutate(color = "navy") %>%  arrange(desc(Value)),
      data.frame(Category = "Non-Standard Sectors", Value = 0),
      prep_data %>% filter(Category2 == "Non-Standard Sectors") %>% mutate(color = "dark_blue") %>%  arrange(desc(Value))
    )  %>%
      mutate(Label = ifelse(Category %in% c("Non-Standard Sectors"), "", comma(Value)),
             Category = fct_inorder(Category),
             custom_ticktext = ifelse(Category %in% c("Non-Standard Sectors"),
                                      paste0("<span style='color: #005182'><b>", Category, "<b></span>"),
                                      as.character(Category)))

    plot_ly(plot_data,
             x = ~Value,
             y = ~Category,
             type = "bar",
             marker = list(color = ~custom_colors[color]),
             orientation = 'h',
             text = ~paste0(Category,": ",Label),
             textposition = "none",
             hoverinfo = 'text') %>%
      layout(legend = list(orientation = "h", x = -2, y = 1.2),
             xaxis = list(title = "", tickformat = ','),
             yaxis = list(title = "",
                          tickvals = ~Category,
                          ticktext = ~custom_ticktext,
                          autorange = "reversed"),
             hovermode = 'y') %>%
      plotly_custom_layout()

  })

  # plot 1.6----
  ## Figure 1.9: Fastest-growing industries by per cent growth in small businesses with employees
  output$plot1.6 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "1.09" & nchar(Variable) > 4) %>%
      select(Category, Value, Category2) %>%
      mutate(Value = as.numeric(Value))

    ## Add in Non-Standard Sectors dummy row
    plot_data <- bind_rows(
      prep_data %>% filter(Category2 == "Industry") %>% mutate(color = "navy") %>%  arrange(desc(Value)),
      data.frame(Category = "Non-Standard Sectors", Value = 0),
      prep_data %>% filter(Category2 == "Non-Standard Sectors") %>% mutate(color = "dark_blue") %>%  arrange(desc(Value))
    )  %>%
      mutate(Label = ifelse(Category %in% c("Non-Standard Sectors"), "", percent(Value, accuracy = 0.1)),
             Category = fct_inorder(Category),
             custom_ticktext = ifelse(Category %in% c("Non-Standard Sectors"),
                                      paste0("<span style='color: #005182'><b>", Category, "<b></span>"),
                                      as.character(Category)))
    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            type = "bar",
            marker = list(color = ~custom_colors[color]),
            orientation = 'h',
            text = ~paste0(Category,": ",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(legend = list(orientation = "h", x = -2, y = 1.2),
             xaxis = list(title = "", tickformat = '0%'),
             yaxis = list(title = "",
                          tickvals = ~Category,
                          ticktext = ~custom_ticktext,
                          autorange = "reversed"),
             hovermode = 'y') %>%
      plotly_custom_layout()

  })

  # plot1.7----
  ## Figure 1.10: Small businesses per 1,000 people by province
  output$plot1.7 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "1.10") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(Label = comma(Value),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
           x = ~ Category,
           y = ~ Value,
           type = "bar",
           marker = list(color = ~selected_color),
           text = ~paste0(Category,": ", Label),
           textposition = "none",
           hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = ","),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.55,
        y = 0.85,
        text = paste("<b>— Canadian Total:", canada_average,"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot1.8----
  ## Figure 1.11: Small business growth by province
  output$plot1.8 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "1.11") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.09,
        y = 0.63,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  ## Figure 1.12: Small business and population distribution by region in British Columbia

    plot_data <- data_geo %>%
      left_join(data_new %>% filter(Topic_id == "1.12"),
                by = c("region" = "Category")) %>%
      mutate(Value = as.numeric(Value),
             Variable = case_when(
               str_detect(Variable, "population") ~ "pop",
               str_detect(Variable, "businesses") ~ "sb"),
             region = str_replace_all(region, "/ ", "/"),
             region = str_replace_all(region, " - ", "-")) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(label = paste0(region_label, "\n", percent(sb, accuracy = 0.1), " SB\n", percent(pop, accuracy = 0.1)," population"),
             region = factor(region,
                             levels = c("North Coast & Nechako", "Cariboo", "Kootenay",
                                        "Vancouver Island/Coast", "Mainland/Southwest",
                                        "Thompson-Okanagan", "Northeast")),
             text_color = case_when(region %in%  c("Vancouver Island/Coast", "Mainland/Southwest", "North Coast & Nechako") ~ "black",
                                    TRUE ~ "white")) %>%
      arrange(region)


    ggplot(data = plot_data) +
      geom_sf(aes(fill = region), color = "white", linewidth = 0.5) +
      geom_sf_text(aes(label = label, color = text_color),
                   size = 4, lineheight = 0.8, fontface = "bold",
                   ##northcoast, vi, mainland, cariboo, kootenay, t-o, northeast
                   nudge_x = c(120000,-280000,150000,-90000,0,-10000,20000),
                   nudge_y = c(-190000,-120000,-180000,-100000,-50000,20000,0)
      ) +
      scale_fill_manual(values = region_colors) +
      scale_color_manual(values = c(white = "white", black = "black")) +
      theme_void() +
      theme(legend.position = "none",
            text = element_text(face = "bold"))

  })



  # plot1.10----
  ## Figure 1.13: Small businesses per 1,000 people by region in British Columbia
  output$plot1.10 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.13" & !str_detect(Category, "Total")) %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Category,
            type = "bar",
            orientation = "h",
            text = ~paste0(Category,": ", Label),
            colors = region_colors,
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(showlegend = FALSE,
             title = "",
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0,"),
             barmode = "relative") %>%
      plotly_custom_layout()

  })


  # plot1.11a----
  ## Figure 1.14: Number of small businesses by region
  output$plot1.11a <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.14") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Category,
            type = "bar",
            orientation = "h",
            text = ~paste0(Category,": ", Label),
            colors = region_colors,
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(showlegend = FALSE,
             title = "",
             yaxis = list(title = "", autorange = "reversed"),
             xaxis = list(title = "Number of Businesses", tickformat = "0,"),
             barmode = "relative") %>%
      plotly_custom_layout()

  })

  # plot1.11b----
  ## Figure 1.15: Net change in number of small businesses by region
  output$plot1.11b <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "1.15") %>%
      filter(str_detect(Variable, "Net change")) %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Category,
            type = "bar",
            orientation = "h",
            text = ~paste0(Category,": ", Label),
            colors = region_colors,
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(showlegend = FALSE,
             title = "",
             yaxis = list(title = "", autorange = "reversed"),
             xaxis = list(title = "Net Change of Businesses", tickformat = "0,"),
             barmode = "relative") %>%
      plotly_custom_layout()

  })

  #datatable2.0----
  ## Figure 2.1: Private sector employment in British Columbia by size of business
  output$datatable2 <- renderDT({

    table_data <- bind_rows(
      data_new %>%   ## latest annual data
        filter(Topic_id == "2.01", nchar(Variable) == 4) %>%
        filter(Variable == max(Variable)) %>%
        select(Category, Variable, Value),
      data_new %>%   ## comparison data
        filter(Topic_id == "2.01", nchar(Variable) > 4) %>%
        select(Category, Variable, Value)
      ) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for mixed type columns
      mutate_at(c(3,4), ~ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x), accuracy = 1))) %>%
      mutate_at(c(6,8), ~ifelse(str_detect(.x, "^-$"), .x, percent(as.numeric(.x), accuracy = 0.1))) %>%
      mutate_at(c(2,5,7), ~ifelse(str_detect(.x, "<"), .x, comma(as.numeric(.x)))) %>%
      suppressWarnings()

    # create a custom table header
    h_1 <- names(table_data)[5] %>% str_replace(" \\(", "\\\r\\\n\\(") %>% str_replace("\\) [:alpha:]*", "\\)")
    h_2 <- names(table_data)[7] %>% str_replace(" \\(", "\\\r\\\n\\(") %>% str_replace("\\) [:alpha:]*", "\\)")
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
    datatable(table_data,
              container = heading2,
              rownames = FALSE,
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                scrollX = TRUE,
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
                  "}"),
                ## column widths
                columnDefs = list(list(width = '300px', targets = 0),
                                  list(width = '75px', targets = 3))))  %>%
      ## helper functions for formatting
      formatStyle(1:8, backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2,5,7), textAlign = "right") %>%
      formatStyle(c(3,4,6,8),textAlign = "center") %>%
      formatStyle(columns = 1:8,
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = nrow(table_data), "#c4d6e7"),
                  color = styleRow(rows = nrow(table_data), "#015082"),
                  fontWeight = styleRow(rows = nrow(table_data), "bold")) %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(2,3), "30px"))
  })

  # plot2.1 ----
  ## Figure 2.2 Share of total employment in British Columbia
  output$plot2.1 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "2.02") %>%
      mutate(Value = as.numeric(Value))

    total <- prep_data %>%
      filter(Category == "Total") %>%
      filter(Variable == max(Variable)) %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Variable == "Share") %>%
      arrange(desc(Value)) %>%
      mutate(Label = percent(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~ Value,
            y = ~ Category,
            color = ~Category,
            colors = size_colors,
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(showlegend = FALSE,
             xaxis = list(title = "Share of Total Employment", tickformat = "0%"),
             yaxis = list(title = "", autorange = "reversed")) %>% ## add line
      add_annotations( ## add requested additional info on chart
        x = 0,
        y = 0.99,
        text = paste("<b>Total Employment =", comma(total),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F) %>%
      plotly_custom_layout()

  })

  # plot2.3 ----
  ## Figure 2.3: Share of employment by establishment size
  output$plot2.3 <- renderPlotly({

    ## pull total employement from 2.02
    total <- data_new %>%
      filter(Topic_id == "2.02" & Category == "Total") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value)) %>%
      pull(Value)

    plot_data <- data_new %>%
      filter(Topic_id == "2.03" & str_detect(Variable, "Per cent")) %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~ Value,
            y = ~ Category,
            color = ~Category,
            colors = size_colors,
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(showlegend = FALSE,
             xaxis = list(title = "Share of Total Employment", tickformat = "0%"),
             yaxis = list(title = "", autorange = "reversed")) %>% ## add line
      add_annotations( ## add requested additional info on chart
        x = 0,
        y = 0.99,
        text = paste("<b>Total Employment =", comma(total),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F) %>%
      plotly_custom_layout()

  })

  # plot2.4b----
  ## Figure 2.4: Year-over-year growth in private sector employment
  output$plot2.4b <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "2.04" & Category2 == "Net Growth" & !str_detect(Category, "Total")) %>%
      filter(Variable > as.numeric(max(Variable))-14) %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value),
             Category = fct_inorder(Category))

    custom_colors1 <- custom_colors[c("dark_blue", "med_blue", "yellow")] %>% unname()

    plot_ly(plot_data,
            y = ~Value,
            x = ~Variable,
            color = ~Category,
            colors = custom_colors1,
            type = "bar",
            orientation = "v",
            text = ~paste(Category,":",Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(x = 0, y = 1, traceorder = "reversed"),
             yaxis = list(title = "Number of Jobs"),
             xaxis = list(title = ""),
             barmode = "relative",
             hovermode = "x unified",
             ## to show all label regardless of length
             hoverlabel = list(namelength = -1)) %>%
      plotly_custom_layout()

  })

  # plot2.5a----
  ##Figure 2.5: One-year small business employment change, by province
  output$plot2.5a <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "2.05") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "% Gowth",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0,
        y = 0.59,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot2.5b----
  ## Figure 2.6: Five-year small business employment change by province
  output$plot2.5b <- renderPlotly({

    prep_data <- data_new %>%
    filter(Topic_id == "2.06") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "% Growth",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0,
        y = 0.59,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })



  # plot2.6----
  ## Figure 2.7: Small business as a per cent of private sector employment by province
  output$plot2.6 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "2.07") %>%
      mutate(Value = as.numeric(Value)/100)

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0,
        y = 0.95,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot2.7a----
  ## Figure 2.8: One-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.7a <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "2.08") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(Label = ifelse(`Net growth` > 0,
                            paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, +", comma(`Net growth`), " businesses"),
                            paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, ", comma(`Net growth`), " businesses")),
             Category = fct_inorder(Category),
             selected_color = ifelse(str_detect(Category2, "Top"), custom_colors["yellow"], custom_colors["navy"]))

    plot_ly(plot_data,
            x = ~`Per cent growth`,
            y = ~Category,
            color = ~Category2,
            colors = custom_colors[c("navy", "yellow")] %>% unname(),
            type = "bar",
            text = ~Label,
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
             xaxis = list(title = "One-year growth rate in small business employment", tickformat = "0%"),
             yaxis = list(title = "", autorange = "reversed")) %>%
      plotly_custom_layout()

  })

  # plot2.7b----
  ## Figure 2.9: Two-year top and bottom industries for small business employment growth in British Columbia
  output$plot2.7b <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "2.09") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(Label = ifelse(`Net growth` > 0,
                            paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, +", comma(`Net growth`), " businesses"),
                            paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, ", comma(`Net growth`), " businesses")),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~`Per cent growth`,
            y = ~Category,
            color = ~Category2,
            colors = custom_colors[c("navy", "yellow")] %>% unname(),
            type = "bar",
            text = ~Label,
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
             xaxis = list(title = "Two-year growth rate in small business employment", tickformat = "0%"),
             yaxis = list(title = "", autorange = "reversed")) %>%
      plotly_custom_layout()


  })

  # plot2.7c----
  output$plot2.7c <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "2.10") %>%
      mutate(Value = as.numeric(Value)) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(Label = ifelse(`Number of businesses` > 0,
                            paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, +", comma(`Number of businesses`), " businesses"),
                            paste0(percent(`Per cent growth`, accuracy = 0.1), " growth, ", comma(`Number of businesses`), " businesses")),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~`Per cent growth`,
            y = ~Category,
            color = ~Category2,
            colors = custom_colors[c("navy", "yellow")] %>% unname(),
            type = "bar",
            text = ~Label,
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
             xaxis = list(title = "Five-year growth rate in small business employment", tickformat = "0%"),
             yaxis = list(title = "", autorange = "reversed")) %>%
      plotly_custom_layout()

  })

  # plot3.01----
  ## Figure 3.1: Self-employment as a per cent of total employment by province
  output$plot3.01 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "3.01") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.55,
        y = 0.85,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })




  # plot3.02----
  ## Figure 3.2: Self-employment per cent change by province
  output$plot3.02 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "3.02") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.75,
        y = 0.5,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot3.03a----
  ## Figure 3.3a: One-year self-employment per cent change for regions in British Columbia
  output$plot3.03a <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "3.03") %>%
      filter(Variable == "1 year Per cent") %>%
      mutate(Value = as.numeric(Value))

    provincial_average <- prep_data %>%
      filter(Category == "Provincial total") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Provincial total") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Value,
            y = ~ Category,
            color = ~Category,
            colors = region_colors,
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(showlegend = FALSE,
             xaxis = list(title = "", tickformat = "0%"),
             yaxis = list(title = "", autorange = "reversed"),
             shapes = list(vline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.25,
        y = .99,
        text = paste("<b>— Provincial Average =", percent(provincial_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })


  # plot3.03b----
  ## Figure 3.3b: five-year self-employment per cent change for regions in British Columbia
  output$plot3.03b <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "3.03") %>%
      filter(Variable == "5-year Per cent") %>%
      mutate(Value = as.numeric(Value))

    provincial_average <- prep_data %>%
      filter(Category == "Provincial total") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Provincial total") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Value,
            y = ~ Category,
            color = ~Category,
            colors = region_colors,
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(showlegend = FALSE,
             xaxis = list(title = "", tickformat = "0%"),
             yaxis = list(title = "", autorange = "reversed"),
             shapes = list(vline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.45,
        y = .99,
        text = paste("<b>— Provincial Average =", percent(provincial_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot3.1a----
  ## Figure 3.4: Number of self-employed persons with and without paid help in British Columbia
  output$plot3.1a <- renderPlotly({


    plot_data <- data_new %>%
      filter(Topic_id == "3.04" & str_detect(Variable, "paid help") & !str_detect(Category, "Total")) %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value))

    plot_ly(plot_data,
            x = ~Variable,
            y = ~Value,
            color = ~Category,
            colors = custom_colors[c("yellow", "navy")] %>% unname(),
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0,"),
             barmode = "relative",
             hovermode = 'x unified') %>%
      plotly_custom_layout()

  })

  # plot3.1b----
  ## Figure 3.5: Number of self-employed persons in British Columbia by incorporation status
  output$plot3.1b <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.05" & str_detect(Variable, "paid help") & !str_detect(Category, "Total")) %>%
      mutate(Value = as.numeric(Value),
             Label = comma(Value))

    plot_ly(plot_data,
            x = ~Category,
            y = ~Value,
            color = ~Variable,
            colors = custom_colors[c("yellow", "navy")] %>% unname(),
            type = "bar",
            text = ~paste0(Variable,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "reversed"),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0,"),
             barmode = "relative",
             hovermode = 'x unified') %>%
      plotly_custom_layout()

  })

  # plot3.2----
  ## Figure 3.6: Number of self-employed with paid help compared to self-employed without paid help, British Columbia
  output$plot3.2 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.06") %>%
      mutate(Value = as.numeric(Value)*1000,
             Label = comma(Value))

    plot_ly(plot_data,
            x = ~Category,
            y = ~Value,
            color = ~Variable,
            colors = custom_colors[c("yellow", "navy")] %>% unname(),
            type = "bar",
            text = ~paste0(Variable,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0,"),
             barmode = "group",
             hovermode = 'x unified') %>%
      plotly_custom_layout()

  })

  # plot3.3 ----
  ## Figure 3.7: Age distribution of self-employed workers compared to employees, British Columbia
  output$plot3.3 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.07") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(abs(Value), accuracy = 0.1),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
            type = "bar",
            orientation = "h",
            text = ~paste(Variable,":",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0.5, y = 1.2, traceorder = "reversed"),
             yaxis = list(title = ""),
             xaxis = list(title = "", tickformat = "0%"),
             barmode = "relative") %>%
      plotly_custom_layout()

})

  # plot3.3b----
  ## Figure 3.8: Share of British Columbian workers who are self-employed, by age
  output$plot3.3b <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.08" & Category != "Total") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(abs(Value), accuracy = 0.1),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Variable,
            y = ~Value,
            color = ~Category,
            colors = custom_colors %>% unname(),
            type = "scatter",
            mode = "lines",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             yaxis = list(title = "", tickformat = "0%"),
             xaxis = list(title = ""),
             hovermode = 'x unified') %>%
      plotly_custom_layout()

  })

  # plot3.4----
  ## Figure 3.10: Proportion of self-employed who are women by province
  output$plot3.4 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "3.10") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Cda") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Cda") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.15,
        y = 0.9,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot3.5 ----
  ## Figure 3.11: Proportion of self-employed who are women, by region
  output$plot3.5 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.11") %>%
      filter(Variable == max(Variable) | Variable == as.numeric(max(Variable))-5) %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category))

      plot_ly(plot_data,
              x = ~Value,
              y = ~Category,
              color = ~Variable,
              colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
              type = "bar",
              orientation = "h",
              text = ~paste0(Variable,": ", Label),
              textposition = "none",
              hovertemplate = "%{text}<extra></extra>") %>%
        layout(title = "",
               legend = list(orientation = "h", x = 0, y = 1.2),
               yaxis = list(title = "", autorange = "reversed"),
               xaxis = list(title = "", tickformat = "0%"),
               hovermode = 'y unified') %>%
        plotly_custom_layout()

  })

  # plot3.6----
  ## Figure 3.13: Per cent of working, off-reserve Indigenous and non-Indigenous people who are self-employed in British Columbia
  output$plot3.6 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.13" & Category != "Difference") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Variable,
            y = ~Value,
            color = ~Category,
            colors = custom_colors %>% unname(),
            type = "bar",
            orientation = "v",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = "% Self-employed", tickformat = "0%"),
             xaxis = list(title = ""),
             hovermode = "x unified") %>%
      plotly_custom_layout()

  })

  # plot3.7a----
  ## Figure 3.9: Hours worked, self-employed compared to employees
  output$plot3.7a <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.09" & !str_detect(Category, "main")) %>%
      mutate(Value = as.numeric(Value),
             Label = percent(abs(Value), accuracy = 0.1),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
            type = "bar",
            orientation = "h",
            text = ~paste(Variable,":",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0.5, y = 1.2, traceorder = "reversed"),
             yaxis = list(title = "", autorange = "reversed"),
             xaxis = list(title = "", tickformat = "0%"),
             barmode = "relative") %>%
      plotly_custom_layout()

  })

  # plot3.7b----
  ## Figure 3.12: Hours worked among self-employed men and women, British Columbia
  output$plot3.7b <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "3.12" & !str_detect(Category, "main")) %>%
      mutate(Value = as.numeric(Value),
             Label = percent(abs(Value), accuracy = 0.1),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
            type = "bar",
            orientation = "h",
            text = ~paste(Variable,":",Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0.5, y = 1.2, traceorder = "normal"),
             yaxis = list(title = "", autorange = "reversed"),
             xaxis = list(title = "", tickformat = "0%"),
             barmode = "relative") %>%
      plotly_custom_layout()

  })

  # plot4.1 ----
  ## Figure 4.1: Small business contribution to GDP by province
  output$plot4.1 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "4.01") %>%
      filter(Variable == max(Variable)) %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "Canada") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "Canada") %>%
      mutate(Label = percent(Value, accuracy = 1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.2,
        y = 0.9,
        text = paste("<b>— Canadian Average:", percent(canada_average), "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot4.2 ----
  ## Figure 4.2: Changes in average annual earnings in British Columbia
  output$plot4.2 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "4.02" & !str_detect(Category, "Per cent")) %>%
      mutate(Value = as.numeric(Value))

    wage_gap <- prep_data %>%
      filter(str_detect(Variable, "(G|g)ap")) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      mutate(year = str_extract(Category, "[:digit:]{4}"),
             amount = dollar(`Small business wage gap`),
             percent = percent(`Gap in per cent`, accuracy = 0.1),
             text = paste0("<b>Wage gap ", year, " = ", amount, " (", percent, ")</b>")) %>%
      pull(text)

    plot_data <- prep_data %>%
      filter(Topic_id == "4.02" & !str_detect(Variable, "(G|g)ap")) %>%
      mutate(Value = as.numeric(Value),
             Label = dollar(Value),
             Category = str_extract(Category, "Earnings [:digit:]{4}"),
             Variable = fct_inorder(Variable))

    plot_ly(plot_data,
            x = ~Category,
            y = ~Value,
            color = ~Variable,
            colors = custom_colors %>% unname(),
            type = "bar",
            orientation = "v",
            text = ~paste0(Variable,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = "Thousands",tickformat = "$,"),
             xaxis = list(title = "Payroll/Employee"),
             hovermode = "x unified"
             ) %>%
      add_annotations(
        x = 0.01,
        y = 0.79,
        text = wage_gap[1],
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F) %>%
      add_annotations(
        x = 0.5,
        y = 0.99,
        text = wage_gap[2],
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
        ) %>% plotly_custom_layout()
    })

  # plot4.3 ----
  ## Figure 4.3: Small business average annual earnings and wage gap by industry
  output$plot4.3 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "4.03" & !str_detect(Variable, "(G|g)ap")) %>%
      mutate(Value = as.numeric(Value),
             Label = dollar(Value),
             Variable = fct_inorder(Variable),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
            type = "bar",
            orientation = 'h',
            text = ~paste0(Variable, ": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
             xaxis = list(title = "", tickformat = '$,'),
             yaxis = list(title = "", autorange = "reversed"),
             hovermode="y unified") %>%
      plotly_custom_layout()

  })

  # plot4.4 ----
  ## Figure 4.4: Small business wage gaps by industry, British Columbia
  output$plot4.4 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "4.04" & !str_detect(Variable, "Dollar")) %>%
      mutate(Value = as.numeric(Value),
             Label = dollar(Value, accuracy = 1),
             Variable = str_extract(Variable, "[:digit:]{4}"),
             Category = fct_inorder(Category))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
            type = "bar",
            orientation = 'h',
            text = ~paste0(Variable, ": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
             xaxis = list(title = "", tickformat = '$,'),
             yaxis = list(title = "", autorange = "reversed"),
             hovermode="y unified") %>%
      plotly_custom_layout()

  })

  # plot4.5 ----
  ## Figure 4.5: Average annual earnings by province
  output$plot4.5 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "4.05") %>%
      mutate(Value = as.numeric(Value),
             Label = dollar(Value, accuracy = 1)) %>%
      arrange(desc(Variable), desc(Value)) %>%
      mutate(Category = fct_inorder(Category),
             Variable = fct_inorder(Variable))

    plot_ly(plot_data,
            x = ~Value,
            y = ~Category,
            color = ~Variable,
            colors = custom_colors[c("med_blue", "dark_blue")] %>% unname(),
            type = "bar",
            orientation = 'h',
            text = ~paste0(Variable, ": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(legend = list(orientation = "h", x = 0, y = 1.2, traceorder = "normal"),
             xaxis = list(title = "", tickformat = '$,'),
             yaxis = list(title = "", autorange = "reversed"),
             hovermode="y unified") %>%
      plotly_custom_layout()

  })

  # plot4.6 ----
  ## Figure 4.6: Small business share of total payroll by province
  output$plot4.6 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "4.06") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CDA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CDA") %>%
      mutate(Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "",  tickformat = "0%"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.2,
        y = 0.89,
        text = paste("<b>— Canadian Average:", percent(canada_average, accuracy = 0.1),"</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  #datatable5.1a ----
  ## Figure 5.1: Number of British Columbia exporters and value of exports, British Columbia
  ## part1: Values
  output$datatable5.1a <- renderDT({

    prep_data <- data_new %>%
      filter(Topic_id == "5.01", str_detect(Category2, "Values")) %>%
      select(Category2, `Number of businesses` = Category, Variable, Value) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for columns
      mutate_at(c(3:8), ~comma(as.numeric(.x))) %>%
      mutate_at(c(9:10), ~percent(as.numeric(.x), accuracy = 0.1))

    ## add in second heading row
    heading_two <- data.frame(t(c("","Value of exports ($millions)", names(prep_data)[3:10])))
    colnames(heading_two) <- colnames(prep_data)

    table_data <- bind_rows(
      prep_data %>% filter(Category2 == "Number of businesses - Values"),
      heading_two,
      prep_data %>% filter(Category2 == "Value of exports ($millions) - Values")
    )

    # Create the datatable
    datatable(table_data[-1],
              rownames = FALSE,
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                scrollX = TRUE,  ordering = FALSE, paging = FALSE, dom = 't',
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
      formatStyle(2:7, textAlign = "center") %>%
      formatStyle(8:9, textAlign = "center") %>%
      formatStyle(columns = 1:ncol(table_data),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(3,7), "#c4d6e7"),
                  color = styleRow(rows = c(3,7), "#015082"),
                  fontWeight = styleRow(rows = c(3,7), "bold"))
  })

  #datatable5.1b ----
  ## Figure 5.1: Number of British Columbia exporters and value of exports, British Columbia
  ## part2: Percentages
  output$datatable5.1b <- renderDT({

    prep_data <- data_new %>%
      filter(Topic_id == "5.01", str_detect(Category2, "Percentages")) %>%
      select(Category2, `Number of businesses` = Category, Variable, Value) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for columns
      mutate_at(c(3:8), ~percent(as.numeric(.x), accuracy = 0.1))

    ## add in second heading row
    heading_two <- data.frame(t(c("","Value of exports", names(prep_data)[3:8])))
    colnames(heading_two) <- colnames(prep_data)

    table_data <- bind_rows(
      prep_data %>% filter(Category2 == "Number of businesses - Percentages"),
      heading_two,
      prep_data %>% filter(Category2 == "Value of exports ($millions) - Percentages")
    )

    # Create the datatable
    datatable(table_data[-1],
              rownames = FALSE,
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                scrollX = TRUE,  ordering = FALSE, paging = FALSE, dom = 't',
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
      formatStyle(2:7, textAlign = "center") %>%
      formatStyle(8:9, textAlign = "center") %>%
      formatStyle(columns = 1:ncol(table_data),
                  ## use styleRow to select which rows to apply style
                  backgroundColor = styleRow(rows = c(3,7), "#c4d6e7"),
                  color = styleRow(rows = c(3,7), "#015082"),
                  fontWeight = styleRow(rows = c(3,7), "bold"))

  })

  #datatable5.2 ----
  ## Figure 5.2: Growth in small business exporters and exports by province and territory
  output$datatable5.2 <- renderDT({

    prep_data <- bind_rows(
      data_new %>%   ## latest annual data
        filter(Topic_id == "5.02", nchar(Variable) == 4) %>%
        filter(Variable == max(Variable)) %>%
        select(Category2, Category, Variable, Value),
      data_new %>%   ## comparison data
        filter(Topic_id == "5.02", nchar(Variable) > 4) %>%
        select(Category2, Category, Variable, Value)
    ) %>%
      pivot_wider(names_from = "Variable", values_from = "Value") %>%
      ## pre-formatting for columns
      mutate_at(c(3), ~comma(as.numeric(.x), accuracy = 1)) %>%
      mutate_at(c(4:5), ~percent(as.numeric(.x), accuracy = 0.1))

    heading_two <- names(prep_data)[3:5]

    table_data <- prep_data %>%
      pivot_wider(names_from = "Category2", values_from = all_of(heading_two),
                  names_glue = "{Category2}_{.value}",
                  names_vary = "slowest") ## this specification sorts columns correctly

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
          lapply(c("", rep(heading_two, 2)), th)
        )
      )
    ))

    ## create a datatable
    datatable(table_data,
              container = heading2,
              rownames = FALSE,
              ## change default class (table-striped) to cell-border (borders around all cells, no striping)
              class = 'cell-border',
              options = list(
                scrollX = TRUE,
                paging = FALSE,
                dom = 't',
                ## format header
                headerCallback = JS(
                  "function(thead, data, start, end, display){",
                  "  $('th', thead).css('color', 'white');",
                  "  $('th', thead).css('background-color', '#0e83b0');",
                  "  $('th','tr', thead).addClass('tab5');",
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
                columnDefs = list(list(width = '180px', targets = 0))))  %>%
      ## can use any css style in formatStyle by replacing "-" with camel case (e.g., text-align -- textAlign)
      formatStyle(1:7, backgroundColor = "#e6edf4", borderColor = "white") %>%
      formatStyle(c(2,5), textAlign = "right") %>%
      formatStyle(c(3,4,6,7),textAlign = "center") %>%
      formatStyle(columns = 1, paddingLeft = styleRow(rows = c(8:11), "30px"))

  })


  # plot5.3 ----
  ## Figure 5.3: Share of business exporters by destination of exports
  output$plot5.3 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "5.03") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             Category2 = fct_inorder(Category2))

    plot_ly(plot_data,
            x = ~Category2,
            y = ~Value,
            color = ~Category,
            colors = custom_colors[c("dark_blue","med_blue","green")] %>% unname(),
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = "", tickformat = "0%"),
             xaxis = list(title = ""),
             hovermode = 'x unified'
             ) %>%
      plotly_custom_layout()

  })

  # plot5.4 ----
  ## Figure 5.4: Share of export value by destination of exports
  output$plot5.4 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "5.04" & Variable == "Share of export value") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             Category2 = fct_inorder(Category2))

    plot_ly(plot_data,
            x = ~Category2,
            y = ~Value,
            color = ~Category,
            colors = custom_colors[c("dark_blue","med_blue","green")] %>% unname(),
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = "", tickformat = "0%"),
             xaxis = list(title = ""),
             hovermode = 'x unified'
      ) %>%
      plotly_custom_layout()

  })

  # plot5.5 ----
  ## Figure 5.5: Destination share of value of small business exports by province
  output$plot5.5 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "5.05" & Category2 == "Share of exports") %>%
      mutate(Value = as.numeric(Value),
             Label = percent(Value, accuracy = 0.1),
             Category = fct_rev(Category),
             Variable = fct_inorder(Variable))

    plot_ly(plot_data,
            x = ~Variable,
            y = ~Value,
            color = ~Category,
            colors = custom_colors[c("dark_blue","med_blue","green")] %>% unname(),
            type = "bar",
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             legend = list(orientation = "h", x = 0, y = 1.2),
             yaxis = list(title = "% of Total", tickformat = "0%"),
             xaxis = list(title = ""),
             barmode = "relative",
             hovermode = 'x unified'
      ) %>%
      plotly_custom_layout()

  })

  # plot5.6 ----
  ## Figure 5.6: Export intensity for small businesses by province
  output$plot5.6 <- renderPlotly({

    prep_data <- data_new %>%
      filter(Topic_id == "5.06" & Variable == "Exports intensity") %>%
      mutate(Value = as.numeric(Value))

    canada_average <- prep_data %>%
      filter(Category == "CA") %>%
      pull(Value)

    plot_data <- prep_data %>%
      filter(Category != "CA") %>%
      mutate(Label = dollar(Value, accuracy = 0.1),
             Category = fct_inorder(Category),
             selected_color = ifelse(Category == "BC", custom_colors["yellow"], custom_colors["med_blue"]))

    plot_ly(plot_data,
            x = ~ Category,
            y = ~ Value,
            type = "bar",
            marker = list(color = ~selected_color),
            text = ~paste0(Category,": ", Label),
            textposition = "none",
            hoverinfo = 'text') %>%
      layout(xaxis = list(title = "", tickformat = ""),
             yaxis = list(title = "$ Millions per business",  tickformat = "$"),
             shapes = list(hline(canada_average))) %>% ## add line
      add_annotations( ## add canadian average text
        x = 0.6,
        y = 0.27,
        text = paste("<b>— Canada:", dollar(canada_average, accuracy = 0.1),"million</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F
      ) %>% plotly_custom_layout()

  })

  # plot5.7 ----
  ## Figure 5.7: Value of goods exports for large and small businesses
  output$plot5.7 <- renderPlotly({

    plot_data <- data_new %>%
      filter(Topic_id == "5.07") %>%
      mutate(Value = as.numeric(Value)/1e6,
             Label = dollar(Value, accuracy = 0.1)
             )

    plot_ly(plot_data,
            x = ~Variable,
            y = ~Value,
            color = ~Category,
            colors = custom_colors[c("dark_blue", "med_blue")] %>% unname(),
            type = "scatter",
            mode = "lines",
            stackgroup = "one",
            text = ~paste0(Category,": ", Label, " billion"),
            hovertemplate = "%{text}<extra></extra>") %>%
      layout(title = "",
             xaxis = list(title = ""),
             yaxis = list(title = "$ Billions", tickformat = "$"),
             barmode = "stack",
             hovermode = "x unified",
             showlegend = TRUE,
             legend = list(orientation = "h", x = 0, y = 1.3)) %>%
      plotly_custom_layout()

  })

}

# Run the app
shinyApp(ui, server)
