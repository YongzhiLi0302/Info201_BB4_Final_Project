library(shiny)
library(dplyr)
library(shinyWidgets)
library(shinythemes)
library(leaflet)

vars <- c(
  "Is Superhost?" = "host_is_superhost",
  "House Type" = "property_type",
  "Room Type" = "room_type",
  "Price" = "price",
  "Rating" = "review_scores_rating"
)

shinyUI(fluidPage(
  navbarPage(inverse = F,
             fluid = T,
             theme = shinytheme("flatly"),
             "Aribnb in Seattle",
             
             # introduction of our app
             tabPanel("Home", 
                      p("write introduction here")
             ),
             
             
             # Seattle Map Panel
             tabPanel(title = "Seattle's Map", 
                      div(class="outer",
                       tags$head(
                         # Include custom CSS
                         includeCSS("style.css")
                       ),
                      
                      leafletOutput("map", width = "100%", height = "100%"),
                      
                      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                    draggable = FALSE, top = 60, left = "auto", right = 20, bottom = "auto",
                                    width = "auto", height = "auto",
                                    
                                    h3("Airbnb listings explorer"),
                                    
                                    selectInput("color", "Color", vars),
                                    selectInput("size", "Size", vars, selected = "adultpop"),
                                    conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
                                                     # Only prompt for threshold when coloring or sizing by superzip
                                                     numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
                                    )
                                    )
                      )),
                      
             
             tabPanel(title = "Seattle's listing"),
             
             tabPanel(title = "Seattle's neighbourhoods"),
             
             tabPanel(title = "Seattle's reviews"),
             
             navbarMenu("More",
                        tabPanel("Contact Us"),
                        tabPanel("Q&A", "common questions")
             )
  )
             
  )
  
  
)