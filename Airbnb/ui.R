library(shiny)
library(dplyr)
library(shinyWidgets)
library(shinythemes)
library(leaflet)

listings2_df <- read.csv("../data/listings 2.csv", stringsAsFactors = FALSE)
neighbourhood_distinct <- distinct(listings2_df, neighbourhood_group_cleansed, keep_all = FALSE)

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
                      tags$h1("Welcome"),
                      p("We are glad to see you here！At this page, we will guide you through to explore our website.
                        Airbnb in Seattle is your ultimate solution to find/host a Airbnb in Greater Seattle Area.
                        We are an independent, non-commercial set of tools and data that allows you to explore how Aribnb is reallt being used in the city.
                        For travelers, no matter what type of homes you are looking for, there is always a home for you.
                        If you are a host/potential host, feel free to check our website to see what you could expect to be a Superhost!"),
                      tags$h1("Getting Started"),
                      p("With Airbnb in Seattle, you could ask fundamental questions about Airbnb in any neighbourhood or across the city as a whole.
                        Quesitions such as:"),
                      p("- How many listings are there in my neighbourhood and where are they?"),
                      p("- How many hosts are running a business with multiple listings and where they?"),
                      p("The tools are presented simply as a interactive map, dataset with filter and text/plot analysis."),
                      tags$h1("Disclaimer"),
                      p("- This site is nor associated with or endorsed by Airbnb or any of Airbnb's competitors."),
                      p("- The data utilizes public information compiled online including the availibility calendar for 365 in the future,
                        and reviews for each listing. Data is verified, cleansed, analyzed and aggregated"),
                      p("- No private information is being used, including names, photographs, 
                        listings and review details are all publicly displayed on the aribnb site"),
                      p("- Accuracy of the information compiled from the Aribnb site is not the responsibility of 'Airbnb in Seattle'")
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
               sidebarPanel(
                             tags$h2("House Type"),
                             tags$h4("Airbnb hosts can list many types of homes, most common ones are houses and apartments.
                                      Depending on your needs, you could easily see if there are sufficient type of home which you need;
                                      meanwhile, hosts/potential hosts are able to see the competivity of each type of home in their local market.
                                      All the statistics are in percentage(%)"),
                             uiOutput("Neighbor")),
               
               mainPanel(plotOutput("housetype"))),
               sidebarLayout(
                 sidebarPanel(
                              tags$h2("Room Type"),
                              tags$h4("Airbnb hosts can list many different types of rooms, including entire home/apt, private room and shared room.
                                      Depending on your need, you could easily see if there are sufficient type of room which you need;
                                      meanwhile, hosts/potential hosts are able to see the competivity of each type of room in their local market."),
                              uiOutput("Neighbour")
                              ),
                 mainPanel(plotOutput("roomtype")
                 ))),         
             navbarMenu("More",
                        tabPanel("Contact Us"),
                        tabPanel("Q&A", "common questions")
             )
  )
             
  )
  
  
)