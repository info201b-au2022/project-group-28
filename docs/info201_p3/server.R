#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(plotly)
library(rbokeh)
library(shiny)
library(tidyverse)
library(sf)
library(mapview)
library(leaflet)

#create report table
data_file_name = c("CoralBleaching", 
                   "Rowley_Shoals_and_Scott_Reef_Long-term_Reef_Slope_coral",
                   "Rowley_Shoals_and_Scott_Reef_Habitats_2016_Bleaching_Cover",
                   "coral_bleaching_events")
observations = c(6190, 159, 105, 185)
variables = c(28, 18, 8, 5)
report_table <- data.frame(data_file_name, observations, variables)

#create corals
name = c("Acropora", "Montipora", "Pocillopora", "Porites")
Reef_Size = c("small (< 10 cm)", "medium (10-50 cm)", "large (> 50 cm)") 
value = c(56, 12, 5, 3, 50, 22, 11, 1, 55, 12, 48, 0)
corals <- data.frame(name, Reef_Size, value, stringsAsFactors = FALSE)

severe_coral_bleaching_events <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/coral-bleaching-events.csv")

#create severe_coral_bleaching_events
severe_coral_bleaching_events <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/coral-bleaching-events.csv")

#create coral_data
coral_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/CoralBleaching.csv")
severity <- coral_data %>% 
  filter(SEVERITY_CODE > 0) %>% 
  select(COUNTRY, LAT, LON, YEAR, SEVERITY_CODE)

#create summary table
summary_table <- coral_data %>% 
  select(COUNTRY, CORAL_SPECIES, YEAR, SEVERITY_CODE, BLEACHING_SEVERITY) %>% 
  group_by(COUNTRY) %>%
  filter(CORAL_SPECIES == "Acropora"| CORAL_SPECIES == "Montipora"|
           CORAL_SPECIES == "Pocillopora"| CORAL_SPECIES == "Porites", na.rm = TRUE)

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
      reef_size <- filter(corals, 
                          Reef_Size == input$size)
      plot_ly(
        data = reef_size,      
        x = ~name, 
        y = ~value, 
        color = ~name, 
        type = "bar", 
        alpha = .7,
        hovertext = ""
      ) %>%
        layout(title = "Coral Bleaching vs Type", 
               xaxis = list(title = "Name"), 
               yaxis = list(title = "Coral Bleaching Succeptibity"))
    })
    output$linegraph <- renderPlotly ({
      entity <- filter(severe_coral_bleaching_events,
                       Entity == input$entity)
      plot_ly(
        data = entity,      
        x = ~Year, 
        y = ~Severe.bleaching.events...30..bleached., 
        type = "scatter", 
        mode = "lines",
        hovertext = ""
      ) %>%
          layout(title = "Coral Bleaching Based on Year", 
                 xaxis = list(title = "Year"), 
                 yaxis = list(title = "Severity of Bleaching"))

    })
    output$summary_table <- renderTable({
      summary_table
    })
    output$summary_map <- renderLeaflet({
      pal <- colorFactor(
        palette = "Dark2", 
        domain = severity[["SEVERITY_CODE"]]
      )
      leaflet(data = severity) %>%
        addTiles() %>%
        addCircleMarkers(
          lat = ~LAT,
          lng = ~LON,
          color = ~pal(severity[["SEVERITY_CODE"]]),
          fillOpacity = 0.7,
          radius = 4,
          stroke = FALSE) %>%
        addLegend(
          position = "bottomright",
          title = "severity code",
          pal = pal,
          values = severity[["SEVERITY_CODE"]],
          opacity = 1)
    })
    output$summary_linegraph <- renderPlot({
      ggplot(severe_coral_bleaching_events, aes(x=Year, y=Severe.bleaching.events...30..bleached., color=Entity)) +
      geom_line() +
        labs(title = "Severe Coral Bleaching Events Over Time",
             x = "Year",
             y = "Number of Severe Bleaching Events >30% Bleached")
    })
    output$summary_bargraph <- renderPlot({
      ggplot(data = corals, aes(x = name, y = value, fill = Reef_Size)) + 
        geom_bar(stat = "identity", position = "dodge") +
        labs(title = "Coral Species vs Bleaching Susceptibility", 
             x = "Coral Species", 
             y = "Bleaching Susceptibilty (percentage)")
    })
})
