# Shiny Dashboards
shinydashboard (v0.1) uses CSS from the [AdminLTE template](https://adminlte.io/themes/AdminLTE/documentation/index.html) which is based on [Bootstrap v3](https://getbootstrap.com/docs/3.4/)

## User Interface
A shiny dashboard UI consists of a header, sidebar and body:
```r
ui_header <- dashboardHeader(title = "Basic dashboard")
ui_sidebar <- dashboardSidebar()
ui_body <- dashboardBody()
ui <- dashboardPage(ui_header, ui_sidebar, ui_body)
```
Most shiny functions generate html code:  
**dashboardHeader()** generates:
```html
<header class="main-header">
  <span class="logo"></span>
  <nav class="navbar navbar-static-top" role="navigation">
    <span style="display:none;">
      <i class="fa fa-bars"></i>
    </span>
    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
      <span class="sr-only">Toggle navigation</span>
    </a>
    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav"></ul>
    </div>
  </nav>
</header>
```
**dashboardSidebar()** generates:
```html
<aside id="sidebarCollapsed" class="main-sidebar" data-collapsed="false">
  <section id="sidebarItemExpanded" class="sidebar"></section>
</aside>
```
**dashboardBody()**
```html
<div class="content-wrapper">
  <section class="content"></section>
</div> generates:
```
**dashboardPage()** wraps the components these components in:
```html
<body class="skin-blue" style="min-height: 611px;">	
  <div class="wrapper">
    <!-- header/sidebar/body code -->  
  </div>	
</body>    
```

```r
ui_header <- dashboardHeader(title = "Basic dashboard")

ui_sidebar <- dashboardSidebar(
                sidebarMenu(id = "sidebar_menu",
                            menuItem("Charts", tabName = "Plotly", icon = icon("star")),
                            menuItem("Tables", tabName = "DataTable", icon = icon("dashboard")),
                            menuItem("Maps", tabName = "Maps", icon = icon("cloud")),
                            menuItem("All", tabName = "Together", icon = icon("users"))
                ),
                
                dateRangeInput(inputId = "date_range",
                               "Date range:",
                               start= "2019-01-01",
                               end = "2019-03-31",
                               format = "dd-M-yyyy",
                               separator = " to ")
              )
  
ui_body <- dashboardBody(
            tabItems(
              tabItem(
                tabName = "Plotly",
                fluidRow(
                  box(width = 6,
                      solidHeader = TRUE,
                      status = "primary",
                      title = "Plotly Scatter",
                             
                      div(style ="font-size: 16px; font-weight: bold; text-align: center;",
                      HTML("Lorem ipsum dolor sit amet")),
                             
                      plotly::plotlyOutput(outputId = "plotly_line") %>%
                      shinycssloaders::withSpinner(type = 7),
                             
                      uiOutput(outputId = "plotly_select")
                  ),
              
                  box(width = 6,
                      solidHeader = TRUE,
                      status = "primary",
                      title = "Plotly Time Series",
                            
                      plotly::plotlyOutput(outputId = "plotly_time") %>%
                      shinycssloaders::withSpinner(type = 7)
                  )
                ),
                fluidRow(
                  box(width = 6,
                      solidHeader = TRUE,
                      status = "primary"
                      
                  ),
                  
                  box(width = 6,
                      solidHeader = TRUE,
                      status = "primary",
                      title = "Dygraph Time Series",
                      
                      dygraphs::dygraphOutput(outputId = "dygraph_time") %>%
                        shinycssloaders::withSpinner(type = 7)
                  )
                )
              ),
              tabItem(
                tabName = "DataTable",
                h2("DataTable"),
                fluidRow(
                  box(width = 8,
                      DT::DTOutput(outputId = "data_table")),
                  
                  box(width = 4,
                      uiOutput(outputId = "text_data_table"))
                )  
              ),
              tabItem(
                tabName = "Maps",
                h2("Maps"),
                fluidRow(box(width = 12))
              ),
              tabItem(
                tabName = "Together",
                h2("All Together"),
                fluidRow(
                  box(width = 12,
                      div(shinyWidgets::radioGroupButtons(inputId = "radio_input",
                                                          width = "50%",
                                                          status = "primary",
                                                          choices = c("Option 1", "Option 2", "Option 3"),
                                                          checkIcon = list(yes = icon("dot-circle-o"), no = icon("circle-o"))
                      ))
                  ),
                  
                  box(width = 12,
                      solidHeader = TRUE,
                      status = "primary",
                      title = "Plotly Bar",
                      
                      plotly::plotlyOutput(outputId = "plotly_bar") %>%
                        shinycssloaders::withSpinner(type = 7)
                  )
                )
              )
            )
          )


ui <- dashboardPage(skin = "green", ui_header, ui_sidebar, ui_body, useShinyjs())
