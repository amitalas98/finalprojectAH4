library(dplyr)
data_frame <- read.csv("unemployment-rate.csv", stringsAsFactors = FALSE)
new_data_frame <- data_frame %>% 
  group_by(State, Year) %>% 
  summarize(rate_sum = mean(Rate, na.rm = TRUE))
write.csv(new_data_frame, "umemployment_rate_grouped", row.names = FALSE)
