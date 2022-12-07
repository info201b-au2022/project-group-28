install.packages(c("sf", "mapview"))
library(tidyverse)
library(sf)
library(mapview)
library(readr)
coral_data <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/CoralBleaching.csv")
severity <- coral_data %>% 
  filter(SEVERITY_CODE > 0) %>% 
  select(COUNTRY, LAT, LON, YEAR, SEVERITY_CODE)
pal <- colorFactor(palette = "Dark2", domain = severity[["SEVERITY_CODE"]])
(basemap <- leaflet(data = severity) %>%
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
      opacity = 1
    ))
     
#map <- mapview(filtered_coral_data, xcol = "LON", ycol = "LAT", crs = 4269, 
#        grid = FALSE)

#This map shows the longitude and latitude of all the locations where coral 
#bleaching has a severity code greater than 0 in this data set. As the map 
#shows, coral bleaching affects coral reefs all over the world. It is not just
#concentrated to one area. The data points appear to be more concentrated north
#of Australia and between North America and South America. This is also where a
#larger number of coral reefs are located. This is helpful to understand that 
#coral bleaching does not necessarily have any correlation with a particular 
#region of the world. 


