


suci_state <-
  read.csv("by-state-suicide/row_suicides_1999_2017.csv", stringsAsFactors = FALSE)

library(dplyr)

keep_year <- suci_state %>%
  group_by(State) %>%
  select(State, X2015, X2010, X2005, X2000)

names(keep_year) <- c("State","2015", "2010", "2005", "2000")

