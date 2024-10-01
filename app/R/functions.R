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

# creates horiztontal line
hline <- function(y = 0, color = "black") {
  list(
    type = "line",
    x0 = 0,
    x1 = 1,
    xref = "paper",
    y0 = y,
    y1 = y,
    line = list(color = color))
}

# creates vertical line
vline <- function(x = 0, color = "black") {
  list(
    type = "line",
    x0 = x,
    x1 = x,
    yref = "paper",
    y0 = 0,
    y1 = 1,
    line = list(color = color))
}

# layout options to use for all charts
plotly_custom_layout <- function(plot) {

  plot %>%
    layout(
      title = "",
      hoverlabel = list(namelength = -1),  ## shows full hover label regardless of length
      dragmode = FALSE,  # remove drag zoom
      modebar = list(remove = list("autoscale","hoverCompareCartesian", "lasso", "pan", "select", "zoom"))
    )
}

# plot provincial charts - vertical bar chart with BC colored yellow and optional Canadian average horizontal line
provincial_chart <- function(plot_data, hline_val = NULL, label = NULL, label_x = NULL, label_y = NULL, y_title = "", y_tickformat = "0%") {

  plot <- plot_ly(plot_data,
                  x = ~Category,
                  y = ~Value,
                  type = "bar",
                  marker = list(color = ~selected_color),
                  text = ~ paste0(Category, ": ", Label),
                  textposition = "none",
                  hoverinfo = "text") %>%
    layout(xaxis = list(title = ""),
           yaxis = list(title = y_title, tickformat = y_tickformat))

  if(!is.null(hline_val)) {

    plot <- plot %>%
      layout(shapes = list(hline(hline_val))) %>%
      add_annotations(
        x = label_x,
        y = label_y,
        text = paste("<b>— ", label, "</b>"),
        xref = "paper",
        yref = "paper",
        xanchor = "left",
        yanchor = "bottom",
        showarrow = F)
  }

  plot %>% plotly_custom_layout()
}

# plot horizontal bar charts
horizontal_bar_chart <- function(plot_data, colors, x_title = "", x_tickformat,
                                 barmode = "group", hovermode = "y",
                                 autorange = "normal", showlegend = FALSE, traceorder = "normal"){

  if(hovermode == "y unified") {
    hoverinfo = NULL
    hovertemplate = "%{text}<extra></extra>"
  } else {
    hoverinfo = "text"
    hovertemplate = NULL
  }

  plot_ly(plot_data,
          type = "bar",
          x = ~Value,
          y = ~y_Category,
          color = ~color_Category,
          colors = colors,
          text = ~Label,
          textposition = "none",
          hoverinfo = hoverinfo,
          hovertemplate = hovertemplate) %>%
    layout(xaxis = list(title = x_title, tickformat = x_tickformat),
           yaxis = list(title = "", autorange = autorange),
           barmode = barmode,
           hovermode = hovermode,
           showlegend = showlegend,
           legend = list(orientation = "h",
                         traceorder = traceorder,
                         x = 0,
                         y = 1.2)) %>%
    plotly_custom_layout()
}

# plot vertical bar charts
vertical_bar_chart <- function(plot_data, colors, y_title = "", y_tickformat,
                               barmode = "group", autorange = "normal",
                               showlegend = TRUE, traceorder = "normal", legend_dir = "v") {

  plot_ly(plot_data,
          type = "bar",
          x = ~x_Category,
          y = ~Value,
          color = ~color_Category,
          colors = colors,
          text = ~Label,
          textposition = "none",
          hovertemplate = "%{text}<extra></extra>") %>%
    layout(xaxis = list(title = ""),
           yaxis = list(title = y_title, tickformat = y_tickformat, autorange = autorange),
           barmode = barmode,
           hovermode = "x unified",
           showlegend = showlegend,
           legend = list(orientation = legend_dir,
                         traceorder = traceorder,
                         x = 0,
                         y = 1.2)) %>%
    plotly_custom_layout()
}



