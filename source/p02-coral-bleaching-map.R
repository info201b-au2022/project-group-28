install.packages(c("sf", "mapview"))
library(tidyverse)
library(sf)
library(mapview)
setwd("C:/Users/sarah/OneDrive/Documents/info201/project-group-28/data")
coral_data <- read.csv("CoralBleaching.csv")
mapview(coral_data, xcol = "LON", ycol = "LAT", crs = 4269, 
        grid = FALSE)

#This map shows the longitude and latitude of all the locations
#where coral bleaching has occurred in this data set. As the 
#map shows, coral bleaching affects coral reefs all over the 
#world. It is not just concentrated to one area. The data 
#points appear to be more concentrated north of Australia and 
#between North America and South America. This is also where a
#larger number of coral reefs are located. This is helpful to 
#understand that coral bleaching does not necessarily have any
#correlation with a particular region of the world. 


