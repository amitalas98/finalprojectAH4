library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)

df1 <- read.csv("by-state-suicide/col_suicides_1999_2017.csv", stringsAsFactors = FALSE)
df2 <- read.csv("by-state-povery-rate/povertypercentagebystate.csv", stringsAsFactors = FALSE)
df3 <- read.csv("populations.csv", stringsAsFactors = FALSE)

df3 <- df3 %>%
  select(State, "X2015", "X2010", "X2005", "X2000")

newnames = c("2015", "2010", "2005", "2000")
oldnames = c("X2015", "X2010", "X2005", "X2000")
for(i in 1:5) names(df3)[names(df3) == oldnames[i]] = newnames[i]
for(i in 1:5) names(df2)[names(df2) == oldnames[i]] = newnames[i]

df3 <- df3 %>% gather(Year, Population, -State)
df2 <- df2 %>% gather(Year, Poverty.Rate, -State)

df3[, "Year"] <- sapply(df3[, "Year"], as.numeric)
df2[, "Year"] <- sapply(df2[, "Year"], as.numeric)

together_df <- df2 %>% 
  left_join(df1, by = c('State', 'Year')) %>%
  left_join(df3, by = c('State', 'Year')) %>%
  mutate(Suicide.Rate = round((Deaths / Population)*100, 4)) %>% 
  filter(State != "District of Columbia") %>% 
  filter(Year == "2000" | Year == "2005" | Year == "2010" | Year == "2015")
write.csv(together_df, "poverty_scatterplot_df.csv")
