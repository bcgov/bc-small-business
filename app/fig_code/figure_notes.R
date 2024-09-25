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


fig_notes <- list(
  fig1.01_desc = HTML("<small><p><i>This table provides a breakdown of the number of businesses in British Columbia by employment size.</i></p></small>"),
  fig1.01_note = tagList(HTML("<small><p><b>Note:</b> Figures do not add to 100 per cent due to rounding.</p>
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>In B.C., a <b><i>small business</i></b> is defined as one with fewer than 50 employees,
                                 or a business operated by a person who is self-employed, without paid help.
                                 Businesses with 50 or more employees are considered large businesses.</p>
                                 <p><b><i>Micro-businesses</i></b> are those with fewer than five employees,
                                 including self-employed individuals without staff and businesses with 1-4 employees.<p></small>")))),

  fig1.02_desc = HTML("<small><p><i>This chart shows the number of small businesses broken out by how many people they employ.</i></p></small>"),
  fig1.02_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig1.03_desc = HTML("<small><p><i>This chart shows the relative proportion of businesses that are small with employees, small without employees and large.</i></p></small>"),
  fig1.03_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>In B.C., a <b><i>small business</i></b> is defined as one with fewer than 50 employees,
                                 or a business operated by a person who is self-employed, without paid help.
                                 Businesses with 50 or more employees are considered large businesses.</p></small>")))),

  fig1.04a_desc = HTML("<small><p><i>This chart shows the one-year growth of businesses in British Columbia by employee size. </i></p></small>"),
  fig1.04b_desc = HTML("<small><p><i>This chart shows the two-year growth of businesses in British Columbia by employee size. </i></p></small>"),
  fig1.04c_desc = HTML("<small><p><i>This chart shows the five-year growth of businesses in British Columbia by employee size.</i></p></small>"),
  fig1.04_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig1.05_desc = HTML("<small><p><i>This chart shows the relative proportion of small businesses in different industries in British Columbia.</i></p></small>"),
  fig1.05_note = tagList(HTML("<small><p><b>Note:</b> Natural Resources* is comprised of the agriculture, forestry, fishing, mining, oil and gas industries.</p>
                                   <p><b>Note:</b> Utilities comprises <0.1 per cent of small businesses.</p>
                                   <p><b>Note:</b> The total does not sum to 100 per cent as some businesses with employees could not be classified by industry.</p>
                                   <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>Industries in this chart are grouped using the North American Industry Classification System (NAICS).
                                   NAICS is a classification system used in Canada, the United States and Mexico,
                                   which is designed to provide common definitions of the industrial structure of the three countries.
                                   NAICS is Statistics Canada’s comprehensive system encompassing all economic activities.</p></small>")))),

  fig1.06_desc = HTML("<small><p><i>This chart shows the relative proportion of small businesses in different industries in
                       British Columbia for businesses with and without employees.</i></p></small>"),
  fig1.06_note = tagList(HTML("<small><p><b>Note:</b> Natural Resources is comprised of the agriculture, forestry, fishing, mining, oil and gas industries.</p>
                                   <p><b>Note:</b> Self-employment in utilities (small businesses with no paid employees)
                                                   is less than 1,500 and is suppressed for confidentiality reasons.</p>
                                   <p><b>Note:</b> The total does not sum to 100 per cent as some businesses could not be classified by industry.</p>
                                   <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>Industries in this chart are grouped using the North American Industry Classification System (NAICS).
                                   NAICS is a classification system used in Canada, the United States and Mexico,
                                   which is designed to provide common definitions of the industrial structure of the three countries.
                                   NAICS is Statistics Canada’s comprehensive system encompassing all economic activities.</p></small>")))),

  fig1.07_desc = HTML("<small><p><i>This chart shows the proportion of small businesses with and without employees within each industry in British Columbia.</i></p></small>"),
  fig1.07_note = tagList(HTML("<small><p><b>Note:</b> Natural Resources is comprised of the agriculture, forestry, fishing, mining, oil and gas industries.</p>
                                      <p><b>Note:</b> Utilities is not shown because the number of small businesses with employees is <200 and self-employment
                                                      without paid help is very small and suppressed for confidentiality reasons.</p>
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>Industries in this chart are grouped using the North American Industry Classification System (NAICS).
                                   NAICS is a classification system used in Canada, the United States and Mexico,
                                   which is designed to provide common definitions of the industrial structure of the three countries.
                                   NAICS is Statistics Canada’s comprehensive system encompassing all economic activities.</p></small>")))),

  fig1.08_desc = HTML("<small><p><i>This chart shows the five industries with the most net new businesses in the last five years in British Columbia.
                       The number of net new businesses is also shown for non-standard industries.</i></p></small>"),
  fig1.08_note = tagList(HTML("<small><p><b>Note:</b> Excludes self-employed without paid help.</p>
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Tourism</i></b> includes industries such as transportation,
                                   accommodation, food services and other tourism related activities.
                                   Further information on the tourism sector is available at BC Stats.</p>
                                   <p><b><i>High technology</i></b> industries may employ a high proportion of
                                   scientists and researchers or invest a high proportion of revenues in research and development.
                                   Other industries that produce high technology products are also included.
                                   Further information on the high technology sector is available online at BC Stats.</p>
                                   <p><b><i>Secondary manufacturing</i></b> industries are those that produce goods from the products
                                   of other manufacturers. For example, a sawmill is a manufacturing operation,
                                   but not a secondary manufacturer, because its logs do not come from another manufacturer.
                                   On the other hand, a factory producing wooden doors with lumber obtained
                                   from sawmills is a secondary manufacturer.</p></small>")))),

  fig1.09_desc = HTML("<small><p><i>This chart shows the five industries with the highest growth rate in the number of
                       net new businesses in the last five years in British Columbia.
                       Net new business growth rates are also shown for non-standard industries.</i></p></small>"),
  fig1.09_note = tagList(HTML("<small><p><b>Note:</b> Excludes self-employed without paid help.</p>
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Tourism</i></b> includes industries such as transportation,
                                   accommodation, food services and other tourism related activities.
                                   Further information on the tourism sector is available at BC Stats.</p>
                                   <p><b> <i>High technology</i></b> industries may employ a high proportion of
                                   scientists and researchers or invest a high proportion of revenues in research and development.
                                   Other industries that produce high technology products are also included.
                                   Further information on the high technology sector is available online at BC Stats.</p>
                                   <p><b><i>Secondary manufacturing</i></b> industries are those that produce goods from the products
                                   of other manufacturers. For example, a sawmill is a manufacturing operation,
                                   but not a secondary manufacturer, because its logs do not come from another manufacturer.
                                   On the other hand, a factory producing wooden doors with lumber obtained
                                   from sawmills is a secondary manufacturer.</p></small>")))),

  fig1.10_desc = HTML("<small><p><i>This chart shows the number of small businesses per 1,000 people by province.</i></p></small>"),
  fig1.10_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig1.11_desc = HTML("<small><p><i>This chart illustrates the annual change in the number of small business for each province.</i></p></small>"),
  fig1.11_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig1.12_desc = HTML("<small><p><i>This chart provides a detailed view of small business and population distributions around British Columbia.</i></p></small>"),
  fig1.12_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig1.13_desc = HTML("<small><p><i>This chart shows the number of small business per 1,000 people by development region in British Columbia.</i></p></small>"),
  fig1.13_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig1.14_desc = HTML("<small><p><i>This chart shows the number of small businesses by development region in British Columbia.</i></p></small>"),
  fig1.14_note = HTML("<small><p><b>Note:</b> Figures do not add to the total because the provincial total includes some businesses for which the region is unknown.</p>
                              <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig1.15_desc = HTML("<small><p><i>This chart shows the net annual change in the number of small businesses
                       by development region in British Columbia. That is, the difference between the number
                       of small businesses between the latest annual data and the previous year.</i></p></small>"),
  fig1.15_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig2.01_desc = HTML("<small><p><i>This table shows the breakdown of employees in the private sector for small and large businesses.</i></p></small>"),
  fig2.01_note = tagList(HTML("<small><p><b>Note:</b> Includes the self-employed with and without paid help.</p>
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Public sector employees</b></i> are employees in public administration at the federal,
                                 provincial, territorial, municipal, First Nations and other Indigenous governments as well as in
                                 Crown corporations, liquor control boards, and other government institutions such as schools
                                 (including universities), hospitals and public libraries.</p>
                                 <p><b><i>Private sector employees</i></b> includes all employees are those who do not work in a
                                 government institution, or other government controlled business such as Crown corporations,
                                 liquor control boards, public education, hospitals and public libraries.</p></small>")))),

  fig2.02_desc = HTML("<small><p><i>This chart shows the proportion of employees who work in the public sector, small and large businesses.</i></p></small>"),
  fig2.02_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Public sector employees</b></i> are employees in public administration at the federal,
                                   provincial, territorial, municipal, First Nations and other Indigenous governments as well as in
                                   Crown corporations, liquor control boards, and other government institutions such as schools
                                   (including universities), hospitals and public libraries.</p>
                                   <p><b><i>Private sector employees</i></b> includes all employees are those who do not work in a
                                   government institution, or other government controlled business such as Crown corporations,
                                   liquor control boards, public education, hospitals and public libraries.</p></small>")))),

  fig2.03_desc = HTML("<small><p><i>This chart shows the proportion of employees who work in the public sector,
                       small businesses with and without employees, and large businesses.</i></p></small>"),
  fig2.03_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Public sector employees</b></i> are employees in public administration at the federal,
                                   provincial, territorial, municipal, First Nations and other Indigenous governments as well as in
                                   Crown corporations, liquor control boards, and other government institutions such as schools
                                   (including universities), hospitals and public libraries.</p>
                                   <p><b><i>Private sector employees</i></b> includes all employees are those who do not work in a
                                   government institution, or other government controlled business such as Crown corporations,
                                   liquor control boards, public education, hospitals and public libraries.</p></small>")))),

  fig2.04_desc = HTML("<small><p><i>This chart shows the annual growth in the number of people employed in the private sector by business size.</i></p></small>"),
  fig2.04_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig2.05_desc = HTML("<small><p><i>This chart shows the annual rate of growth in small businesses employment by province.</i></p></small>"),
  fig2.05_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig2.06_desc = HTML("<small><p><i>This chart shows the five-year rate of growth in small businesses employment by province.</i></p></small>"),
  fig2.06_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig2.07_desc = HTML("<small><p><i>This chart shows employees in small businesses as a proportion of total private sector employment by province.</i></p></small>"),
  fig2.07_note = HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig2.08_desc = HTML("<small><p><i>This chart shows the five industries with the largest rate of employment growth in the last  year in British Columbia.
                       It also shows the five industries with the lowest rate of employment growth in the last year.</i></p></small>"),
  fig2.08_note = HTML("<small><p><b>Note:</b> Public administration employment here measures small government entities
                                              such as small municipal and Indigenous government organizations.</p>
                              <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig2.09_desc = HTML("<small><p><i>This chart shows the five industries with the largest rate of employment growth in the last two years in British Columbia.
                       It also shows the five industries with the lowest rate of employment growth in the last two years.</i></p></small>"),
  fig2.09_note = HTML("<small><p><b>Note:</b> Public administration employment here measures small government entities such as small municipal
                                              and Indigenous government organizations.</p>
                              <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig2.10_desc = HTML("<small><p><i>This chart shows the five industries with the largest rate of employment growth in the last five years in British Columbia.
                       It also shows the five industries with the lowest rate of employment growth in the last five years.</i></p></small>"),
  fig2.10_note = HTML("<small><p><b>Note:</b> Public administration employment here measures small government entities such as small municipal
                                              and Indigenous government organizations.</p>
                             <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),

  fig3.01_desc = HTML("<small><p><i>This chart shows the different levels of self-employment as a percentage of total employment across
                       the provinces and compared to the Canadian average.</i></p></small>"),
  fig3.01_note = tagList(HTML("<small><p><b>Source:</b> Statistics Canada / Prepared by BC Stats</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Self-employed</b></i> are persons whose job consisted mainly of operating a business,
                                   farm or professional practice, alone or in partnership.</p></small>")))),

  fig3.02_desc = HTML("<small><p><i>This chart shows the growth of self-employment in the last five years by province.</i></p></small>"),
  fig3.02_note = tagList(HTML("<small><p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Self-employed</b></i> are persons whose job consisted mainly of operating a business,
                                   farm or professional practice, alone or in partnership.</p></small>")))),

  fig3.03a_desc = HTML("<small><p><i>This chart shows the growth of self-employment in the last year by development region.</i></p></small>"),
  fig3.03b_desc = HTML("<small><p><i>This chart shows the growth of self-employment in the last five years by development region.</i></p></small>"),
  fig3.03_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Self-employed </b></i>are persons whose job consisted mainly of operating a business,
                                   farm or professional practice, alone or in partnership.</p></small>")))),

  fig3.04_desc = HTML("<small><p><i>This chart shows self-employed persons with and without paid help by incorporation status.</i></p></small>"),
  fig3.04_note = tagList(HTML("<small><p><b>Note:</b> Excludes unpaid family workers</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Incorporated businesses</b></i> consist of those organized and maintained as
                                   legal corporations. A corporation is created (incorporated) by one or more shareholders who have
                                   ownership of the corporation, represented by their holding of common stock.</p>
                                   <p><b><i>Unincorporated businesses</b></i> consist of those not organized and maintained as
                                   legal corporations, and wherein the tie between members need not be a legally enforceable contract.</p></small>")))),

  fig3.05_desc = HTML("<small><p><i>This chart shows self-employed persons by incorporation status with and without paid help.</i></p></small>"),
  fig3.05_note = tagList(HTML("<small><p><b>Note:</b> Excludes unpaid family workers</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Incorporated businesses</b></i> consist of those organized and maintained as
                                   legal corporations. A corporation is created (incorporated) by one or more shareholders who have
                                   ownership of the corporation, represented by their holding of common stock.</p>
                                   <p><b><i>Unincorporated businesses</b></i> consist of those not organized and maintained as
                                   legal corporations, and wherein the tie between members need not be a legally enforceable contract.</p></small>")))),

  fig3.06_desc = HTML("<small><p><i>This chart compares the number of self-employed persons with paid help and those without paid help for selected years.</i></p></small>"),
  fig3.06_note = HTML("<small><p><b>Note:</b> Excludes unpaid family workers</p>
                              <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),

  fig3.07_desc = HTML("<small><p><i>This chart compares the proportion of persons who are self-employed and those who are employed by age.</i></p></small>"),
  fig3.07_note = HTML("<small><p><b>Notes</b>: Figures do not add to 100 per cent due to rounding.</p>
                           <p><b><b>Source:</b></b> Statistics Canada / Prepared by BC Stats</p></small>"),

  fig3.08_desc = HTML("<small><p><i>This chart shows the distribution of persons who are self-employed by age over time.</i></p></small>"),
  fig3.08_note = HTML("<small><p><b>Notes</b>: Figures do not add to 100 per cent due to rounding.</p>
                           <p><b><b>Source:</b></b> Statistics Canada / Prepared by BC Stats</p></small>"),

  fig3.09_desc = HTML("<small><p><i>This chart compares the number of usual hours worked per week for self-employed indivuals and employees.</i></p></small>"),
  fig3.09_note = tagList(HTML("<small><p><b>Note:</b> Figures do not add to 100 per cent due to rounding.</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b>Usual work hours</b> refers to the employed person's normal paid or contract hours,
                                   not counting any overtime.</p></small>")))),

  fig3.10_desc = HTML("<small><p><i>This chart shows shows the proportion of self-employed persons who identify as women by province.</i></p></small>"),
  fig3.10_note = HTML("<small><p><b>Note:</b> Excludes unpaid family workers.</p>
                              <p><b>Source:</b> Statistics Canada / Prepared by BC Stats</p></small>"),

  fig3.11_desc = HTML("<small><p><i>This chart shows the proportion of self-employed persons who identify as women by development region.</i></p></small>"),
  fig3.11_note = HTML("<small><p><b>Note:</b> Includes unpaid family workers.</p>
                              <p><b>Source:</b>  Statistics Canada / Prepared by BC Stats.</p></small>"),

  fig3.12_desc = HTML("<small><p><i>This chart compares the number of usual hours worked per week for self-employed persons by sex.</i></p></small>"),
  fig3.12_note = tagList(HTML("<small><p><b>Note:</b> Figures do not add to 100 per cent due to rounding.</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b>Usual work hours</b> refers to the employed person's normal paid or contract hours,
                                   not counting any overtime.</p></small>")))),

  fig3.13_desc = HTML("<small><p><i>This chart shows persons who are self-employed as a percentage of total employment for
                       off-reserve Indigenous and Non-Indigenous populations.</i></p></small>"),
  fig3.13_note = tagList(HTML("<small><p><b>Note:</b> This data is only available for the off-reserve Indigenous population.</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Indigenous Persons</b></i> are those who indicate that they identify as an
                                   Indigenous person, and/or are registered under the Indian Act, and/or are a member of a
                                   First Nation or Indian band.</p>
                                   <p><b><i>Off reserve</b></i>i ncludes all census subdivisions in Canada not legally affiliated
                                   with First Nations or Indian bands.</p></small>")))),

  fig4.01_desc = HTML("<small><p><i>This chart shows the percentage of GDP that is attributable to small business activities.</i></p></small>"),
  fig4.01_note = tagList(HTML("<small><p><b>Source:</b> BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Gross Domestic Product (GDP)</b></i> refers to the total market value of all the
                                    goods and services produced within national or provincial borders during a specified period.
                                    The growth rates of GDP provide an indication of how well an industry or an economy is doing.</p></small>")))),

  fig4.02_desc = HTML("<small><p><i>This chart shows the average annual earnings for employes of small and large businesses for selected years.</i></p></small>"),
  fig4.02_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Average annual earnings</b></i> refers to the gross taxable payroll of an employee,
                                   expressed on an annual basis, including pay for overtime.</p></small>")))),

  fig4.03_desc = HTML("<small><p><i>This chart shows the average annual earnings for employes of small and large businesses by industry.</i></p></small>"),
  fig4.03_note = tagList(HTML("<small><p><b>Note:</b>The level of small-business employment in the utilities sector is very small,
                                                     less than 3 per cent of total.</p>
                                      <p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Average annual earnings</b></i> refers to the gross taxable payroll of an employee,
                                    expressed on an annual basis, including pay for overtime.</p></small>")))),

  fig4.04_desc = HTML("<small><p><i>This chart shows the difference in the average annual earnings for employes of small and
                       large businesses by industry for selected years.</i></p></small>"),
  fig4.04_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small></p><b><i>Average annual earnings </b></i> refers to the gross taxable payroll of an employee,
                                   expressed on an annual basis, including pay for overtime.</p></small>")))),

  fig4.05_desc = HTML("<small><p><i>This chart illustrates the difference in average annual earnings between small and large businesses by province.</i></p></small>"),
  fig4.05_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definition:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Average annual earnings </b></i> refers to the gross taxable payroll of an employee,
                                   expressed on an annual basis, including pay for overtime.</p></small>")))),

  fig4.06_desc = HTML("<small><p><i>This chart shows the proportion of total provincial payrolls attributable to small businesses.</i></p></small>"),
  fig4.06_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Payroll</b></i> includes regular pay, overtime and bonuses,
                                   commissions and all other types of special payments. The payroll concept excludes dollar
                                   amounts that are taxable allowances and benefits, certain types of non-wage compensation,
                                   as well as employer contributions to employment insurance, Canada and Quebec pension plans,
                                   provincial medical plans, workers’ compensation and other welfare plans.</p></small>")))),

  fig5.01a_desc = HTML("<small><p><i>This table shows the number of exporters and the value of exports in British Columbia by business size for selected years.</i></p></small>"),
  fig5.01b_desc = HTML("<small><p><i>This table shows the number of exporters and the value of exports in British Columbia by business size for selected years,
                        as a proportion of the total.</i></p></small>"),
  fig5.01_note = tagList(HTML("<small><p><b>Source:</b> Statistics Canada/Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>An <b><i>exporter</b></i> is defined as an enterprise that sells goods out of the country,
                                   regardless of the value of exports.</p>
                                   <p><b><i>Value of exports</b></i> is measured in Canadian dollars.
                                   Value is as recorded in official customs documents, typically the actual selling price used for company
                                   accounting purposes. Canadian exports to overseas countries are valued including domestic freight
                                   charges to the port of exit point but excluding discounts and allowances,
                                   and international insurance.</p></small>")))),

  fig5.02_desc = HTML("<small><p><i>This table shows the growth in the number of exporters and the value of exports in
                       British Columbia by business size for selected years.</i></p></small>"),
  fig5.02_note = tagList(HTML("<small><p><b>Note:</b> Figures do not add to 100 per cent due to rounding.</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>An <b><i>exporter</b></i> is defined as an enterprise that sells goods out of the country,
                                   regardless of the value of exports.</p>
                                   <p><b><i>Value of exports</b></i> is measured in Canadian dollars.
                                   Value is as recorded in official customs documents, typically the actual selling price used for company
                                   accounting purposes. Canadian exports to overseas countries are valued including domestic freight
                                   charges to the port of exit point but excluding discounts and allowances,
                                   and international insurance.</p></small>")))),

  fig_5.03_desc = HTML("<p><small><i>This chart shows the proportion of exporters in British Columbia by business size by destination of exports.</i></p></small>"),
  fig5.03_note = tagList(HTML("<small><p><b>Note:</b> Figures do not add to 100 per cent due to rounding.</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>An <b><i>exporter</b></i> is defined as an enterprise that sells goods out of the country,
                                   regardless of the value of exports.</p></small>")))),

  fig5.04_desc = HTML("<small><p><i>This chart shows the proportion of the value of exports in British Columbia by business size by destination of exports.</i></p></small>"),
  fig5.04_note = tagList(HTML("<small><p><b>Note:</b> Figures do not add to 100 per cent due to rounding.</p>
                                      <p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Value of exports</b></i> is measured in Canadian dollars.
                                   Value is as recorded in official customs documents, typically the actual selling price used for company
                                   accounting purposes. Canadian exports to overseas countries are valued including domestic freight
                                   charges to the port of exit point but excluding discounts and allowances,
                                   and international insurance.</p></small>")))),

  fig5.05_desc = HTML("<small><p><i>This chart shows the proportion of the value of exports by small business exporters by destination of exports by province.</i></p></small>"),
  fig5.05_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data provided by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>A <b><i>small business exporter</b></i> is defined as an enterprise with fewer than 50 employees
                                   that exports goods out of the country, regardless of the value of exports.</p>
                                   <p><b><i>Value of exports</b></i> is measured in Canadian dollars.
                                   Value is as recorded in official customs documents, typically the actual selling price used for company
                                   accounting purposes. Canadian exports to overseas countries are valued including domestic freight
                                   charges to the port of exit point but excluding discounts and allowances,
                                   and international insurance.</p></small>")))),

  fig5.06_desc = HTML("<small><p><i>This chart illustrates the export intensity for small businesses by province.</i></p></small>"),
  fig5.06_note = tagList(HTML("<small><p><b>Source:</b> BC Stats using data supplied by Statistics Canada.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Export intensity</b></i> refers to the average value of exports per business.</p></small>")))),

  fig5.07_desc = HTML("<small><p><i>This chart shows the value of goods exported by British Columbia exporters by size over time.</i></p></small>"),
  fig5.07_note = tagList(HTML("<small><p><b>Source:</b> Statistics Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p><b><i>Value of exports</b></i> is measured in Canadian dollars.
                                   Value is as recorded in official customs documents, typically the actual selling price used for company
                                   accounting purposes. Canadian exports to overseas countries are valued including domestic freight
                                   charges to the port of exit point but excluding discounts and allowances,
                                   and international insurance.</p></small>")))),

  fig6.01_desc = HTML("<small><p><i>This chart is an overview of the small business tax rates across different provinces.</i></p></small>"),
  fig6.01_note = tagList(HTML("<small><p><b>Source:</b> B.C. Ministry of Finance / Prepared by BC Stats</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>The lower small business tax rate is applicable to Canadian-controlled private corporations (CCPCs)
                                   with active business income eligible for the federal small business deduction. One component of the
                                   small business deduction is the business limit.
                                   As of January 2023, the limit is $500,000 for all provinces and territories except Saskatchewan ($600,000).</p></small>")))),

  fig6.02_desc = HTML("<small><p><i>This chart shows the value of building permits divided by the total population by province.</i></p></small>"),
  fig6.02_note = tagList(HTML("<small><p><b>Source:</b> Statistics Canada / Prepared by BC Stats</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>The value of building permits includes expenditures in materials, labour, profit and overhead.
                                   The type of structures include new buildings, additions, alterations and renovations.</p></small>")))),

  fig6.03_desc = HTML("<small><p><i>This chart shows the number of business bankruptcies filed in a year for every 1,000 businesses by province.</i></p></small>"),
  fig6.03_note = tagList(HTML("<small><p><b>Source:</b> Innovation, Science and Economic Development Canada / Prepared by BC Stats.</p></small>"),
                         fluidRow(
                           box(
                             title = HTML("<small><b>Definitions:</b></small>"),
                             collapsible = TRUE,
                             collapsed = TRUE,
                             HTML("<small><p>Bankruptcy is a legal process performed under the Bankruptcy and Insolvency Act.
                                   A business' assets are assigned to a licence trustee because of inability to pay debts.
                                   A business bankruptcy is chiefly attributable to the liabilities incurred as a result of
                                   carrying on a commercial venture or business, and includes proprietorships, partnerships and
                                   Limited Companies.</p></small>"))))
)

