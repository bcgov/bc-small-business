search_terms <- tibble::tribble(
                                                             ~searchterm, ~figure_list,
                                                  "Number of businesses", "fig1.01, fig1.02, fig1.12, fig1.14",
                                                    "Businesses by size", "fig1.01, fig1.02, fig1.03, fig1.04",
                                                 "Businesses per capita", "fig1.12, fig1.13",
                                                     "Businesses growth", "fig1.01, fig1.02, fig1.04, fig1.08, fig1.09, fig1.11, fig1.12, fig1.15",
                                "Fastest growing businesses by industry", "fig1.08, fig1.09",
                                        "Businesses with paid employees", "fig1.06, fig1.07, fig2.03, fig3.04, fig3.05, fig3.06",
                                     "Businesses without paid employees", "fig1.06, fig1.07, fig2.03, fig3.04, fig3.05, fig3.06",
                                                            "Population", "fig1.12",
                                    "Share of small business employment", "fig2.07",
                                                    "Employment by size", "fig2.01, fig2.02, fig2.03, fig2.04",
                                                     "Employment growth", "fig2.05, fig2.06",
                                             "Employment growth by size", "fig2.01, fig2.04",
                                              "Public sector employment", "fig2.02, fig2.03",
                                         "Employment growth by industry", "fig2.08, fig2.09, fig2.10",
                                                "Self-employment growth", "fig3.02, fig3.03",
                               "Self-employment by incorporation status", "fig3.04, fig3.05",
                                                "Employment data by age", "fig3.07, fig3.08",
                                  "Hours worked data/ Average work week", "fig3.09, fig3.12",
                                                                   "GDP", "fig4.01",
                                                       "Provincial data", "fig1.10, fig1.11, fig1.12, fig2.05, fig2.06, fig2.07, fig3.01, fig3.02, fig3.10, fig4.01, fig4.05, fig4.06, fig5.02, fig5.05, fig5.06, fig6.01, fig6.02, fig6.03",
                                                         "Regional data", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                 "Large businesses data", "fig1.01, fig1.03, fig1.04, fig2.01, fig2.02, fig2.03, fig2.04, fig4.02, fig4.03, fig4.04, fig4.05, fig5.01, fig5.03, fig5.04, fig5.07",
                                                      "Data by industry", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                      "Average earnings", "fig4.02, fig4.03, fig4.04, fig4.05, fig4.06",
                                                  "High technology data", "fig1.08, fig1.09",
                                                          "Tourism data", "fig1.08, fig1.09",
                                          "Secondary manufacturing data", "fig1.08, fig1.09",
                                                     "Exporters by size", "fig5.01, fig5.02, fig5.03",
                                                      "Value of exports", "fig5.01, fig5.02, fig5.04, fig5.05, fig5.06, fig5.07",
                                                "Destination of exports", "fig5.03, fig5.04, fig5.05",
                                                              "Tax rate", "fig6.01",
                                           "Building permits per capita", "fig6.02",
                                                      "Bankruptcy rates", "fig6.03",
                                                               "Cariboo", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                "Vancouver Island Coast", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                              "Kootenay", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                       "Northern region", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                     "Thompson Okanagan", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                       "Interior region", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                     "Greater Vancouver", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                    "Mainland Southwest", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                           "North Coast", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                      "Northeast region", "fig1.12, fig1.13, fig1.14, fig1.15, fig3.03, fig3.11",
                                                  "Non-Standard Sectors", "fig1.08, fig1.09",
                            "Agriculture, forestry, fishing and hunting", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                         "Mining, quarrying, and oil and gas extraction", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                             "Utilities", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                          "Construction", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                         "Manufacturing", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                       "Wholesale trade", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                              "Retail trade", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                        "Transportation and warehousing", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                   "Information and cultural industries", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                 "Finance and insurance", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                    "Real estate and rental and leasing", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                       "Professional, scientific and technical services", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                               "Management of companies and enterprises", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
 "Administrative and support, waste management and remediation services", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                  "Educational services", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                     "Health care and social assistance", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                    "Arts, entertainment and recreation", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                       "Accommodation and food services", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                         "Other services (except public administration)", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                 "Public administration", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04",
                                                     "Natural resources", "fig1.05, fig1.06, fig1.07, fig1.08, fig1.09, fig2.08, fig2.09, fig2.10, fig4.03, fig4.04"
 )



