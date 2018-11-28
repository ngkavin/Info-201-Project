library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Exploring College Majors"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectizeInput("select",
        label = "Enter a Major",
        choices = NULL,
        options = list(maxItems = 1, maxOptions = 5, items = NULL, openOnFocus = FALSE)
      )
    ),

    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Welcome!", p("cloud")),
        tabPanel("Employment"),
        tabPanel("Wages"),
        tabPanel("Gender"),
        tabPanel("Popularity")
      )
    )
  )
))
