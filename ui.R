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
      actionButton("randomize", label = "Randomize"),
      conditionalPanel(
        HTML("<br>"),
        condition = "input.tabs == 'Popularity and Wages'",
        selectInput("status",
                    label = "Select Graduate Status",
                    choices = list("Graduate" = "Grad", "Undergraduate" = "Nongrad"),
                    selected = "Nongrad"),
        selectInput("percent",
                    label = "Select Wage Distribution",
                    choices = list("25th Percentile" = "P25", 
                                   "50th Percentile" = "median", 
                                   "75th Percentile" = "P75"),
                    selected = "median")
      )
    ),

    mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel("Welcome!", plotOutput("word_cloud")),
        tabPanel("Employment"),
        tabPanel("Gender"),
        tabPanel("Popularity and Wages", plotlyOutput("popularity_plot"), actionButton("toggle", label = "Toggle Legend"))
      )
    )
  )
))
