
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(shiny)  


page_ten_for_state_suicide <- tabPanel(
  "State Suicide Number",
  titlePanel("Suicide number in each State"),
  br(),br(),br(),br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("year4", "years", c("2000", "2005", "2010", "2015"), selected = "2000")
    ),
    mainPanel(
      h3("Map of suicide numbers in each State"),
      leafletOutput("suicidenum")
    )
  )
)

my_server <- shinyServer(function(input, output){
  df4 <- read.csv("new_suic_state.csv", stringsAsFactors = FALSE)
  output$suicidenum <- renderLeaflet({
    leaflet() %>%
    addProviderTiles(providers$Stamen.TonerLite,
                     options = providerTileOptions(noWrap = TRUE)
    ) %>%
    addMarkers(data = points())
  })
  
    df4 = df4 %>% filter(Year == input$years4)
    ggplot(df4, aes(x = Suicide.Rate, y = Unemployment.Rate)) + 
      geom_point(aes(text=State))
    
    output$suicidenum <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(providers$Stamen.TonerLite,
                         options = providerTileOptions(noWrap = TRUE)
        ) %>%
        addMarkers(data = points())
    })
  })
  
})

shinyApp(ui = my_ui, server = my_server)

#load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(leaflet.extras)
#import data
data <- read.csv("by-state-suicide/new_suic_state.csv")

ui <- fluidPage(
  mainPanel( 
    #this will create a space for us to display our map "2000", "2005", "2010", "2015"
    leafletOutput(outputId = "mymap"), 
    #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
    absolutePanel(top = 60, left = 20, 
                  checkboxInput("X2000", "2000", FALSE),
                  checkboxInput("X2005", "2005", FALSE), 
                  checkboxInput("X2010", "2010", FALSE),
                  checkboxInput("X2015", "2015", FALSE)
    )
  ))

server <- function(input, output, session) {
  #define the color pallate for the magnitidue of the earthquake
  pal <- colorNumeric(
    palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
    domain = data$X2000)
  #define the color pallate for the magnitidue of the earthquake
  pal2 <- colorNumeric(
    palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
    domain = data$X2005)
  #define the color pallate for the magnitidue of the earthquake
  pal3 <- colorNumeric(
    palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
    domain = data$X2010)
  #define the color pallate for the magnitidue of the earthquake
  pal4 <- colorNumeric(
    palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
    domain = data$X2015)
  
  #create the map
  output$mymap <- renderLeaflet({
    leaflet(data) %>% 
      setView(lng = -99, lat = 45, zoom = 2)  %>% #setting the view over ~ center of North America
      addTiles() %>% 
      addCircles(data = data, lat = ~lat, lng = ~long, weight = 1, radius = ~data$X2000 * 50, popup = ~as.character(X2000), 
                 label = ~as.character(~paste("Year: 2015", "<br>",
                                              "Suicide Number: ", data$X2000, "<br>",
                                              "State: ", data$State, "<br>")), 
                 color = ~pal(X2000), fillOpacity = 0.5)
  })
  
  #next we use the observe function to make the checkboxes dynamic. If you leave this part out you will see that the checkboxes, when clicked on the first time, display our filters...But if you then uncheck them they stay on. So we need to tell the server to update the map when the checkboxes are unchecked.
  observe({
    proxy <- leafletProxy("mymap", data = data)
    proxy %>% clearMarkers()
    if (input$X2000) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2000), fillOpacity = 0.5, 
                                 label = ~as.character(~paste("Year: 2015", "<br>",
                                                              "Suicide Number: ", data$X2000, "<br>",
                                                              "State: ", data$State, "<br>"))) %>%
        addLegend("bottomright", pal = pal, values = data$X2000,
                  title = "Suicde Num in 2000",
                  opacity = 1)}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })
  
  observe({
    proxy <- leafletProxy("mymap", data = data)
    proxy %>% clearMarkers()
    if (input$X2005) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2005), fillOpacity = 0.5, 
                                 label = ~as.character(~paste("Year: 2015", "<br>",
                                                              "Suicide Number: ", data$X2005, "<br>",
                                                              "State: ", data$State, "<br>"))) %>%
        addLegend("bottomright", pal = pal, values = data$X2005,
                  title = "Suicde Num in 2005",
                  opacity = 1)}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })
  
  observe({
    proxy <- leafletProxy("mymap", data = data)
    proxy %>% clearMarkers()
    if (input$X2010) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2010), fillOpacity = 0.5, 
                                 label = ~as.character(~paste("Year: 2015", "<br>",
                                                              "Suicide Number: ", data$X2010, "<br>",
                                                              "State: ", data$State, "<br>"))) %>%
        addLegend("bottomright", pal = pal, values = data$X2010,
                  title = "Suicde Num in 2010",
                  opacity = 1)}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })
  
  observe({
    proxy <- leafletProxy("mymap", data = data)
    proxy %>% clearMarkers()
    if (input$X2015) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2015), fillOpacity = 0.5, 
                                 label = ~as.character(~paste("Year: 2015", "<br>",
                                                              "Suicide Number: ", data$X2015, "<br>",
                                                              "State: ", data$State, "<br>"))) %>%
        addLegend("bottomright", pal = pal, values = data$X2015,
                  title = "Suicde Num in 2015",
                  opacity = 1)}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })
  
}
