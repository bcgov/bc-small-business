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

fig_list_standalone <- list(

  ## fig1.01 ----
  fig1.01 = box(
    title = figs[figs$Topic_id == "1.01", ]$fig_text,
    width = 10,
    style = "border: 1px solid white;",
    fig_notes["fig1.01_desc"],
    DTOutput("datatable1.01_s"),
    br(),
    fig_notes["fig1.01_note"]
  ),
  ## fig1.02 ----
  fig1.02 = box(
    title = figs[figs$Topic_id == "1.02", ]$fig_text,
    width = 10,
    fig_notes["fig1.02_desc"],
    plotlyOutput("plot1.02_s"),
    br(),
    fig_notes["fig1.02_note"]
  ),
  ## fig1.03 ----
  fig1.03 = box(
    title = figs[figs$Topic_id == "1.03", ]$fig_text,
    width = 10,
    fig_notes["fig1.03_desc"],
    plotlyOutput("plot1.03_s"),
    br(),
    fig_notes["fig1.03_note"]
  ),
  ## fig1.04 ----
  fig1.04 = box(
    title = figs[figs$Topic_id == "1.04", ]$fig_text,
    width = 10,
    solidHeader = TRUE,
    tabsetPanel(
      tabPanel("1 year",
               style = "width: 4",
               fig_notes["fig1.04a_desc"],
               plotlyOutput("plot1.04a_s")),
      tabPanel("2 year",
               fig_notes["fig1.04b_desc"],
               plotlyOutput("plot1.04b_s")),
      tabPanel("5 year",
               fig_notes["fig1.04c_desc"],
               plotlyOutput("plot1.04c_s"))),
    br(),
    fig_notes["fig1.04_note"]
  ),
  ## fig1.05 ----
  fig1.05 = box(
    title = figs[figs$Topic_id == "1.05", ]$fig_text,
    width = 10,
    fig_notes["fig1.05_desc"],
    plotlyOutput("plot1.05_s"),
    br(),
    fig_notes["fig1.05_note"]
  ),
  ## fig1.06 ----
  fig1.06 = box(
    title = figs[figs$Topic_id == "1.06", ]$fig_text,
    width = 10,
    fig_notes["fig1.06_desc"],
    plotlyOutput("plot1.06_s"),
    br(),
    fig_notes["fig1.06_note"]
  ),
  ## fig1.07 ----
  fig1.07 = box(
    title = figs[figs$Topic_id == "1.07", ]$fig_text,
    width = 10,
    fig_notes["fig1.07_desc"],
    plotlyOutput("plot1.07_s"),
    br(),
    fig_notes["fig1.07_note"]
  ),
  ## fig1.08 ----
  fig1.08 = box(
    title = figs[figs$Topic_id == "1.08", ]$fig_text,
    width = 10,
    fig_notes["fig1.08_desc"],
    plotlyOutput("plot1.08_s"),
    br(),
    fig_notes["fig1.08_note"]
  ),
  ## fig1.09 ----
  fig1.09 = box(
    title = figs[figs$Topic_id == "1.09", ]$fig_text,
    width = 10,
    fig_notes["fig1.09_desc"],
    plotlyOutput("plot1.09_s"),
    br(),
    fig_notes["fig1.09_note"]
  ),
  ## fig1.10 ----
  fig1.1 = box(
    title = figs[figs$Topic_id == "1.10", ]$fig_text,
    width = 10,
    fig_notes["fig1.10_desc"],
    plotlyOutput("plot1.10_s"),
    br(),
    fig_notes["fig1.10_note"]
  ),
  ## fig1.11 ----
  fig1.11 = box(
    title = figs[figs$Topic_id == "1.11", ]$fig_text,
    width = 10,
    fig_notes["fig1.11_desc"],
    plotlyOutput("plot1.11_s"),
    br(),
    fig_notes["fig1.11_note"]
  ),
  ## fig1.12 ----
  fig1.12 = box(
    title = figs[figs$Topic_id == "1.12", ]$fig_text,
    width = 10,
    fig_notes["fig1.12_desc"],
    plotOutput("plot1.12_s"),
    br(),
    fig_notes["fig1.12_note"]
  ),
  ## fig1.13 ----
  fig1.13 = box(
    title = figs[figs$Topic_id == "1.13", ]$fig_text,
    width = 10,
    fig_notes["fig1.13_desc"],
    plotlyOutput("plot1.13_s"),
    br(),
    fig_notes["fig1.13_note"]
  ),
  ## fig1.14 ----
  fig1.14 = box(
    title = figs[figs$Topic_id == "1.14", ]$fig_text,
    width = 10,
    fig_notes["fig1.14_desc"],
    plotlyOutput("plot1.14_s"),
    br(),
    fig_notes["fig1.14_note"]
  ),
  ## fig1.15 ----
  fig1.15 = box(
    title = figs[figs$Topic_id == "1.15", ]$fig_text,
    width = 10,
    fig_notes["fig1.15_desc"],
    plotlyOutput("plot1.15_s"),
    br(),
    fig_notes["fig1.15_note"]
  ),
  ## fig2.01 ----
  fig2.01 = box(
    title = figs[figs$Topic_id == "2.01", ]$fig_text,
    width = 10,
    style = "border: 1px solid white;",
    fig_notes["fig2.01_desc"],
    DTOutput("datatable2.01_s"),
    br(),
    fig_notes["fig2.01_note"]
  ),
  ## fig2.02 ----
  fig2.02 = box(
    title = figs[figs$Topic_id == "2.02", ]$fig_text,
    width = 10,
    fig_notes["fig2.02_desc"],
    plotlyOutput("plot2.02_s"),
    br(),
    fig_notes["fig2.02_note"]
  ),
  ## fig2.03 ----
  fig2.03 = box(
    title = figs[figs$Topic_id == "2.03", ]$fig_text,
    width = 10,
    fig_notes["fig2.03_desc"],
    plotlyOutput("plot2.03_s"),
    br(),
    fig_notes["fig2.03_note"]
  ),
  ## fig2.04 ----
  fig2.04 = box(
    title = figs[figs$Topic_id == "2.04", ]$fig_text,
    width = 10,
    fig_notes["fig2.04_desc"],
    plotlyOutput("plot2.04_s"),
    br(),
    fig_notes["fig2.04_note"]
  ),
  ## fig2.05 ----
  fig2.05 = box(
    title = figs[figs$Topic_id == "2.05", ]$fig_text,
    width = 10,
    fig_notes["fig2.05_desc"],
    plotlyOutput("plot2.05_s"),
    br(),
    fig_notes["fig2.05_note"]
  ),
  ## fig2.06 ----
  fig2.06 = box(
    title = figs[figs$Topic_id == "2.06", ]$fig_text,
    width = 10,
    fig_notes["fig2.06_desc"],
    plotlyOutput("plot2.06_s"),
    br(),
    fig_notes["fig2.06_note"]
  ),
  ## fig2.07 ----
  fig2.07 = box(
    title = figs[figs$Topic_id == "2.07", ]$fig_text,
    width = 10,
    fig_notes["fig2.07_desc"],
    plotlyOutput("plot2.07_s"),
    br(),
    fig_notes["fig2.07_note"]
  ),
  ## fig2.08 ----
  fig2.08 = box(
    title = figs[figs$Topic_id == "2.08", ]$fig_text,
    width = 10,
    fig_notes["fig2.08_desc"],
    plotlyOutput("plot2.08_s"),
    br(),
    fig_notes["fig2.08_note"]
  ),
  ## fig2.09 ----
  fig2.09 = box(
    title = figs[figs$Topic_id == "2.09", ]$fig_text,
    width = 10,
    fig_notes["fig2.09_desc"],
    plotlyOutput("plot2.09_s"),
    br(),
    fig_notes["fig2.09_note"]
  ),
  ## fig2.10 ----
  fig2.10 = box(
    title = figs[figs$Topic_id == "2.10", ]$fig_text,
    width = 10,
    fig_notes["fig2.10_desc"],
    plotlyOutput("plot2.10_s"),
    br(),
    fig_notes["fig2.10_note"]
  ),
  ## fig3.01 ----
  fig3.01 = box(
    title = figs[figs$Topic_id == "3.01", ]$fig_text,
    width = 10,
    fig_notes["fig3.01_desc"],
    plotlyOutput("plot3.01_s"),
    br(),
    fig_notes["fig3.01_note"]
  ),
  ## fig3.02 ----
  fig3.02 = box(
    title = figs[figs$Topic_id == "3.02", ]$fig_text,
    width = 10,
    fig_notes["fig3.02_desc"],
    plotlyOutput("plot3.02_s"),
    br(),
    fig_notes["fig3.02_note"]
  ),
  ## fig3.03 ----
  fig3.03 = box(
    title = figs[figs$Topic_id == "3.03", ]$fig_text,
    width = 10,solidHeader = TRUE,
    tabsetPanel(
      tabPanel("One-year",
               style = "width: 4",
               fig_notes["fig3.03a_desc"],
               plotlyOutput("plot3.03a_s"),),
      tabPanel("Five-year",
               fig_notes["fig3.03b_desc"],
               plotlyOutput("plot3.03b_s"))),
    br(),
    fig_notes["fig3.03_note"]
  ),
  ## fig3.04 ----
  fig3.04 = box(
    title = figs[figs$Topic_id == "3.04", ]$fig_text,
    width = 10,
    fig_notes["fig3.04_desc"],
    plotlyOutput("plot3.04_s"),
    br(),
    fig_notes["fig3.04_note"]
  ),
  ## fig3.05 ----
  fig3.05 = box(
    title = figs[figs$Topic_id == "3.05", ]$fig_text,
    width = 10,
    fig_notes["fig3.05_desc"],
    plotlyOutput("plot3.05_s"),
    br(),
    fig_notes["fig3.05_note"]
  ),
  ## fig3.06 ----
  fig3.06 = box(
    title = figs[figs$Topic_id == "3.06", ]$fig_text,
    width = 10,
    fig_notes["fig3.06_desc"],
    plotlyOutput("plot3.06_s"),
    br(),
    fig_notes["fig3.06_note"]
  ),
  ## fig3.07 ----
  fig3.07 = box(
    title = figs[figs$Topic_id == "3.07", ]$fig_text,
    width = 10,
    fig_notes["fig3.07_desc"],
    plotlyOutput("plot3.07_s"),
    br(),
    fig_notes["fig3.07_note"]
  ),
  ## fig3.08 ----
  fig3.08 = box(
    title = figs[figs$Topic_id == "3.08", ]$fig_text,
    width = 10,
    fig_notes["fig3.08_desc"],
    plotlyOutput("plot3.08_s"),
    br(),
    fig_notes["fig3.08_note"]
  ),
  ## fig3.09 ----
  fig3.09 = box(
    title = figs[figs$Topic_id == "3.09", ]$fig_text,
    width = 10,
    fig_notes["fig3.09_desc"],
    plotlyOutput("plot3.09_s"),
    br(),
    fig_notes["fig3.09_note"]
  ),
  ## fig3.10 ----
  fig3.10 = box(
    title = figs[figs$Topic_id == "3.10", ]$fig_text,
    width = 10,
    fig_notes["fig3.10_desc"],
    plotlyOutput("plot3.10_s"),
    br(),
    fig_notes["fig3.10_note"]
  ),
  ## fig3.11 ----
  fig3.11 = box(
    title = figs[figs$Topic_id == "3.11", ]$fig_text,
    width = 10,
    fig_notes["fig3.11_desc"],
    plotlyOutput("plot3.11_s"),
    br(),
    fig_notes["fig3.11_note"]
  ),
  ## fig3.12 ----
  fig3.12 = box(
    title = figs[figs$Topic_id == "3.12", ]$fig_text,
    width = 10,
    fig_notes["fig3.12_desc"],
    plotlyOutput("plot3.12_s"),
    br(),
    fig_notes["fig3.12_note"]
  ),
  ## fig3.13 ----
  fig3.13 = box(
    title = figs[figs$Topic_id == "3.13", ]$fig_text,
    width = 10,
    fig_notes["fig3.13_desc"],
    plotlyOutput("plot3.13_s"),
    br(),
    fig_notes["fig3.13_note"]
  ),
  ## fig4.01 ----
  fig4.01 = box(
    title = figs[figs$Topic_id == "4.01", ]$fig_text,
    width = 10,
    fig_notes["fig4.01_desc"],
    plotlyOutput("plot4.01_s"),
    br(),
    fig_notes["fig4.01_note"]
  ),
  ## fig4.02 ----
  fig4.02 = box(
    title = figs[figs$Topic_id == "4.02", ]$fig_text,
    width = 10,
    fig_notes["fig4.02_desc"],
    plotlyOutput("plot4.02_s"),
    br(),
    fig_notes["fig4.02_note"]
  ),
  ## fig4.03 ----
  fig4.03 = box(
    title = figs[figs$Topic_id == "4.03", ]$fig_text,
    width = 10,
    fig_notes["fig4.03_desc"],
    plotlyOutput("plot4.03_s"),
    br(),
    fig_notes["fig4.03_note"]
  ),
  ## fig4.04 ----
  fig4.04 = box(
    title = figs[figs$Topic_id == "4.04", ]$fig_text,
    width = 10,
    fig_notes["fig4.04_desc"],
    plotlyOutput("plot4.04_s"),
    br(),
    fig_notes["fig4.04_note"]
  ),
  ## fig4.05 ----
  fig4.05 = box(
    title = figs[figs$Topic_id == "4.05", ]$fig_text,
    width = 10,
    fig_notes["fig4.05_desc"],
    plotlyOutput("plot4.05_s"),
    br(),
    fig_notes["fig4.05_note"]
  ),
  ## fig4.06 ----
  fig4.06 = box(
    title = figs[figs$Topic_id == "4.06", ]$fig_text,
    width = 10,
    fig_notes["fig4.06_desc"],
    plotlyOutput("plot4.06_s"),
    br(),
    fig_notes["fig4.06_note"]
  ),
  ## fig5.01 ----
  fig5.01 = box(
    title = figs[figs$Topic_id == "5.01", ]$fig_text,
    width = 10,
    solidHeader = TRUE,
    tabsetPanel(
      tabPanel("Values",
               style = "width: 4",
               fig_notes["fig5.01a_desc"],
               DTOutput("datatable5.01a_s")),
      tabPanel("Percentages",
               fig_notes["fig5.01b_desc"],
               DTOutput("datatable5.01b_s"))),
    br(),
    fig_notes["fig5.01_note"]
  ),
  ## fig5.02 ----
  fig5.02 = box(
    title = figs[figs$Topic_id == "5.02", ]$fig_text,
    width = 10,
    style = "border: 1px solid white;",
    fig_notes["fig5.02_desc"],
    DTOutput("datatable5.02_s"),
    br(),
    fig_notes["fig5.02_note"]
  ),
  ## fig5.03 ----
  fig5.03 = box(
    title = figs[figs$Topic_id == "5.03", ]$fig_text,
    width = 10,
    fig_notes["fig5.03_desc"],
    plotlyOutput("plot5.03_s"),
    br(),
    fig_notes["fig5.03_note"]
  ),
  ## fig5.04 ----
  fig5.04 = box(
    title = figs[figs$Topic_id == "5.04", ]$fig_text,
    width = 10,
    fig_notes["fig5.04_desc"],
    plotlyOutput("plot5.04_s"),
    br(),
    fig_notes["fig5.04_note"]
  ),
  ## fig5.05 ----
  fig5.05 = box(
    title = figs[figs$Topic_id == "5.05", ]$fig_text,
    width = 10,
    fig_notes["fig5.05_desc"],
    plotlyOutput("plot5.05_s"),
    br(),
    fig_notes["fig5.05_note"]
  ),
  ## fig5.06 ----
  fig5.06 = box(
    title = figs[figs$Topic_id == "5.06", ]$fig_text,
    width = 10,
    fig_notes["fig5.06_desc"],
    plotlyOutput("plot5.06_s"),
    br(),
    fig_notes["fig5.06_note"]
  ),
  ## fig5.07 ----
  fig5.07 = box(
    title = figs[figs$Topic_id == "5.07", ]$fig_text,
    width = 10,
    fig_notes["fig5.07_desc"],
    plotlyOutput("plot5.07_s"),
    br(),
    fig_notes["fig5.07_note"]
  ),
  ## fig6.01 ----
  fig6.01 = box(
    title = figs[figs$Topic_id == "6.01", ]$fig_text,
    width = 10,
    fig_notes["fig6.01_desc"],
    plotlyOutput("plot6.01_s"),
    br(),
    fig_notes["fig6.01_note"]
  ),
  ## fig6.02 ----
  fig6.02 = box(
    title = figs[figs$Topic_id == "6.02", ]$fig_text,
    width = 10,
    fig_notes["fig6.02_desc"],
    plotlyOutput("plot6.02_s"),
    br(),
    fig_notes["fig6.02_note"]
  ),
  ## fig6.03 ----
  fig6.03 = box(
    title = figs[figs$Topic_id == "6.03", ]$fig_text,
    width = 10,
    fig_notes["fig6.03_desc"],
    plotlyOutput("plot6.03_s"),
    br(),
    fig_notes["fig6.03_note"]
  )
)

