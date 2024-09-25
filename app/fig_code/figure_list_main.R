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


figure_list_main <- list(
  fig1.01 = box(  ## fig1.01 ----
    title = figs[figs$Topic_id == "1.01", ]$fig_text,
    width = 10,
    style = "border: 1px solid white;",
    fig_notes["fig1.01_desc"],
    DTOutput("datatable1.01"),
    br(),
    fig_notes["fig1.01_note"],
    actionButton("btn1.01", actionbtn_text)
    ),
  fig1.02 = box(  ## fig1.02 ----
    title = figs[figs$Topic_id == "1.02", ]$fig_text,
    width = 10,
    fig_notes["fig1.02_desc"],
    plotlyOutput("plot1.02"),
    br(),
    fig_notes["fig1.02_note"],
    actionButton("btn1.02", actionbtn_text)
  ),
  fig1.03 = box(  ## fig1.03 ----
    title = figs[figs$Topic_id == "1.03", ]$fig_text,
    width = 10,
    fig_notes["fig1.03_desc"],
    plotlyOutput("plot1.03"),
    br(),
    fig_notes["fig1.03_note"],
    actionButton("btn1.03", actionbtn_text)
  ),
  fig1.04 = box(  ## fig1.04 ----
    title = figs[figs$Topic_id == "1.04", ]$fig_text,
    width = 10,
    solidHeader = TRUE,
    tabsetPanel(
      tabPanel("1 year",
               style = "width: 4",
               fig_notes["fig1.04a_desc"],
               plotlyOutput("plot1.04a")),
      tabPanel("2 year",
               fig_notes["fig1.04b_desc"],
               plotlyOutput("plot1.04b")),
      tabPanel("5 year",
               fig_notes["fig1.04c_desc"],
               plotlyOutput("plot1.04c"))),
    br(),
    fig_notes["fig1.04_note"],
    actionButton("btn1.04", actionbtn_text)
  ),
  fig1.05 = box(  ## fig1.05 ----
    title = figs[figs$Topic_id == "1.05", ]$fig_text,
    width = 10,
    fig_notes["fig1.05_desc"],
    plotlyOutput("plot1.05"),
    br(),
    fig_notes["fig1.05_note"],
    actionButton("btn1.05", actionbtn_text)
  ),
  fig1.06 = box(  ## fig1.06 ----
    title = figs[figs$Topic_id == "1.06", ]$fig_text,
    width = 10,
    fig_notes["fig1.06_desc"],
    plotlyOutput("plot1.06"),
    br(),
    fig_notes["fig1.06_note"],
    actionButton("btn1.06", actionbtn_text)
  ),
  fig1.07 = box(  ## fig1.07 ----
    title = figs[figs$Topic_id == "1.07", ]$fig_text,
    width = 10,
    fig_notes["fig1.07_desc"],
    plotlyOutput("plot1.07"),
    br(),
    fig_notes["fig1.07_note"],
    actionButton("btn1.07", actionbtn_text)
  ),
  fig1.08 = box(  ## fig1.08 ----
    title = figs[figs$Topic_id == "1.08", ]$fig_text,
    width = 10,
    fig_notes["fig1.08_desc"],
    plotlyOutput("plot1.08"),
    br(),
    fig_notes["fig1.08_note"],
    actionButton("btn1.08", actionbtn_text)
  ),
  fig1.09 = box(  ## fig1.09 ----
    title = figs[figs$Topic_id == "1.09", ]$fig_text,
    width = 10,
    fig_notes["fig1.09_desc"],
    plotlyOutput("plot1.09"),
    br(),
    fig_notes["fig1.09_note"],
    actionButton("btn1.09", actionbtn_text)
  ),
  fig1.10 = box(  ## fig1.10 ----
    title = figs[figs$Topic_id == "1.10", ]$fig_text,
    width = 10,
    fig_notes["fig1.10_desc"],
    plotlyOutput("plot1.10"),
    br(),
    fig_notes["fig1.10_note"],
    actionButton("btn1.10", actionbtn_text)
  ),
  fig1.11 = box(  ## fig1.11 ----
    title = figs[figs$Topic_id == "1.11", ]$fig_text,
    width = 10,
    fig_notes["fig1.11_desc"],
    plotlyOutput("plot1.11"),
    br(),
    fig_notes["fig1.11_note"],
    actionButton("btn1.11", actionbtn_text)
  ),
  fig1.12 = box(  ## fig1.12 ----
    title = figs[figs$Topic_id == "1.12", ]$fig_text,
    width = 10,
    fig_notes["fig1.12_desc"],
    plotOutput("plot1.12"),
    br(),
    fig_notes["fig1.12_note"],
    actionButton("btn1.12", actionbtn_text)
  ),
  fig1.13 = box(  ## fig1.13 ----
    title = figs[figs$Topic_id == "1.13", ]$fig_text,
    width = 10,
    fig_notes["fig1.13_desc"],
    plotlyOutput("plot1.13"),
    br(),
    fig_notes["fig1.13_note"],
    actionButton("btn1.13", actionbtn_text)
  ),
  fig1.14 = box(  ## fig1.14 ----
    title = figs[figs$Topic_id == "1.14", ]$fig_text,
    width = 10,
    fig_notes["fig1.14_desc"],
    plotlyOutput("plot1.14"),
    br(),
    fig_notes["fig1.14_note"],
    actionButton("btn1.14", actionbtn_text)
  ),
  fig1.15 = box(  ## fig1.15 ----
    title = figs[figs$Topic_id == "1.15", ]$fig_text,
    width = 10,
    fig_notes["fig1.15_desc"],
    plotlyOutput("plot1.15"),
    br(),
    fig_notes["fig1.15_note"],
    actionButton("btn1.15", actionbtn_text)
  ),
  fig2.01 = box(  ## fig2.01 ----
    title = figs[figs$Topic_id == "2.01", ]$fig_text,
    width = 10,
    style = "border: 1px solid white;",
    fig_notes["fig2.01_desc"],
    DTOutput("datatable2.01"),
    br(),
    fig_notes["fig2.01_note"],
    actionButton("btn2.01", actionbtn_text)
  ),
  fig2.02 = box(  ## fig2.02 ----
    title = figs[figs$Topic_id == "2.02", ]$fig_text,
    width = 10,
    fig_notes["fig2.02_desc"],
    plotlyOutput("plot2.02"),
    br(),
    fig_notes["fig2.02_note"],
    actionButton("btn2.02", actionbtn_text)
  ),
  fig2.03 = box(  ## fig2.03 ----
    title = figs[figs$Topic_id == "2.03", ]$fig_text,
    width = 10,
    fig_notes["fig2.03_desc"],
    plotlyOutput("plot2.03"),
    br(),
    fig_notes["fig2.03_note"],
    actionButton("btn2.03", actionbtn_text)
  ),
  fig2.04 = box(  ## fig2.04 ----
    title = figs[figs$Topic_id == "2.04", ]$fig_text,
    width = 10,
    fig_notes["fig2.04_desc"],
    plotlyOutput("plot2.04"),
    br(),
    fig_notes["fig2.04_note"],
    actionButton("btn2.04", actionbtn_text)
  ),
  fig2.05 = box(  ## fig2.05 ----
    title = figs[figs$Topic_id == "2.05", ]$fig_text,
    width = 10,
    fig_notes["fig2.05_desc"],
    plotlyOutput("plot2.05"),
    br(),
    fig_notes["fig2.05_note"],
    actionButton("btn2.05", actionbtn_text)
  ),
  fig2.06 = box(  ## fig2.06 ----
    title = figs[figs$Topic_id == "2.06", ]$fig_text,
    width = 10,
    fig_notes["fig2.06_desc"],
    plotlyOutput("plot2.06"),
    br(),
    fig_notes["fig2.06_note"],
    actionButton("btn2.06", actionbtn_text)
  ),
  fig2.07 = box(  ## fig2.07 ----
    title = figs[figs$Topic_id == "2.07", ]$fig_text,
    width = 10,
    fig_notes["fig2.07_desc"],
    plotlyOutput("plot2.07"),
    br(),
    fig_notes["fig2.07_note"],
    actionButton("btn2.07", actionbtn_text)
  ),
  fig2.08 = box(  ## fig2.08 ----
    title = figs[figs$Topic_id == "2.08", ]$fig_text,
    width = 10,
    fig_notes["fig2.08_desc"],
    plotlyOutput("plot2.08"),
    br(),
    fig_notes["fig2.08_note"],
    actionButton("btn2.08", actionbtn_text)
  ),
  fig2.09 = box(  ## fig2.09 ----
    title = figs[figs$Topic_id == "2.09", ]$fig_text,
    width = 10,
    fig_notes["fig2.09_desc"],
    plotlyOutput("plot2.09"),
    br(),
    fig_notes["fig2.09_note"],
    actionButton("btn2.09", actionbtn_text)
  ),
  fig2.10 = box(
    title = figs[figs$Topic_id == "2.10", ]$fig_text,
    width = 10,
    fig_notes["fig2.10_desc"],
    plotlyOutput("plot2.10"),
    br(),
    fig_notes["fig2.10_note"],
    actionButton("btn2.10", actionbtn_text)
  ),
  fig3.01 = box(  ## fig3.01 ----
    title = figs[figs$Topic_id == "3.01", ]$fig_text,
    width = 10,
    fig_notes["fig3.01_desc"],
    plotlyOutput("plot3.01"),
    br(),
    fig_notes["fig3.01_note"],
    actionButton("btn3.01", actionbtn_text)
  ),
  fig3.02 = box(  ## fig3.02 ----
    title = figs[figs$Topic_id == "3.02", ]$fig_text,
    width = 10,
    fig_notes["fig3.02_desc"],
    plotlyOutput("plot3.02"),
    br(),
    fig_notes["fig3.02_note"],
    actionButton("btn3.02", actionbtn_text)
  ),
  fig3.03 = box(
    title = figs[figs$Topic_id == "3.03", ]$fig_text,
    width = 10,solidHeader = TRUE,
    tabsetPanel(
      tabPanel("One-year",
               style = "width: 4",
               fig_notes["fig3.03a_desc"],
               plotlyOutput("plot3.03a"),),
      tabPanel("Five-year",
               fig_notes["fig3.03b_desc"],
               plotlyOutput("plot3.03b"))),
    br(),
    fig_notes["fig3.03_note"],
                actionButton("btn3.03", actionbtn_text)
  ),
  fig3.04 = box(  ## fig3.04 ----
    title = figs[figs$Topic_id == "3.04", ]$fig_text,
    width = 10,
    fig_notes["fig3.04_desc"],
    plotlyOutput("plot3.04"),
    br(),
    fig_notes["fig3.04_note"],
    actionButton("btn3.04", actionbtn_text)
  ),
  fig3.05 = box(  ## fig3.05 ----
    title = figs[figs$Topic_id == "3.05", ]$fig_text,
    width = 10,
    fig_notes["fig3.05_desc"],
    plotlyOutput("plot3.05"),
    br(),
    fig_notes["fig3.05_note"],
                actionButton("btn3.05", actionbtn_text)
  ),
  fig3.06 = box(  ## fig3.06 ----
    title = figs[figs$Topic_id == "3.06", ]$fig_text,
    width = 10,
    fig_notes["fig3.06_desc"],
    plotlyOutput("plot3.06"),
    br(),
    fig_notes["fig3.06_note"],
    actionButton("btn3.06", actionbtn_text)
  ),
  fig3.07 = box(  ## fig3.07 ----
    title = figs[figs$Topic_id == "3.07", ]$fig_text,
    width = 10,
    fig_notes["fig3.07_desc"],
    plotlyOutput("plot3.07"),
    br(),
    fig_notes["fig3.07_note"],
    actionButton("btn3.07", actionbtn_text)
  ),
  fig3.08 = box(  ## fig3.08 ----
    title = figs[figs$Topic_id == "3.08", ]$fig_text,
    width = 10,
    fig_notes["fig3.08_desc"],
    plotlyOutput("plot3.08"),
    br(),
    fig_notes["fig3.08_note"],
    actionButton("btn3.08", actionbtn_text)
  ),
  fig3.09 = box(  ## fig3.09 ----
    title = figs[figs$Topic_id == "3.09", ]$fig_text,
    width = 10,
    fig_notes["fig3.09_desc"],
    plotlyOutput("plot3.09"),
    br(),
    fig_notes["fig3.09_note"],
    actionButton("btn3.09", actionbtn_text)
  ),
  fig3.10 = box(
    title = figs[figs$Topic_id == "3.10", ]$fig_text,
    width = 10,
    fig_notes["fig3.10_desc"],
    plotlyOutput("plot3.10"),
    br(),
    fig_notes["fig3.10_note"],
    actionButton("btn3.10", actionbtn_text)
  ),
  fig3.11 = box(  ## fig3.11 ----
    title = figs[figs$Topic_id == "3.11", ]$fig_text,
    width = 10,
    fig_notes["fig3.11_desc"],
    plotlyOutput("plot3.11"),
    br(),
    fig_notes["fig3.11_note"],
    actionButton("btn3.11", actionbtn_text)
  ),
  fig3.12 = box(  ## fig3.12 ----
    title = figs[figs$Topic_id == "3.12", ]$fig_text,
    width = 10,
    fig_notes["fig3.12_desc"],
    plotlyOutput("plot3.12"),
    br(),
    fig_notes["fig3.12_note"],
    actionButton("btn3.12", actionbtn_text)
  ),
  fig3.13 = box(  ## fig3.13 ----
    title = figs[figs$Topic_id == "3.13", ]$fig_text,
    width = 10,
    fig_notes["fig3.13_desc"],
    plotlyOutput("plot3.13"),
    br(),
    fig_notes["fig3.13_note"],
    actionButton("btn3.13", actionbtn_text)
  ),
  fig4.01 = box(  ## fig4.01 ----
    title = figs[figs$Topic_id == "4.01", ]$fig_text,
    width = 10,
    fig_notes["fig4.01_desc"],
    plotlyOutput("plot4.01"),
    br(),
    fig_notes["fig4.01_note"],
    actionButton("btn4.01", actionbtn_text)
  ),
  fig4.02 = box(  ## fig4.02 ----
    title = figs[figs$Topic_id == "4.02", ]$fig_text,
    width = 10,
    fig_notes["fig4.02_desc"],
    plotlyOutput("plot4.02"),
    br(),
    fig_notes["fig4.02_note"],
    actionButton("btn4.02", actionbtn_text)
  ),
  fig4.03 = box(  ## fig4.03 ----
    title = figs[figs$Topic_id == "4.03", ]$fig_text,
    width = 10,
    fig_notes["fig4.03_desc"],
    plotlyOutput("plot4.03"),
    br(),
    fig_notes["fig4.03_note"],
    actionButton("btn4.03", actionbtn_text)
  ),
  fig4.04 = box(  ## fig4.04 ----
    title = figs[figs$Topic_id == "4.04", ]$fig_text,
    width = 10,
    fig_notes["fig4.04_desc"],
    plotlyOutput("plot4.04"),
    br(),
    fig_notes["fig4.04_note"],
    actionButton("btn4.04", actionbtn_text)
  ),
  fig4.05 = box(  ## fig4.05 ----
    title = figs[figs$Topic_id == "4.05", ]$fig_text,
    width = 10,
    fig_notes["fig4.05_desc"],
    plotlyOutput("plot4.05"),
    br(),
    fig_notes["fig4.05_note"],
    actionButton("btn4.05", actionbtn_text)
  ),
  fig4.06 = box(  ## fig4.06 ----
    title = figs[figs$Topic_id == "4.06", ]$fig_text,
    width = 10,
    fig_notes["fig4.06_desc"],
    plotlyOutput("plot4.06"),
    br(),
    fig_notes["fig4.06_note"],
    actionButton("btn4.06", actionbtn_text)
  ),
  fig5.01 = box(
    title = figs[figs$Topic_id == "5.01", ]$fig_text,
    width = 10,
    solidHeader = TRUE,
    tabsetPanel(
      tabPanel("Values",
               style = "width: 4",
               fig_notes["fig5.01a_desc"],
               DTOutput("datatable5.01a")),
      tabPanel("Percentages",
               fig_notes["fig5.01b_desc"],
               DTOutput("datatable5.01b"))),
    br(),
    fig_notes["fig5.01_note"],
    actionButton("btn5.01", actionbtn_text)
  ),
  fig5.02 = box(  ## fig5.02 ----
    title = figs[figs$Topic_id == "5.02", ]$fig_text,
    width = 10,
    style = "border: 1px solid white;",
    fig_notes["fig5.02_desc"],
    DTOutput("datatable5.02"),
    br(),
    fig_notes["fig5.02_note"],
    actionButton("btn5.02", actionbtn_text)
  ),
  fig5.03 = box(  ## fig5.03 ----
    title = figs[figs$Topic_id == "5.03", ]$fig_text,
    width = 10,
    fig_notes["fig5.03_desc"],
    plotlyOutput("plot5.03"),
    br(),
    fig_notes["fig5.03_note"],
    actionButton("btn5.03", actionbtn_text)
  ),
  fig5.04 = box(  ## fig5.04 ----
    title = figs[figs$Topic_id == "5.04", ]$fig_text,
    width = 10,
    fig_notes["fig5.04_desc"],
    plotlyOutput("plot5.04"),
    br(),
    fig_notes["fig5.04_note"],
    actionButton("btn5.04", actionbtn_text)
  ),
  fig5.05 = box(  ## fig5.05 ----
    title = figs[figs$Topic_id == "5.05", ]$fig_text,
    width = 10,
    fig_notes["fig5.05_desc"],
    plotlyOutput("plot5.05"),
    br(),
    fig_notes["fig5.05_note"],
    actionButton("btn5.05", actionbtn_text)
  ),
  fig5.06 = box(  ## fig5.06 ----
    title = figs[figs$Topic_id == "5.06", ]$fig_text,
    width = 10,
    fig_notes["fig5.06_desc"],
    plotlyOutput("plot5.06"),
    br(),
    fig_notes["fig5.06_note"],
    actionButton("btn5.06", actionbtn_text)
  ),
  fig5.07 = box(  ## fig5.07 ----
    title = figs[figs$Topic_id == "5.07", ]$fig_text,
    width = 10,
    fig_notes["fig5.07_desc"],
    plotlyOutput("plot5.07"),
    br(),
    fig_notes["fig5.07_note"],
    actionButton("btn5.07", actionbtn_text)
  ),
  fig6.01 = box(  ## fig6.01 ----
    title = figs[figs$Topic_id == "6.01", ]$fig_text,
    width = 10,
    fig_notes["fig6.01_desc"],
    plotlyOutput("plot6.01"),
    br(),
    fig_notes["fig6.01_note"],
    actionButton("btn6.01", actionbtn_text)
  ),
  fig6.02 = box(  ## fig6.02 ----
    title = figs[figs$Topic_id == "6.02", ]$fig_text,
    width = 10,
    fig_notes["fig6.02_desc"],
    plotlyOutput("plot6.02"),
    br(),
    fig_notes["fig6.02_note"],
    actionButton("btn6.02", actionbtn_text)
  ),
  fig6.03 = box(  ## fig6.03 ----
    title = figs[figs$Topic_id == "6.03", ]$fig_text,
    width = 10,
    fig_notes["fig6.03_desc"],
    plotlyOutput("plot6.03"),
    br(),
    fig_notes["fig6.03_note"],
    actionButton("btn6.03", actionbtn_text)
  )
)




