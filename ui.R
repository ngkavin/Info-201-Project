library(shiny)
library(plotly)
library(dplyr)

source("text.R")

shinyUI(fluidPage(
  theme = "bootstrap.css",
  tags$br(),
  tags$h1(class = "display-4", "Exploring College Majors"),
  tags$br(),

  sidebarLayout(
    conditionalPanel(
      condition = "input.tabs != 'Welcome!'",
      sidebarPanel(
        width = 4,
        selectizeInput("select",
          label = "Lookup Major",
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
            selected = "Nongrad"
          ),
          selectInput("percent",
            label = "Select Wage Distribution",
            choices = list(
              "25th Percentile" = "P25",
              "50th Percentile" = "median",
              "75th Percentile" = "P75"
            ),
            selected = "median"
          ),
          actionButton("toggle", label = "Toggle Legend")
        )
      )
    ),

    mainPanel(
      tabsetPanel(
        id = "tabs",
        type = "tabs",
<<<<<<< Updated upstream
<<<<<<< HEAD
        tabPanel("Welcome!", plotOutput("word_cloud")),
        tabPanel("Employment", plotlyOutput("employment_chart")),
        tabPanel("Wages"),
=======
        tabPanel("Welcome!", HTML("<p align ='left'><br>", summary, "</p>"), plotOutput("word_cloud", width = "910", height = "900")),
=======
        tabPanel("Welcome!", HTML(summary), img(src='students.jpeg' align="right"), plotOutput("word_cloud", width = "898", height = "870")),
>>>>>>> Stashed changes
        tabPanel("Employment"),
>>>>>>> dd20b83352ad22a7c77dbc3f07cd01baba61439e
        tabPanel("Gender"),
        tabPanel("Popularity and Wages", HTML("<br>"), plotlyOutput("popularity_plot"), tags$br(), tags$p(pop1))
      )
    )
  )
))
