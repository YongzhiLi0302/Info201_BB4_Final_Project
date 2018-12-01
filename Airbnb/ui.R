library(shiny)
library(dplyr)
library(shinyWidgets)
library(shinythemes)

shinyUI(fluidPage( 
  navbarPage("Aribnb in Seattle",
             theme = shinythemes::shinytheme("slate"),  # <--- Specify theme here
             tabPanel(title = "Home", textOutput("welcome")),
             tabPanel(title = "Plot", sidebarPanel(
               textInput("txt", "Text input:", "text here"),
               sliderInput("slider", "Slider input:", 1, 100, 30),
               actionButton("action", "Button"),
               actionButton("action2", "Button2", class = "btn-primary")
             )),
             navbarMenu("More",
                        tabPanel("Summary", textOutput("Summary")),
                        tabPanel("Table", "Table tab contents...")
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
