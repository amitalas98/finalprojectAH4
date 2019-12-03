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
      p("The stakeholders in the problem of suicide in the United States
      is everyone and especially those suffering with a mental illness.
      The setting of this problem stems from many factors of the contemporary
      world including unemployment, income, and profession. Excess pressure
      from any of these categories can push someone into a depression and,
      depending on the course of events after that,
      lead to self harm or death. Up until recent years, mental health and
      treatment has been far from normalized so policies and ethics around
      it are still fairly new as children and adults seek treatment.
      This can pose a challenge that people do not feel extremely comfortable
      seeking help for their mental needs and can lead
      to many people suffering alone. Society and social media in the
      United States especially today rides on a key value of appearing
      as if life is perfect, mental health and make them feel outcasted
      or ashamed if they feel different."),
      h3("2. What is the Problem?"),
      p("The problem is the continuous rising of suicide rates in the
        United States and the disparities between the rates in each of the
        states.
        In addition, this exposes the problem with mental health care and
        intervention to those who have suicidal tendencies in the United
        States. Idaho has some of the highest rate growth from 1985-2015
        while Nevada has gone down 1%."),
      h3("3. Why does it matter?"),
      p("This matters because the trend of people committing suicide
        has been rising in the United States, this means more lives are being
        lost and could of been prevented. This also matters because it affects
        a lot of people around us and the country, especially in a
        stress-filled university like the UW.
        Moreover, preventing suicide will also promote positive energy
        in society and contribute
        to overall healthy growth for years to come."),
      h3("4. How it Will Be Addressed?"),
      p("We will address this issue by proposing an education program
         implementation into schools across the United States to better
         educate, normalize, and help children, teens, and young adults
         about suicide, depression, and handling their mental health.
         This will help to lessen suicide attempts of young people and
         prepare the future generations of adults to seek help and
         spend time with their mental health issues. To help adults in
         the USA, we propose work time seminar that will teach and help the
         employees of companies about the importance of their mental health
         and what to do in crisis situations.")
    )
  )
)

page_two <- tabPanel(
  "Background & Research Questions",
  titlePanel("Background & Research Questions"), br(), br(),
  strong("Background:"), br(), br(),
  p("Suicide has been and will be an evergoing problem throughout each year in
    the United States. This is a very serious topic that needs to be better
    addressed through out the country since data shows that suicide rates
    are increasing. With the information gathered by the CDC and the US Census
    Bureau it is apparent that this problem is very present in each state and
    affects a lot of people. It is hard to pinpoint the exact cause of someone
    taking their life but it is known that excess stress can be a reason
    someone doesn't want to be alive anymore. Especially in the capitalist
    nature of the United States problems related to money, jobs, and how
    comfortably you can live your life is a growing issue throughout
    each state as the middle class begins to disappear and living costs rise."
  ),
  br(), br(),
  strong("Research Question 1:"),
  br(),
  p("How do factors like unemployment rates and poverty
    percentage contribute to each state's suicide rate in
    2000, 2005, 2010, and 2015?"), br(), br(),
  strong("Research Question 2:"),
  p("How does trends of suicide rates look for each state and what
      have been the trends from 2000 to 2015?")
)

page_three <- tabPanel(
  "Unemployment",
  titlePanel("Unemployment vs Suicide Rate"),
  br(), br(), br(), br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("years", "years", c("2000", "2005",
                   "2010", "2015"), selected = "2000")
    ),
    mainPanel(
      h3("Scatterplot of Unemployment vs Suicide Rate per State"),
      plotlyOutput("unemployment_plot")
    )
  )
)

page_four <- tabPanel(
  "Income",
  titlePanel("Income vs Suicide Rate"),
  br(), br(), br(), br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("years2", "years", c("2000", "2005", "2010", "2015"),
                   selected = "2000")
    ),
    mainPanel(
      h3("Scatterplot of Income vs Suicide Rate"),
      plotlyOutput("income_plot")
    )
  )
)

page_five <- tabPanel(
  "Poverty",
  titlePanel("Poverty vs Suicide Rate"),
  br(), br(), br(), br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("years3", "years", c("2000", "2005", "2010", "2015"),
                   selected = "2000")
    ),
    mainPanel(
      h3("Scatterplot of Poverty vs Suicide Rate"),
      plotlyOutput("poverty_plot")
    )
  )
)


