library(shiny)
suppressMessages(library(dplyr))
print(getwd())

majors_list <- read.csv("data/majors-list.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  
  updateSelectInput(session, "select", choices = majors_list$Major)
  
  
})
