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
library(leaflet)

#create data frames
name = c("Acropora", "Montipora", "Pocillopora", "Porites")
Reef_Size = c("small (< 10 cm)", "medium (10-50 cm)", "large (> 50 cm)") 
value = c(56, 12, 5, 3, 50, 22, 11, 1, 55, 12, 48, 0)

severe_coral_bleaching_events <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/coral-bleaching-events.csv")

corals <- data.frame(name, Reef_Size, value, stringsAsFactors = FALSE) 

new_corals <- reactive({
  corals <- data.frame(name, Reef_Size, value, stringsAsFactors = FALSE) 
})  

severe_coral_bleaching_events <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/coral-bleaching-events.csv")

coral_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/CoralBleaching.csv")
severity <- coral_data %>% 
  filter(SEVERITY_CODE > 0) %>% 
  select(COUNTRY, LAT, LON, YEAR, SEVERITY_CODE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$map <- renderLeaflet({
      data_by_country <- filter(severity,
                             COUNTRY == input$country)
      pal <- colorFactor(
        palette = "Dark2", 
        domain = data_by_country[["SEVERITY_CODE"]]
      )
      leaflet(data = data_by_country) %>%
         addTiles() %>%
         addCircleMarkers(
           lat = ~LAT,
           lng = ~LON,
           color = ~pal(data_by_country[["SEVERITY_CODE"]]),
           fillOpacity = 0.7,
           radius = 4,
           stroke = FALSE) %>%
         addLegend(
           position = "bottomright",
           title = "severity code",
           pal = pal,
           values = data_by_country[["SEVERITY_CODE"]],
           opacity = 1
         )
    })
    output$bargraph <- renderPlotly ({
      plot_ly(
        data = new_corals(),      
        x = ~name, 
        y = ~value, 
        color = ~Reef_Size, 
        type = "bar", 
        alpha = .7,
        hovertext = ""
      ) %>%
        layout(title = "Coral Bleaching vs Type", 
               xaxis = list(title = "Name"), 
               yaxis = list(title = "Coral Bleaching Succeptibity", 
                            ticksuffix = " ", "Bleaching Index"))
    })
    
    output$linegraph <- renderPlot({
      ggplot(severe_coral_bleaching_events, aes(x=Year, y=Severe.bleaching.events...30..bleached., color=Entity)) +
        geom_line() +
        labs(title = "Severe Coral Bleaching Events Over Time",
             x = "Year",
             y = "Number of Severe Bleaching Events >30% Bleached")
    })
    
})
