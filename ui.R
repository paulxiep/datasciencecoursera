library(shiny)
library(leaflet)
# Define UI for slider demo application
shinyUI(pageWithSidebar(
  
  #  Application title
  headerPanel("My Travel Map for 2013-2017 (Major Cities only)"),
  
  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    "First time loading map will take a while, please be patient! (try refreshing if it doesn't load)",
    radioButtons("Region", "Continent",
                 list("Asia" = "Asia",
                      "Europe" = "Europe",
                      "Both" = "Both")),
    br(),
    sliderInput("Year", "Year", 
                min=2013, max=2017, value=2013, step=1)
  ),
  
  # Show a table summarizing the values entered
  mainPanel(
    tabsetPanel(
      tabPanel("Map",leafletOutput("map")),
      tabPanel("Documentation", p("Simply choose the region and year, the markers for my travel map will display on the map."), 
    p("(Note: I just wanted to try making a map, I know this is useless for you.)"))
    )
    
  )
))