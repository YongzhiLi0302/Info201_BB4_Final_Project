library(shiny)
library(dplyr)
library(shinyWidgets)
library(shinythemes)
library(leaflet)

listings2_df <- read.csv("../data/listings 2.csv", stringsAsFactors = FALSE)
neighbourhood_distinct <- distinct(listings2_df, neighbourhood_group_cleansed, keep_all = FALSE)

vars <- c(
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
                                    uiOutput("neighbourhood"),
                                    selectInput("color", "Color", vars)
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
                 mainPanel(plotOutput("roomtype"))),
               sidebarLayout(
                 sidebarPanel(tags$h2("Price Range"),
                              tags$h4("Airbnb hosts can set a specific price for their listing properties. Travellers are able to see the price
                                      range in Seattle Airbnb market, so they could predict and adjust their expectations on spending. Hosts/potential hosts are 
                                      welcomed to compare their property price to the market price, and get to know how competitive their prices are, and how much
                                      they could expect to earn on a daily basis."),
                              uiOutput("price"),
                              uiOutput("house_type")),
                 mainPanel(plotOutput("Price"))
                 )),         
             # More information of our app
             navbarMenu("More",
                        tabPanel("Q&A",
                                 tags$h1("About our Dataset"),
                                 p("Our project works with “Inside Airbnb - Adding data to the debate” data set of information created and maintained by Insideairbnb.
                                   Inside Airbnb is a professional and comprehensive data set of classifying the data in Airbnb into hosting ID, room types, neighborhoods, reviews and etc.
                                   This data set includes 86 cities and 602 data files (csv.gz, csv, geojson) around the world. 
                                   The dataset we used in our project is a collection containing an overall summary of all the home listings in Seattle with entire descriptions and other information. 
                                   This data represents the records and the future calendar of each home starts from 10/11/2018-09/13/2019."),
                                 tags$h1("About our Audience and Investigation"),
                                 p("Our target audience would be travelers and property owners. As users of Airbnb in daily life, 
                                   we focused on the deep relationship between users and housing hosts. Airbnb shows a wide variety of accommodation online and has the dataset prepared for a global audience to accommodate their needs.
                                   To travelers who wish to find a place to stay in any city, there’s always a place for everyone.
                                   For travelers, the direction we were interested in is the choice they preferred to make in common situations."),
                                 p("For the property owner, Airbnb provides them with a deep analysis of their performance, which allows them to optimize and earn as much as possible."),
                                 tags$h1("Through the investigation of ours we want to help"),
                                 p("- Using mapping to show specific information about each house"),
                                 p("- The ratio of room types in Seattle"),
                                 p("- The ratio of number of accommodates in Seattle"),
                                 p("- The ratio of house types in Seattle"),
                                 tags$h1("Technical Stuff"),
                                 p("We used a Shiny App to document our investigation and analysis of the data. In most parts,
                                   we used ‘dplyr’, ‘ggplot2’, and ‘leaflet’ to produce the outputs we wanted.
                                   In order to improve our surface much more concise, we created and wrote many datasets and stored them in the repository."),
                                 p("A challenge we faced was creating a map including every housing information inside. This was solved by debugging again and again."),
                                 tags$h1("Link to the data set we used:"),
                                 p("http://insideairbnb.com/get-the-data.html"),
                                 tags$h1("Link to the example we referenced:"),
                                 p("http://insideairbnb.com/seattle/")
                                 ),
                        tabPanel("Contact Us",
                                 tags$h1("Team members"),
                                 p("Yongzhi Li: yongzhi@uw.edu"),
                                 p("Siyao Zhang: siyaoz3@uw.edu"),
                                 p("Vanessa Lin: lint272@uw.edu"),
                                 p("Kairui Liu: liuk25@uw.edu")
                                 )
                        
                        )
             )
  )
)