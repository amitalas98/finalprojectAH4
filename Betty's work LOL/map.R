suic_state <-
  read.csv("by-state-suicide/four_years_state_suicide.csv", stringsAsFactors = FALSE)

new_suic_state <- suic_state %>% 
  filter(State != "District of Columbia")

write.csv(new_suic_state, "new_suic_state.csv")

library(ggplot2)
library(dplyr)
library(leaflet)

interactive_map_2015 <- leaflet(data = new_suic_state) %>%
  addTiles() %>% 
  addCircles(
    lat = ~lat,
    lng = ~long,
    popup = ~paste("Year: 2015", "<br>",
                  "Suicide Number: ", new_suic_state$X2015, "<br>",
                  "State: ", new_suic_state$State, "<br>"),
    radius = ~new_suic_state$X2015 * 50,
    stroke = FALSE
  )
  
interactive_map_2010 <- leaflet(data = new_suic_state) %>%
  addTiles() %>% 
  addCircles(
    lat = ~lat,
    lng = ~long,
    popup = ~paste("Year: 2010", "<br>",
                   "Suicide Number: ", new_suic_state$X2010, "<br>",
                   "State: ", new_suic_state$State, "<br>"),
    radius = ~new_suic_state$X2010 * 50,
    stroke = FALSE
  )

interactive_map_2005 <- leaflet(data = new_suic_state) %>%
  addTiles() %>% 
  addCircles(
    lat = ~lat,
    lng = ~long,
    popup = ~paste("Year: 2005", "<br>",
                   "Suicide Number: ", new_suic_state$X2005, "<br>",
                   "State: ", new_suic_state$State, "<br>"),
    radius = ~new_suic_state$X2005 * 50,
    stroke = FALSE
  )

interactive_map_2000 <- leaflet(data = new_suic_state) %>%
  addTiles() %>% 
  addCircles(
    lat = ~lat,
    lng = ~long,
    popup = ~paste("Year: 2000", "<br>",
                   "Suicide Number: ", new_suic_state$X2000, "<br>",
                   "State: ", new_suic_state$State, "<br>"),
    radius = ~new_suic_state$X2000 * 50,
    stroke = FALSE
  )
