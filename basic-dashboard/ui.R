## ui.R ##

library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(shinyjs)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)


#### User Interface Components ####

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
                                                          choices = c("Option 1", "Option 2", "Option 3")
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