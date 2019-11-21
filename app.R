library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(shiny)
library(leaflet)
library(shiny)  
library(scales)
page_one <- tabPanel(
  "Introduction"
)

page_two <- tabPanel(
  "Background & Research Questions"
)

page_three <- tabPanel(
  "Unemployment",
  titlePanel("Unemployment vs Suicide Rate"),
  br(),br(),br(),br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("years", "years", c("2000", "2005", "2010", "2015"), selected = "2000")
    ),
    mainPanel(
      h3("Scatterplot of Unemployment vs Suicide Rate per State"),
      plotlyOutput("unemploymentPlot")
    )
  )
)


page_four <- tabPanel(
  "Income",
  titlePanel("Income vs Suicide Rate"),
  br(),br(),br(),br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("years2", "years", c("2000", "2005", "2010", "2015"), selected = "2000")
    ),
    mainPanel(
      h3("Scatterplot of Income vs Suicide Rate"),
      plotlyOutput("incomePlot")
    )
  )
)
page_five <- tabPanel(
  "Poverty",
  titlePanel("Poverty vs Suicide Rate"),
  br(),br(),br(),br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("years3", "years", c("2000", "2005", "2010", "2015"), selected = "2000")
    ),
    mainPanel(
      h3("Scatterplot of Poverty vs Suicide Rate"),
      plotlyOutput("povertyPlot")
    )
  )
)


page_six <- tabPanel(
  "Suicide Number Across America",
  titlePanel("Suicide Number Across America"),
  br(),br(),br(),br(),
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
    )
  )


page_seven <- tabPanel(
  "Conclusion"
)

page_eight <- tabPanel(
  "About the Tech"
)

page_nine <- tabPanel(
  "About Us"
)


my_ui <- navbarPage(
  "AH4", 
  page_one,     
  page_two, 
  navbarMenu("Visualizations",
             page_three,
             page_four,
             page_five,
             page_six
  ),
  page_seven,
  page_eight,
  page_nine
)


my_server <- shinyServer(function(input, output){
  library(ggplot2)
  
  df <- read.csv("unemployment_scatterplot_df.csv", stringsAsFactors = FALSE)
  output$unemploymentPlot <- renderPlotly({
    df = df %>% filter(Year == input$years)
    ggplot(df, aes(y = Suicide.Rate / 100, x = Unemployment.Rate / 100)) + 
      geom_point(aes(text=State)) + geom_smooth() + scale_x_continuous(labels = percent) + scale_y_continuous(labels = percent)
  })
  
  df2 <- read.csv("income_scatterplot_df.csv", stringsAsFactors = FALSE)
  df2$Income <- as.numeric(gsub(",", "", df2$Income))
  output$incomePlot <- renderPlotly({
    df2 = df2 %>% filter(Year == input$years2)
    ggplot(df2, aes(y = Suicide.Rate / 100, x = Income)) + 
      geom_point(aes(text=State)) + geom_smooth() + scale_x_continuous(labels = dollar) + scale_y_continuous(labels = percent) 
    
    
  })
  
  df3 <- read.csv("poverty_scatterplot_df.csv", stringsAsFactors = FALSE)
  output$povertyPlot <- renderPlotly({
    df3 = df3 %>% filter(Year == input$years3)
    ggplot(df3, aes(y = Suicide.Rate / 100, x = Poverty.Rate / 100)) + 
      geom_point(aes(text=State)) + geom_smooth() + scale_x_continuous(labels = percent) + scale_y_continuous(labels = percent)
    
    
  })
  
  #define the color pallate
  data <- read.csv("by-state-suicide/new_suic_state.csv")
  pal <- colorNumeric(
    palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
    domain = data$X2015)
  
  #create the map
  output$mymap <- renderLeaflet({
    leaflet(data) %>% 
      addTiles() %>% 
      addCircleMarkers(data = data, lat = ~lat, lng = ~long, weight = 1, 
                 radius = data$X2000 * 0.005,
                 color = ~pal(X2015), fillOpacity = 0.5)  %>%
      addLegend("bottomright", pal = pal, values = data$X2015,
                title = "Suicde Num Scale",
                opacity = 1)
  })
  
  observe({
    proxy <- leafletProxy("mymap", data = data)
    proxy %>% clearMarkers()
    if (input$X2000) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2000), fillOpacity = 0.5, 
                                popup = paste("Year: 2000", "<br>",
                                              "Suicide Number: ", data$X2000, "<br>",
                                              "State: ", data$State),radius = ~data$X2000 * 0.005)
    } else if (input$X2005) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2005), fillOpacity = 0.5, 
                                 popup = paste("Year: 2005", "<br>",
                                                "Suicide Number: ", data$X2005, "<br>",
                                                "State: ", data$State, "<br>"), radius = ~data$X2005 * 0.005)
    } else if (input$X2010) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2010), fillOpacity = 0.5, 
                                 popup = paste("Year: 2010", "<br>",
                                                "Suicide Number: ", data$X2010, "<br>",
                                                "State: ", data$State, "<br>"), radius = ~data$X2010 * 0.005)
    } else if (input$X2015) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2015), fillOpacity = 0.5, 
                                 popup = paste("Year: 2015", "<br>",
                                                "Suicide Number: ", data$X2015, "<br>",
                                                "State: ", data$State, "<br>"), radius = ~data$X2015 * 0.005) 
    }
  })
  
})

shinyApp(ui = my_ui, server = my_server)