library(tidyverse)
library(lubridate)
library(tsibble)
library(tsibbledata)
library(fable)
library(leaflet)
library(shiny)

nyc_bikes <- nyc_bikes %>% 
  mutate(date = date(start_time))

bike_ids <- nyc_bikes %>% 
  distinct(bike_id)

bike_journey <- nyc_bikes %>% 
  distinct(date)

ui <-bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                uiOutput("bikes"),
                uiOutput("journey_filtered")
                
                
  )
)



server <- function(input, output){
  output$bikes <- renderUI({ selectInput("bike","Select bike", bike_ids)
  })
  
  filtered_bikes <- reactive({
    req(input$bike) 
    nyc_bikes %>% 
      filter(bike_id == input$bike) 
  })

 
  
  available <- reactive({
    req(input$bike) 
    nyc_bikes %>% 
      filter(bike_id == input$bike) %>% 
      distinct(date)
  })
  
  output$journey_filtered <- renderUI({selectInput("journeys", "Select Day", available())})
  

  
  output$map <- renderLeaflet({
    req(input$bike) 
    req(input$journeys)
nyc_bikes%>% 
      filter(bike_id == input$bike) %>% 
      filter(date == input$journeys) %>% 
    leaflet() %>% 
      addTiles() %>%
      addAwesomeMarkers(lng = ~start_long,
                 lat = ~start_lat, 
                 label = "start",
                 icon = list(
                   markerColor = "green"), clusterOptions = markerClusterOptions()) %>% 
      addAwesomeMarkers(lng = ~end_long,
                         lat = ~end_lat, 
                        label = "end",
                         icon = list(
                           markerColor = "blue"), clusterOptions = markerClusterOptions())
  })
}

shinyApp(ui, server)