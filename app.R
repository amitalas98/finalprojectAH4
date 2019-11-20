
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(shiny)  

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
  "Suicide Rates Across USA"
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
             page_five
  ),
  page_six,
  page_seven,
  page_eight,
  page_nine
)


my_server <- shinyServer(function(input, output){
  library(ggplot2)
  
  df <- read.csv("unemployment_scatterplot_df.csv", stringsAsFactors = FALSE)
  output$unemploymentPlot <- renderPlotly({
    df = df %>% filter(Year == input$years)
    ggplot(df, aes(x = Suicide.Rate, y = Unemployment.Rate)) + 
      geom_point(aes(text=State))
  })
  
  df2 <- read.csv("income_scatterplot_df.csv", stringsAsFactors = FALSE)
  output$incomePlot <- renderPlotly({
    df2 = df2 %>% filter(Year == input$years2)
    ggplot(df2, aes(x = Suicide.Rate, y = Income)) + 
      geom_point(aes(text=State))

      
  })
  
  df3 <- read.csv("poverty_scatterplot_df.csv", stringsAsFactors = FALSE)
  output$povertyPlot <- renderPlotly({
    df3 = df3 %>% filter(Year == input$years3)
    ggplot(df3, aes(x = Suicide.Rate, y = Poverty.Rate)) + 
      geom_point(aes(text=State))
    
    
  })
  
})

shinyApp(ui = my_ui, server = my_server)