page_six <- tabPanel(
  "Suicide Number Across America",
  titlePanel("Suicide Number Across America"),
  br(), br(), br(), br(),
  mainPanel(
    #this will create a space for us to display our
    #map "2000", "2005", "2010", "2015"
    leafletOutput(outputId = "mymap"),
    #this allows me to put the checkmarks ontop of the
    #map to allow people to view
    #earthquake depth or overlay a heatmap
    absolutePanel(top = 60, left = 20,
                  checkboxInput("X2000", "2000", FALSE),
                  checkboxInput("X2005", "2005", FALSE),
                  checkboxInput("X2010", "2010", FALSE),
                  checkboxInput("X2015", "2015", FALSE)
    )
  )
)


page_seven <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion"),
  p("For research about the correlation between unemployment percent and suicide rate from 2000 to 2015, 
    we conclude that this is a weak to no correlation trend through each year. From our data we cannot 
    state if there is a definite relation because of the randomness of the points (no linear trend line). 
    This is why we can begin to conclude that one's unemployment status depending on the state and throughout each year, 
    does not have a causation nor correlation to suicide.",
    p("For research about the correlation between income and suicide rates from 2000 to 2015, 
    we conclude that these trends are weak to medium correlation for each year. In the scatterplot 
    of 2005 and 2010, the trend line is a negative slope which confirms the correlation that the 
    higher salary of a state leads to fewer suicides. In 2000 and 2015, there is less of a correlation 
    and it is difficult to see a real trend with the data. Hence, we can begin to conclude that one's income depending on the state and throughout each year, does not 
    have a clear direct causation but it is possible because there is a correlation for some years."),
    p("For research about the correlation between poverty and suicide rate from 2000 to 2015, we conclude 
    that these trends are weak to medium correlation for each year. In the scatterplot of 2000, 2005, 
    and 2015 we discovered there is a slight correlation of the higher percentage of poverty to suicide. 
    In 2010, there is less of a correlation so there is hard to see a concrete trend through each year. 
    This is why we can begin to conclude that the poverty rate of the state depending on the year, does 
    not have a clear direct causation but it is possible because there is a correlation for some years."),
    p("To answer our research question, no there is not a directly relating causation factor from the 
    social-economic factors we analyzed in our project. With more years added and the diversion of 
    counties/cities, we believe we could get more concrete conclusions on the effect of these factors 
    on the suicide rates."),
    p("For the research about the trends of suicide by state from the years 2000 to 2015, 
    we conclude that the suicide rate is going up in almost every state from 2000 to 2015. 
    We can see the circles that show on the map become bigger and bigger and the color become darker. 
    These both show the increase of suicide number per state.")
  )
)

page_eight <- tabPanel(
  "About the Tech",
  titlePanel("About the tech"),
  p("We loaded all of our data sets through csv files and
    reading it into R. The major libraries
    of data we used were the CDC, US Department of Labor's
    Bureau of Labor Statistics, and Census Bureau
    . We organized our code by csv files pertaining to
    the subject and section of our Shiny App. We hope
    to be answering the questions of correlation between different
    variables in a person's life and the
    rate of suicide depending on those variable. Our
    shiny app is comprised tabs including an introduction
    to express the background and research questions, our 4
    visualizations, a conclusion, the technology we
    used, and a page about our group. For the 3 scatter plot
    graphs, we are comparing one social-economic
    (income, poverty, and unemployment) to the number of
    suicide per state for the years 2000, 2005, 2010,
    and 2015. To take information from the user shiny
    displays a radio button box with each of the years
    and displays the appropriate data on a scatter plot
    for each. To create these graphs we used ggplot
    and to make them interact (displaying the appropriate
    state, suicide rate, and manipulated factor)
    we used plotly. For the interactive map, we use a map
    of the United States that is divided by states
    and we put circles, which have distinct sizes
    and colors, to define the difference between the number
    of people that commit sucide in each state.
    The bigger the circle means there are more people commit
    suicide in the State. And we also provide the data for
    4 different year, which are 2000, 2005, 2010,
    and 2015. Taking information from the user shiny
    displays checkboxes with each of the years and displays
    the appropriate data on map. We want to make users be able
    to compare different years, so we choose to use
    checkbox, however, we are still finding ways to make it work,
    so far users can only use checkbox like radio
    button box, the map will only show the data of one year.
    By creating the map, we used leaflet."

  ),
  a("Technical Report", href =
    "https://github.com/amitalas98/finalprojectAH4/wiki/P2-Technical-Report")
)

page_nine <- tabPanel(
  "About Us",
  titlePanel("About Us"),
  strong("Our group is made up of Adrianna Mitalas,
         Kevin Hu, William Yu, and Betty Kao"),
  p("I am Kevin(Bobin) from Hangzhou, China. I am a
    sophomore at UW, currently trying to major in ACMS.
    Info201 teaches me to analyze data by coding in R.
    This would help me in the future when I need to
    gain insights from data. In my free time, I like
    travelling and playing sports."),
  p("Hi I'm Adrianna and I'm a junior from Seattle
    in the Public Health - Global Health Major
    and Informatics Minor. My favorite thing about
    INFO 201 is having the collaborative work
    environment of the class and meeting my awesome
    group mates. In my free time I like to
    cook, play video games, and watch horror movies on Netflix."),
  p("Hey~~~This is Betty. I'm a sophomore from Taiwan.
    My intended majors are informatics
    and Computer Science. INFO 201 makes me learn a
    lot and meet some amazing people, such
    as my group mates. In my free time,
    I like to sing, sleep, hang out with friends, play
    volleyball and soccer. "),
  p("Hi, my name is William and I'm an exchange student
    from Sydney, Australia. Currently,
    I am a junior at the Foster School of Business Finance
    Major. I enjoy travelling, talking to new people and
    trying new things. One of my passions is cooking (who doesn't like
    Gordon Ramsay?) and playing the cello. INFO201 has been an
    exciting but homework intensive course. I have learnt a lot about R
    and its capabilities. Data is everywhere and I am glad that I took
    this course.")
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

my_server <- shinyServer(function(input, output) {
  library(ggplot2)

  df <- read.csv("unemployment_scatterplot_df.csv", stringsAsFactors = FALSE)
  output$unemployment_plot <- renderPlotly({
    df <- df %>% filter(Year == input$years)
    ggplot(df, aes(y = Suicide.Rate, x = Unemployment.Rate)) +
      geom_point(aes(text = State)) + geom_smooth() +
      xlab("Unemployment Rate (% of individuals unemployed per state)") +
      ylab("Suicide Rate (% of suicides per state)")
  })

  df2 <- read.csv("income_scatterplot_df.csv", stringsAsFactors = FALSE)
  df2$Income <- as.numeric(gsub(",", "", df2$Income))
  output$income_plot <- renderPlotly({
    df2 <- df2 %>% filter(Year == input$years2)
    ggplot(df2, aes(y = Suicide.Rate, x = Income)) +
      geom_point(aes(text = State)) + geom_smooth() +
      xlab("Income ($ Median Income per State)") +
      ylab("Suicide Rate (% of suicides per state)")
  })
  df3 <- read.csv("poverty_scatterplot_df.csv", stringsAsFactors = FALSE)
  output$poverty_plot <- renderPlotly({
    df3 <- df3 %>% filter(Year == input$years3)
    ggplot(df3, aes(y = Suicide.Rate, x = Poverty.Rate)) +
      geom_point(aes(text = State)) + geom_smooth() +
      xlab("Poverty Rate (% of individuals living under poverty line per state)") + 
      ylab("Suicide Rate (% of suicides per state)")
  })
  #define the color pallate
  data <- read.csv("by-state-suicide/new_suic_state.csv")
  pal <- colorNumeric(
    palette = c("gold", "orange", "dark orange", "orange red", "red",
                "dark red"),
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
    proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2000),
                                 fillOpacity = 0.5,
                                 popup = paste("Year: 2000", "<br>",
                                               "Suicide Number: ",
                                               data$X2000, "<br>",
                                               "State: ", data$State), radius
                                 = ~data$X2000 * 0.005)
    }
    if (input$X2005) {
    proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2005),
                                 fillOpacity = 0.5,
                                 popup = paste("Year: 2005", "<br>",
                                               "Suicide Number: ", data$X2005,
                                               "<br>",
                                               "State: ", data$State, "<br>"),
                                 radius = ~data$X2005 * 0.005)
    }
    if (input$X2010) {
    proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2010),
                                 fillOpacity = 0.5,
                                 popup = paste("Year: 2010", "<br>",
                                               "Suicide Number: ", data$X2010,
                                               "<br>",
                                               "State: ", data$State, "<br>"),
                                 radius = ~data$X2010 * 0.005)
    }
    if (input$X2015) {
    proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal(X2015),
                                 fillOpacity = 0.5,
                                 popup = paste("Year: 2015", "<br>",
                                               "Suicide Number: ", data$X2015,
                                               "<br>",
                                               "State: ", data$State, "<br>"),
                                 radius = ~data$X2015 * 0.005)
    }
  })
})

shinyApp(ui = my_ui, server = my_server)
