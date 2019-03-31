## ui.R ##

library(shiny)
library(shinydashboard)
library(dplyr)
library(plotly)
library(DT)


#### User Interface Components ####

ui_header <- dashboardHeader(title = "Basic dashboard")

ui_sidebar <- dashboardSidebar(
                sidebarMenu(menuItem("Charts", tabName = "Plotly", icon = icon("star")),
                            menuItem("Tables", tabName = "DataTable", icon = icon("dashboard")),
                            menuItem("Maps", tabName = "Maps", icon = icon("cloud")),
                            menuItem("All", tabName = "Together", icon = icon("users"))
                ),
                
                dateRangeInput(inputId = "date_range",
                               "Date range:",
                               start= "2019-01-01",
                               end = "2019-03-31",
                               separator = " to ")
              )

ui_body <- dashboardBody(
            tabItems(
              tabItem(
                tabName = "Plotly",
                fluidRow(box(width = 12,
                             solidHeader = TRUE,
                             status = "primary",
                             title = "Plotly Chart",
                             plotlyOutput(outputId = "plotly_line"),
                             uiOutput(outputId = "plotly_select")
                             )
                         )
                ),
              tabItem(
                tabName = "DataTable",
                h2("DataTable"),
                fluidRow(box(width = 12,
                             dataTableOutput("data_table")))
                ),
              tabItem(
                tabName = "Maps",
                h2("Maps"),
                fluidRow(box(width = 12))
                ),
              tabItem(
                tabName = "Together",
                h2("All Together"),
                fluidRow(box(width = 12))
                )
            )
          )


ui <- dashboardPage(skin = "green", ui_header, ui_sidebar, ui_body)