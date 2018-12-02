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
                                    uiOutput("neighbourhood")
                                    )
                      )),
             tabPanel(title = "Analysis", sidebarLayout(
               sidebarPanel( tags$h1("House Type"),
                             tags$h2("Apartment    35%"),
                             tags$h3("  House    33%"),
                             tags$h3("  Others    30%"),
                             tags$h4("Airbnb hosts can list many types of homes, most common ones are houses and apartments.
                                      Depending on the needs of traveller, they could easily see if there are sufficient type of home which they need;
                                      meanwhile, hosts/potential hosts are able to see the competivity of each type of home in their local market.")),
               mainPanel(plotOutput("housetype"))),
               sidebarLayout(
                 sidebarPanel(tags$h1("Room Type"),
                              tags$h2("Entire Home/Apt   74%"),
                              tags$h3("  Private Room    23%"),
                              tags$h3("  Shared Room   1%"),
                              tags$h4("Airbnb hosts can list many different types of rooms, including entire home/apt, private room and shared room.
                                      Depending on the needs of traveller, they could easily see if there are sufficient type of room which they need;
                                      meanwhile, hosts/potential hosts are able to see the competivity of each type of room in their local market.")),
                 mainPanel(plotOutput("roomtype")
                 ))),         
             navbarMenu("More",
                        tabPanel("Contact Us"),
                        tabPanel("Q&A", "common questions")
             )
  )
             
  )
  
  
)