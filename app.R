install.packages("shiny") 
library("shiny")  
page_one <- tabPanel(
  "Introduction",
)

page_two <- tabPanel(
  "Background & Research Questions"
)


page_three <- tabPanel(
  "unemployment visualization"
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
  "My Application", 
  page_one,     
  page_two, 
  page_three,
  page_four,
  page_five,
  page_six,
  page_seven
)
my_server <- function(input, output) {
}
shinyApp(ui = my_ui, server = my_server)