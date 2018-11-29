library(shiny)

shinyUI(fluidPage(
  titlePanel("Exploring College Majors"),

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
        tabPanel("Welcome!", p("word cloud")),
        tabPanel("Employment"),
        tabPanel("Wages"),
        tabPanel("Gender"),
        tabPanel("Popularity", plotlyOutput("popularity_plot"), actionButton("toggle", label = "Toggle Legend"))
      )
    )
  )
))
