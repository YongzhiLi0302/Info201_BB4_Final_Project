library(shiny)
library(dplyr)
library(shinyWidgets)
library(shinythemes)

library(shiny)
library(dplyr)
library(shinyWidgets)
library(shinythemes)

shinyUI(fluidPage( 
  navbarPage("Aribnb in Seattle",
             theme = shinythemes::shinytheme("slate"),  # <--- Specify theme here
             tabPanel(title = "Home", textOutput("welcome message and getting started")),
             tabPanel(title = "Seattle's Map", sidebarPanel(
               textInput("txt", "Text input:", "text here"),
               sliderInput("slider", "Slider input:", 1, 100, 30),
               actionButton("action", "Button"),
               actionButton("action2", "Button2", class = "btn-primary")
             )),
             tabPanel(title = "Seattle's listing", textOutput("welcome")),
             tabPanel(title = "Seattle's neighbourhoods", textOutput("welcome")),
             tabPanel(title = "Seattle's reviews", textOutput("welcome")),
             navbarMenu("More",
                        tabPanel("Contact Us", textOutput("collaborators info")),
                        tabPanel("Q&A", "some common issues")
             )
  )
)
)

panel1 <- 
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Map", plotOutput("map")),
      tabPanel("Table", plotOutput("table"))))
