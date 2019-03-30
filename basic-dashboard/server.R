## server.R ##

server <- function(input, output) { 
  
#### Code for the Plotly tab #### 
output$plotly_line <- renderPlotly(mtcars %>%
                                   plot_ly(x = ~mpg,
                                           y = ~disp,
                                           color = ~gear,
                                           type = "scatter",
                                           mode = "markers") %>%
                                   config(displayModeBar = F)   
                                  )
  
  
  
#### Code for the DataTable tab #### 
output$data_table <- renderDataTable(mtcars %>%
                                    datatable()   
                     )

  
  
  
#### Code for the Maps tab #### 
  
  
  
  
  
#### Code for the Together tab #### 
  
  }
