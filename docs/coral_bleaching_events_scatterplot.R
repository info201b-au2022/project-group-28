library(tidyverse)
library("ggplot2")

# Load coral-bleaching-events.csv, with moderate and severe coral bleaching events with time and general location
severe_coral_bleaching_events <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/coral-bleaching-events.csv")

# Create scatterplot for severe bleaching events vs. year, with different colors for each general location
ggplot(severe_coral_bleaching_events, aes(x=Year, y=Severe.bleaching.events...30..bleached., color=Entity)) +
  geom_point() +
  labs(title = "Severe Coral Bleaching Events Over Time",
       x = "Year",
       y = "Number of Severe Bleaching Events >30% Bleached")

# This data visualization shows a general timeline of severe coral bleaching events from the year 1930 to 2016, and is organized by general
# location, which in this case is the ocean's region. The x-axis shows the change in time, while the y-axis shows the number of severe
# bleaching events that occurred that year. The data points are organized by location, with a different color representing each region.
# Overall, Australasia has the most frequent severe coral bleaching events with the exception of the World category.