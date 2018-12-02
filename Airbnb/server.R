# the server file
library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)

calendar_df <- read.csv("../data/calendar.csv.gz", stringsAsFactors = FALSE)

listings2_df <- read.csv("../data/listings 2.csv", stringsAsFactors = FALSE)

review_df <- read.csv("../data/reviews.csv.gz", stringsAsFactors = FALSE)

shinyServer(function(input,output) {
  output$welcome <- renderText({
    paste0("We want to read a file here")
  })
  
  output$Summary <- renderText({
   paste0("Here is a short summary of our website")
  })
  
  output$neighbourhood <- renderUI ({
    neighbourhood_distinct <- distinct(listings2_df, neighbourhood_group_cleansed, keep_all = FALSE)
    selectInput("neighbourhood_group", "Neighbourhood Group", as.list(select(neighbourhood_distinct, neighbourhood_group_cleansed)))
                
  }) 
  
  # Create the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng = -122.3321, lat = 47.6062, zoom = 12) %>% # Set default view at Seattle 
      addCircles(lng = listings2_df$longitude, lat = listings2_df$latitude, radius = 10, color = "#18BC9C",
                  weight = 3, fillOpacity = 0.9) 
  })
  

})