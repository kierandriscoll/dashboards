## server.R ##

server <- function(input, output) { 
  
#### Code for the Plotly tab #### 
output$plotly_line <- renderPlotly({

  filtered <- mtcars %>%
              filter(carb == input$plotly_select_input)
  
  filtered %>%
  plot_ly(x = ~mpg,
          y = ~disp,
          color = ~gear,
          type = "scatter",
          mode = "markers",
          hoverinfo = "text",
          hovertext = paste("MPG: ", filtered$mpg, "<br>Disp: ", filtered$disp)
          ) %>%
  layout(title = "mpg vs. disp",
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = TRUE)
         ) %>%
  config(displayModeBar = F)   
})



output$plotly_select <- renderUI({
  selectizeInput(inputId = "plotly_select_input",
                 width = "50%",
                 label = "Select",
                 choices = unique(mtcars$carb),
                 selected = 4
                 )   
})  
  
  
#### Code for the DataTable tab #### 
output$data_table <- renderDataTable({
  mtcars %>%
  DT::datatable(selection = "single",
                options = list(lengthMenu = c(10, 20, 30))
                ) %>%
  formatStyle("mpg",
              background = styleColorBar(c(min(mtcars$mpg), max(mtcars$mpg)), "red"),
              backgroundSize = "98% 88%",
              backgroundRepeat = "no-repeat",
              backgroundPosition = "center" 
              )  
})


observeEvent(input$data_table_rows_selected, {
  row <- input$data_table_rows_selected  
})  
  
  
#### Code for the Maps tab #### 
  
  
  
  
  
#### Code for the Together tab #### 



#### if need to split server code into modules ####
#source('abc.R', local = TRUE)
  
  }
