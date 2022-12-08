library(tidyverse)
library(dplyr)
library(tidyr)
library(readr)
library(knitr)
coral_data <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/CoralBleaching.csv")

summary_table <- coral_data %>% 
  select(COUNTRY, CORAL_SPECIES, YEAR, SEVERITY_CODE, BLEACHING_SEVERITY) %>% 
  group_by(COUNTRY) %>%
  filter(CORAL_SPECIES == "Acropora"| CORAL_SPECIES == "Montipora"|
           CORAL_SPECIES == "Pocillopora"| CORAL_SPECIES == "Porites", na.rm = TRUE)
# This table shows the necessary elements and value we used to create our visualizations and 
# answer our research questions. The table includes the information on four main species of
# corals. It includes the location, bleaching level, and factors to the corals' bleaching.
