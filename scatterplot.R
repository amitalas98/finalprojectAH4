
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)


# missing georgia, florida, alaska, DC
df1 <- read.csv("by-state-suicide/col_suicides_1999_2017.csv", stringsAsFactors = FALSE)
df2 <- read.csv("umemployment_rate_grouped.csv", stringsAsFactors = FALSE)

together_df <- df2 %>% 
  left_join(df1, by = c('State', 'Year')) %>%
  mutate(Unemployment.Rate = round(rate_sum,2),
         Suicides = Deaths) %>% 
  filter(Year == "2000" | Year == "2005" | Year == "2010" | Year == "2015")

write.csv(together_df, "unemployment_scatterplot_df.csv")

