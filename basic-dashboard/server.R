## server.R ##

server <- function(input, output) { 
 
#### Code for the Plotly tab ####

# Scatter/Line chart #  
output$plotly_line <- plotly::renderPlotly({
  
  req(input$plotly_select_input)
  
  df <- mtcars %>%
        filter(carb == input$plotly_select_input)
  
  plotly::plot_ly(data = df,
                  x = ~mpg,
                  y = ~disp,
                  color = ~gear,
                  type = "scatter",
                  mode = "markers",
                  hoverinfo = "text",
                  hovertext = paste("MPG: ", df$mpg, "<br>Disp: ", df$disp)
  ) %>%
  plotly::layout(title = "mpg vs. disp",
                 xaxis = list(showgrid = FALSE),
                 yaxis = list(showgrid = TRUE)
  ) %>%
  plotly::config(displayModeBar = F)   
})


# Drop Down Box #
output$plotly_select <- renderUI({
  selectizeInput(inputId = "plotly_select_input",
                 width = "50%",
                 label = "Select carburetors",
                 choices = unique(mtcars$carb),
                 selected = 4
  )   
})  


# Plotly Time Series chart #  
output$plotly_time <- plotly::renderPlotly({

  plotly::plot_ly(data = ggplot2::economics,
                  x = ~date,
                  y = ~unemploy,
                  type = "scatter",
                  mode = "lines",
                  hoverinfo = "text",
                  hovertext = paste("Date: ", format(economics$date, "%d-%b-%Y"),
                                    "<br>Unemp: ", economics$unemploy)
  ) %>%
  plotly::layout(title = "US Unemployment",
                 xaxis = list(title = "Date",
                              showgrid = FALSE,
                              rangeslider = list(type = "date")),
                 yaxis = list(title = "Unemployment, 000's",
                              range = c(0, max(economics$unemploy)),
                              showgrid = TRUE)
  ) %>%
  plotly::config(displayModeBar = F)   
})



# Dygraph Time Series chart #  
output$dygraph_time <- dygraphs::renderDygraph({
  
  # Click event : extract date 
  date_clicked <- ifelse(is.null(input$dygraph_time_click$x) == TRUE,
                         "2999-01-01",
                         strftime(input$dygraph_time_click$x, format="%Y-%m-%d")) # 
  
  # Convert to XTS
  xts_data <- xts::xts(select(ggplot2::economics, unemploy), order.by = ggplot2::economics$date)  

  # Draw chart
  dygraphs::dygraph(xts_data) %>%
  dySeries("unemploy",
           label = "Unemployment",
           strokeWidth = 4,
           color = "#3c8dbc") %>%
  dyAxis("x", drawGrid =FALSE) %>%
  dyAxis("y", drawGrid = TRUE, axisLineColor = "white" ) %>%
  dyLegend(width = 130, show = "follow", labelsSeparateLines = TRUE) %>%
  dyRangeSelector() %>%
  dyEvent(date_clicked)
        
})


  
  
#### Code for the DataTable tab ####

# DataTable #
output$data_table <- DT::renderDT({
  
  mtcars %>%
  DT::datatable(selection = "single",
                options = list(lengthMenu = c(10, 20, 30))
  ) %>%
  DT::formatStyle("mpg",
                  background = styleColorBar(c(min(mtcars$mpg), max(mtcars$mpg)), "red"),
                  backgroundSize = "98% 88%",
                  backgroundRepeat = "no-repeat",
                  backgroundPosition = "center" 
  )  
})


# Text from DataTable #
output$text_data_table <- renderUI({

  x <- input$data_table_rows_selected  # Nb. DT automatically creates various interactive inputs
  
  if (length(x) == 0) {  
    HTML("Click on a row in the table")
  }
  else {
    HTML(paste("You have selected", rownames(mtcars[x,]),
               "<br> It does ", mtcars[x,"mpg"], " mpg.",
               "<br> It has ", mtcars[x,"cyl"], " cylinders.",
               "<br> It has ", mtcars[x,"gear"], " gears.",
               "<br> It has ", mtcars[x,"hp"], " horsepower.",
               "<br> It weighs ", mtcars[x,"wt"]*1000, " pounds."
    ))     
  }
    
})
  
#### Code for the Maps tab #### 
  
  
  
  
  
#### Code for the Together tab #### 

# Observer#
# test <- reactiveValues(data_table_observe = "")
 
observeEvent(input$sidebar_menu, {
  
  if (input$sidebar_menu == "Plotly") {
    shinyjs::hide(id = "date_range")
  } 
  
  else {
    shinyjs::show(id = "date_range")
  }
 
})  


# Scatter/Line chart #  
output$plotly_bar <- plotly::renderPlotly({
  
  df <- txhousing %>%
        filter(year == 2015) %>%
        group_by(city) %>%
        summarise(total_sales = sum(sales),
                  total_volume = sum(volume),
                  avg_price = round(sum(volume) / sum(sales), -3) ) %>%
        ungroup()
  
  plotly::plot_ly(data = df,
                  y = ~city,
                  x = ~avg_price,
                  type = "bar",
                  hoverinfo = "text",
                  hovertext = paste("Total Sales: ", df$total_sales,
                                    "<br>Average Price: £", df$avg_price)
  ) %>%
  plotly::layout(title = "Texas : Average House Sale Price",
                 xaxis = list(showgrid = FALSE),
                 yaxis = list(showgrid = TRUE),
                 margin = list(l = 130)
  ) %>%
  plotly::config(displayModeBar = F)   
})


#### if need to split server code into modules ####
#source('abc.R', local = TRUE)
  
  }
