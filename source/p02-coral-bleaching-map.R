install.packages(c("sf", "mapview"))
library(tidyverse)
library(sf)
library(mapview)
coral_data <- read.csv("CoralBleaching.csv")
mapview(coral_data, xcol = "LON", ycol = "LAT", crs = 4269, 
        grid = FALSE)
