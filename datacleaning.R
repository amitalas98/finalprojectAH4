# Initial Data Cleaning

# Set Working Directory
setwd("~/Github/finalprojectAH4/by-state-suicide")

# Load libraries
library("dplyr")
library("tidyr")

#Read original suicide dataset
suicides_1999_2017 <- read.csv(file = "1999_2017_US.csv",
                               stringsAsFactors = FALSE)

# Filtering for relevant information
#Years in row format
cleaned_suicides_1999_2017 <- suicides_1999_2017 %>%
  filter(Cause.Name == "Suicide" & State != "United States") %>%
  select(Year, Cause.Name, State, Deaths) %>%
  spread(Year, Deaths, convert = FALSE)

#Years in column format
cleaned2_suicides_1999_2017 <- suicides_1999_2017 %>%
  filter(Cause.Name == "Suicide" & State != "United States") %>%
  select(Year, Cause.Name, State, Deaths)

#Export data to an excel file
write.csv(cleaned_suicides_1999_2017, "row_suicides_1999_2017.csv")
write.csv(cleaned2_suicides_1999_2017, "col_suicides_1999_2017.csv")

#Checking exported datasets
df <- read.csv(file = "row_suicides_1999_2017.csv", stringsAsFactors = FALSE)
df2 <- read.csv(file = "col_suicides_1999_2017.csv", stringsAsFactors = FALSE)
View(df)
View(df2)