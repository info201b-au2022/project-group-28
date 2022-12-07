#shows what year most coral bleaching occurred in this 
#data set
coral_data <- read.csv("CoralBleaching.csv")
filtered_coral_data <- filter(coral_data, SEVERITY_CODE > 0)
just_certain_info <- select(coral_data, COUNTRY, LOCATION, YEAR, SEVERITY_CODE)
certain_bleached_coral <- select(filtered_coral_data, COUNTRY, LOCATION, YEAR, SEVERITY_CODE)
summary(certain_bleached_coral$YEAR)
