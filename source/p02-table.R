library(tidyverse)
library(stringr)
library(dplyr)
library(tidyr)
library(readr)
coral_data <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/CoralBleaching.csv")
table <- coral_data %>% 
  select(COUNTRY, CORAL_SPECIES, BLEACHING_SEVERITY, WATER_TEMPERATURE, OTHER_FACTORS) %>% 
  group_by(COUNTRY) %>% 
  filter(CORAL_SPECIES == "Acropora"| CORAL_SPECIES == "Montipora"|
           CORAL_SPECIES == "Pocillopora"| CORAL_SPECIES == "Porites") 

# This table shows the necessary elements and value we used to create our visualizations and 
# answer our research questions. The table includes the information on four main species of
# corals. It includes the location, bleaching level, and factors to the corals' bleaching.
