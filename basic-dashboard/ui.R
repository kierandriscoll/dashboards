## ui.R ##
library(shiny)
library(shinydashboard)
library(dplyr)
library(plotly)
library(DT)


ui_header <- dashboardHeader(title = "Basic dashboard")

ui_sidebar <- dashboardSidebar(
                sidebarMenu(menuItem("Charts", tabName = "Plotly", icon = icon("star")),
                            menuItem("Tables", tabName = "DataTable", icon = icon("dashboard")),
                            menuItem("Maps", tabName = "Maps", icon = icon("cloud")),
                            menuItem("All", tabName = "Together", icon = icon("users"))
                )
              )

ui_body <- dashboardBody(
            tabItems(
              tabItem(
                tabName = "Plotly",
                h2("Ploty Charts"),
                fluidRow(box(width = 12,
                             plotlyOutput("plotly_line")))
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



# ui <- dashboardPage(skin="green",
#                     dashboardHeader(title = "Basic dashboard"),
#                     dashboardSidebar(
#                       sidebarMenu(menuItem("Charts", tabName = "Plotly", icon = icon("star")),
#                                   menuItem("Tables", tabName = "DataTable", icon = icon("dashboard")),
#                                   menuItem("Maps", tabName = "Maps", icon = icon("cloud")),
#                                   menuItem("All", tabName = "Together", icon = icon("users"))
#                       )
#                     ),
#                     dashboardBody(
#                       tabItems(
#                         tabItem(
#                           tabName = "Plotly",
#                           h2("Ploty Charts"),
#                           fluidRow(box(width = 12,
#                                        plotlyOutput("plotly_line")))
#                         ),
#                         tabItem(
#                           tabName = "DataTable",
#                           h2("DataTable"),
#                           fluidRow(box(width = 12,
#                                        dataTableOutput("data_table")))
#                         ),
#                         tabItem(
#                           tabName = "Maps",
#                           h2("Maps"),
#                           fluidRow(box(width = 12
#                                        ))
#                         ),
#                         tabItem(
#                           tabName = "Together",
#                           h2("All Together"),
#                           fluidRow(box(width = 12
#                                        ))
#                         )
#                       )
#                     )
# )


ui <- dashboardPage(skin = "green", ui_header, ui_sidebar, ui_body)