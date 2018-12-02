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
    selectInput("neighbourhood_group", "Neighbourhood Group", c("All", as.list(select(neighbourhood_distinct, neighbourhood_group_cleansed))))
                
  }) 
  
  # Reactive expression for the data subsetted to what the user selected
  filtered_Neighbourhood <- reactive({
    if (input$neighbourhood_group == "All"){
      listings2_df
    } else {
      filter(listings2_df, neighbourhood_group_cleansed == input$neighbourhood_group)
    }
  })
  
  
  # Create the map
  output$map <- renderLeaflet({
    df <- filtered_Neighbourhood()
    leaflet(data = df) %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setMaxBounds(min(df$longitude), min(df$latitude), max(df$longitude), max(df$latitude)) %>%
    # (lng = -122.3321, lat = 47.6062, zoom = 12) %>%  # Set default view at Seattle 
      addCircles(lng = ~longitude, lat = ~latitude, radius = 10, color = "#18BC9C",
               weight = 3, fillOpacity = 0.9)
  })
  
  output$housetype <- renderPlot({
    count_type <- count(listings2_df, property_type)
    other_type <- filter(count_type, property_type != "Apartment" & property_type != "House")
    othersum <- sum(other_type$n)
    plot_table <- filter(count_type,property_type == "Apartment" | property_type == "House")
    plot_table$property_type <- as.character(plot_table$property_type)
    plot_table <- rbind(plot_table, "3" = c("Others", othersum))
    plot_table$n <- as.numeric(plot_table$n)
    plot_table = mutate(plot_table, sum_percent = n / sum(n) * 100)
    plot_table$sum_percent <- as.integer(plot_table$sum_percent)
    ggplot(plot_table, aes(property_type, sum_percent)) + 
      geom_bar(stat = "identity", width = 0.4, color = "white", fill = "cadetblue", size = 3) +
      theme_set(theme_gray()) + 
      geom_text(label = plot_table$sum_percent) +
      labs(x = "House Types", y = "Percentage(%)", subtitle = "House Types in Seattle Airbnb Market")
  }) 
  output$roomtype <- renderPlot({
    room_type <- count(listings2_df, room_type)
    room_type = mutate(room_type, percent = n / sum(n) * 100)
    room_type$percent <- as.integer(room_type$percent)
    room_type$room_type <- as.character(room_type$room_type)
    ggplot(room_type, aes(room_type, percent)) +
      geom_bar(stat = "identity", width = 0.4, color = "white", fill = "cadetblue", size = 3) +
      theme_set(theme_gray()) +
      geom_text(label = room_type$percent) +
      labs(x = "Room Type", y = "Percentage(%)", subtitle = "Room Types in Seattle Airbnb Market")
  })  

})
