library(shiny)
library(leaflet)
# Define server logic for random distribution application
shinyServer(function(input, output) {
  mycities<- read.csv("mycities.csv",stringsAsFactors = FALSE)
  worldcities <- read.csv("worldcities.csv",stringsAsFactors = FALSE)
  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The renderers defined 
  # below then all use the value computed from this expression
  data <- reactive({  
    dat <- mycities[mycities$Year==input$Year,]
    if (input$Region != "Both") dat <- dat[dat$Region==input$Region,]
    df <- data.frame(lat=numeric(),lng=numeric(),popup=character(),stringsAsFactors=FALSE)
    for (i in 1:dim(dat)[1]) {
      temp <- worldcities[worldcities$city_ascii==dat[i,1],]
      temp <- temp[temp$country==dat[i,2],]
      df[i,] <- temp[1,c(3,4,2)]
    }
    df
  })

  output$map <- renderLeaflet({
    leaflet() %>% addTiles() 
  })
  
  observe({
      leafletProxy("map") %>%
      clearGroup("mymarkers") %>%
      addMarkers(lat=data()$lat,lng=data()$lng,popup=data()$popup,
                 clusterOptions = markerClusterOptions(),group="mymarkers"
      )
  })
})