library(shiny)
library(plotly)
library(dplyr)
library(wordcloud2)
source("text.R")
source("scripts.R")

shinyUI(fluidPage(
  theme = "bootstrap.css",
  tags$br(),
  tags$h1(class = "display-4", "Exploring College Majors"),
  tags$br(),

  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        condition = "input.tabs == 'Welcome!'",
      width = 5,
      HTML(summary)
      ),
      conditionalPanel(
        condition = "input.tabs != 'Welcome!'",
        # Create a search box for looking up a major. Also shows the category
        selectizeInput("select",
                       label = "Lookup Major",
                       choices = select_choices,
                       options = list(maxItems = 1, maxOptions = 5, items = NULL, openOnFocus = FALSE)
        ),
        # Creates a div that contains 2 buttons
        tags$div(class = "butt_contain", 
        # Picks a random major on click
        actionButton("randomize", label = "Randomize"),
        # Shows a popup box of all the availible majors
        actionButton("popup", "Show Majors")
        )
      ),
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
    ),

    mainPanel(
      tabsetPanel(
        id = "tabs",
        type = "tabs",
        tabPanel("Welcome!", wordcloud2Output("word_cloud2", width = "900", height = "500" )),
        tabPanel("Employment", tags$br(), plotlyOutput("employment_chart"), HTML("<p>", employment, "</p>")),
        tabPanel("Gender", tags$br(), plotlyOutput("gender_chart"), HTML("<p>", gender, "</p>")),
        tabPanel("Popularity and Wages", tags$br(), plotlyOutput("popularity_plot"), tags$br(), HTML("<p>", pop1, "</p>"))
      )
    )
  )
))
