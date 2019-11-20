suic_state <-
  read.csv("./four_years_state_suicide.csv", stringsAsFactors = FALSE)

install.packages("geojsonio")
install.packages("rgdal")
devtools::install_github("wmurphyrd/fiftystater")

library("rgdal")

library(ggplot2)
library(tidyverse)
library(fiftystater)
library(dplyr)
library(plotly)
install.packages("plotly")



suic_state %>% glimpse()

data("fifty_states")

library(plotly)

set.seed(955)
# Make some noisily increasing data
dat <- data.frame(suic_state,
                  suicide_rate = "X2015",
                  State = "State")

p <- ggplot(dat, aes(x=xvar, y=yvar)) +
  geom_point(shape=1)      # Use hollow circles

p <- ggplotly(p)


g <- ggplot() + geom_polygon(data=fifty_states, aes(x=long, y=lat, group = group),color="white", fill="grey92" ) + 
  geom_point(data=suic_state, aes(x=long, y=lat, colour=X2015)) + 
  scale_size(name="", range = c(2, 20)) + 
  theme_void()

gz <- ggplotly(g, tooltip = c("X2015"))


print(gz)








library(leaflet)
suicide_num <- suic_state$X2015
interactive_map <- leaflet(data = suic_state) %>%
  addTiles() %>% 
  addCircles(
    lat = ~lat,
    lng = ~long,
    popup = ~paste("Year: 2015", "<br>",
                  "Suicide Number: ", suic_state$X2015, "<br>",
                  "State: ", suic_state$State, "<br>"),
    radius = ~suicide_num * 50,
    stroke = FALSE
  )
  
print(interactive_map)
