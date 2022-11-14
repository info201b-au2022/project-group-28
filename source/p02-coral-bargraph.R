library(tidyverse)
library(dplyr)
library(tidyr)

library("ggplot2") 

# Create dataframe for coral bleaching vs coral succeptability to heat

name = c("Acropora", "Montipora", "Pocillopora", "Porites")
Reef_Size = c("small (< 10 cm)", "medium (10-50 cm)", "large (> 50 cm)") 
value = c(56, 12, 5, 3, 50, 22, 11, 1, 55, 12, 48, 0)


corals <- data.frame(name, Reef_Size, value, stringsAsFactors = FALSE) 

# create bar graph with key legend that includes different colors for each obstacles

ggplot(data = corals, aes(x = name, y = value, fill = Reef_Size)) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Coral Species vs Bleaching Susceptibility", 
       x = "Coral Species", 
       y = "Bleaching Susceptibilty (percentage)")


# The chart I included displays what kind of coral species are most susceptible to coral
# bleaching. This bar graph shows four of the most common coral species and their resistance
# to bleaching based on their coral reef size. We can see that the most susceptable species 
# corals are Acropora and the most resistant are the Porites species.
