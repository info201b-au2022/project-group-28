#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(sf)
library(mapview)

#create data frames
name = c("Acropora", "Montipora", "Pocillopora", "Porites")
Reef_Size = c("small (< 10 cm)", "medium (10-50 cm)", "large (> 50 cm)") 
value = c(56, 12, 5, 3, 50, 22, 11, 1, 55, 12, 48, 0)


corals <- data.frame(name, Reef_Size, value, stringsAsFactors = FALSE) 
coral_data <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/CoralBleaching.csv")
filtered_coral_data <- filter(coral_data, SEVERITY_CODE > 0)

severe_coral_bleaching_events <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/coral-bleaching-events.csv")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$map <- renderPlot({
      map <- mapview(filtered_coral_data, xcol = "LON", ycol = "LAT", crs = 4269, 
              grid = FALSE)
    })
    output$bargraph <- renderPlot({
      bargraph <- ggplot(data = corals, aes(x = name, y = value, fill = Reef_Size)) + 
        geom_bar(stat = "identity", position = "dodge") +
        labs(title = "Coral Species vs Bleaching Susceptibility", 
             x = "Coral Species", 
             y = "Bleaching Susceptibilty (percentage)")
    })
    output$scatterplot <- renderPlot({
      scatterplot <- ggplot(severe_coral_bleaching_events, aes(x=Year, y=Severe.bleaching.events...30..bleached., color=Entity)) +
        geom_point() +
        labs(title = "Severe Coral Bleaching Events Over Time",
             x = "Year",
             y = "Number of Severe Bleaching Events >30% Bleached")
    })
    output$coral_image = renderUI({
      src = "https://insideclimatenews.org/wp-content/uploads/2016/06/American-Samoa-Before-During-After-1024x494.jpg"
    })

})
