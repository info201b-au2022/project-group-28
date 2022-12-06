#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#creating the intro page
tab_panel_01 <-tabPanel(
  "Introduction",
  mainPanel(
    h1("Introduction")
  ),
  verbatimTextOutput("introduction"))
#creating first interactive page
tab_panel_02 <- tabPanel(
  "Map of Coral Bleaching",
  mainPanel(
    h1("Map"),
    plotOutput("map")
  )
)
#creating second interactive page
tab_panel_03 <- tabPanel(
  "Bargraph",
  mainPanel(
    h1("Bargraph"),
    plotOutput("bargraph")
  )
)
#creating third interactive page
tab_panel_04 <- tabPanel(
  "Scatterplot",
  mainPanel(
    h1("Scatterplot"),
    plotOutput("scatterplot")
  )
)
tab_panel_05 <- tabPanel(
  "Summary Takeaways"
)
tab_panel_06 <- tabPanel(
  "Project Report"
)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("darkly"),
  navlistPanel(
    "Trends Coral Reef Bleaching",
    
    # Variable set in tab_panel_plot.R
    tab_panel_01,

    tab_panel_02,
    
    tab_panel_03,
    
    tab_panel_04,
    
    tab_panel_05,
    
    tab_panel_06
  )
))
