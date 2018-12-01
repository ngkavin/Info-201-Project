library(plotly)
library(shiny)
library(dplyr)

shinyUI(fluidPage(
  titlePanel("Exploring College Majors"),

  sidebarLayout(
    sidebarPanel(
      selectizeInput("select",
        label = "Enter a Major",
        choices = NULL,
        options = list(maxItems = 1, maxOptions = 5, items = NULL, openOnFocus = FALSE)
      ),
      actionButton("randomize", label = "Randomize")
    ),

    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Welcome!", plotOutput("word_cloud")),
        tabPanel("Employment", plotlyOutput("employment_chart")),
        tabPanel("Wages"),
        tabPanel("Gender"),
        tabPanel("Popularity", plotlyOutput("popularity_plot"), actionButton("toggle", label = "Toggle Legend"))
      )
    )
  )
))
