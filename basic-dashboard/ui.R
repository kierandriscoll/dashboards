## ui.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(skin="green",
                    dashboardHeader(title = "Basic dashboard"),
                    dashboardSidebar(sidebarMenu(
                      menuItem("CSAT", tabName = "CSAT", icon = icon("star")),
                      menuItem("Word Cloud", icon = icon("cloud"), tabName = "WordCloud"),
                      menuItem("Demographics", icon = icon("users"), tabName = "Demographics"),
                      menuItem("Search", icon = icon("search"), tabName = "Search")
                    )),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "CSAT",
                                h2("CSAT tab content")
                        ),
                        tabItem(tabName = "WordCloud",
                                h2("Word Cloud tab content")
                        ),
                        tabItem(tabName = "Demographics",
                                h2("Demographics tab content")
                        ),
                        tabItem(tabName = "Search",
                                h2("Search tab content")
                        )
                      ))
)
