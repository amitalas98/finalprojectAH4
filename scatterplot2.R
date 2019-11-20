
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)

df1 <- read.csv("by-state-suicide/col_suicides_1999_2017.csv", stringsAsFactors = FALSE)
df2 <- read.csv("by-state-income/incomeforfinalproject.csv", stringsAsFactors = FALSE)

df2 <- df2 %>%
  select(State, "X2015", "X2010..37.", "X2005", "X2000..30.")
newnames <- c("2015", "2010", "2005", "2000")
oldnames2 = c("X2015", "X2010..37.", "X2005", "X2000..30.")
  for(i in 1:5) names(df2)[names(df2) == oldnames2[i]] = newnames[i]

df2 <- df2 %>% 
  slice(3:53) %>% 
  gather(Year, Income, -State)

df2[, "Year"] <- sapply(df2[, "Year"], as.numeric)

df1 <- df1 %>% 
  filter(Year == "2000" | Year == "2005" | Year == "2010" | Year == "2015")

together_df <- df2 %>%
  left_join(df1, by = c('State', 'Year')) %>% 
  mutate(Suicides = Deaths)

write.csv(together_df, "income_scatterplot_df.csv")