
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
  "unemployment visualization",
  titlePanel("unemployment visualization"),
  br(),br(),br(),br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("years", "years", c("2000", "2005", "2010", "2015"), selected = "2000")
    ),
    mainPanel(
      h3("Primary Content"),
      p("Plots, data tables, etc. would go here"),
      plotlyOutput("unemploymentPlot")
    )
  )
)

page_four <- tabPanel(
  "income visualization"
)

page_five <- tabPanel(
  "Conclusion"
)

page_six <- tabPanel(
  "About the Tech"
)

page_seven <- tabPanel(
  "About Us"
)

my_ui <- navbarPage(
  "AH4", 
  page_one,     
  page_two, 
  page_three,
  page_four,
  page_five,
  page_six,
  page_seven
)


my_server <- shinyServer(function(input, output){
  df <- read.csv("unemployment_scatterplot_df.csv", stringsAsFactors = FALSE)
  library(ggplot2)
  output$unemploymentPlot <- renderPlotly({
    df = df %>% filter(Year == input$years)
    ggplot(df, aes(x = Suicides, y = Unemployment.Rate)) + geom_point(aes(text=State, ))
  })
})

shinyApp(ui = my_ui, server = my_server)