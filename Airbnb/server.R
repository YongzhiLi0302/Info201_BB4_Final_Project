# the server file
library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)

calendar_df <- read.csv("../data/calendar.csv.gz", stringsAsFactors = FALSE)

listing_df <- read.csv("../data/listings.csv.gz", stringsAsFactors = FALSE)

review_df <- read.csv("../data/reviews.csv.gz", stringsAsFactors = FALSE)

shinyServer(function(input,output) {
  output$welcome <- renderText({
    paste0("We want to read a file here")
  })
  
  output$Summary <- renderText({
   paste0("Here is a short summary of our website")
  })
  
  
  # Create the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng = -122.3321, lat = 47.6062, zoom = 12) # Set default view at Seattle
  })
  

})