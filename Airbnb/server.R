# the server file
library(shiny)
library(ggplot2)
library(dplyr)
shinyServer(function(input,output) {
  output$welcome <- renderText({
    paste0("We want to read a file here")
  })
  output$Summary <- renderText({
   paste0("Here is a short summary of our website")
    
  })

})