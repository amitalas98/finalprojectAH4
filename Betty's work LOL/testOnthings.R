
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



library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(shiny)
library(leaflet)
library(shiny)  
library(scales)
page_one <- tabPanel(
  "Introduction", 
  mainPanel(
    div(
      h3("1. Problem Situation:"),
      p("The stakeholders in the problem of suicide in the United States is everyone
      and especially those suffering with a mental illness. The setting of this 
      problem stems from many factors of the contemporary world including unemployment, 
      income, and profession. Excess pressure from any of these categories can push 
      someone into a depression and, depending on the course of events after that, 
      lead to self harm or death. Up until recent years, mental health and treatment 
      has been far from normalized so policies and ethics around it are still fairly 
      new as children and adults seek treatment. This can pose a challenge that people 
      do not feel extremely comfortable seeking help for their mental needs and can lead 
      to many people suffering alone. Society and social media in the United States especially 
      today rides on a key value of appearing as if life is perfect, 
      flawless, and effortless; this can directly contribute to someone’s 
      mental health and make them feel outcasted or ashamed if they feel different."),
      h3("2. What is the Problem?"),
      p("The problem is the continuous rising of suicide rates in the United States 
      and the disparities between the rates in each of the states. 
      In addition, this exposes the problem with mental health care and intervention
      to those who have suicidal tendencies in the United States. Idaho has some of the
      highest rate growth from 1985-2015 while Nevada has gone down 1%."),
      h3("3. Why does it matter?"),
      p("This matters because the trend of people committing suicide 
      has been rising in the United States, this means more lives are being lost 
      and could of been prevented. This also matters because it affects a lot of people 
      around us and the country, especially in a stress-filled university like the UW. 
      Moreover, preventing suicide will also promote positive energy in society and contribute 
      to overall healthy growth for years to come."), 
      h3("4. How it Will Be Addressed?"),
      p("We will address this issue by proposing an education program implementation 
      into schools across the United States to better educate, normalize, and help children, 
      teens, and young adults about suicide, depression, and handling their mental health. 
      This will help to lessen suicide attempts of young people and prepare the future 
      generations of adults to seek help and spend time with their mental health issues. 
      To help adults in the USA, we propose work time seminar that will teach and help the
      employees of companies about the importance of their mental health and what to do in crisis situations.")
    )
  )
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






























