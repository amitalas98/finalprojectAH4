data <- read.csv("./suicide_rate_overview_1985_to_2016.csv", stringsAsFactors = FALSE)

library(dplyr)

united_states <- data %>% 
  filter(country %in% "United States") %>% 
  group_by(sex)
  