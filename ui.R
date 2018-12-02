library(shiny)
library(plotly)
library(dplyr)
library(wordcloud2)

source("text.R")

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
      img(src='students.jpeg',style="width: 300px"), 
      HTML("<br>", summary)
      ),
      conditionalPanel(
        condition = "input.tabs != 'Welcome!'",
        selectizeInput("select",
                       label = "Lookup Major",
                       choices = NULL,
                       options = list(maxItems = 1, maxOptions = 5, items = NULL, openOnFocus = FALSE)
        ),
        actionButton("randomize", label = "Randomize")
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
        tabPanel("Employment", plotlyOutput("employment_chart")),
        tabPanel("Gender", img(src="https://image.freepik.com/free-vector/funny-error-404-background-design_1167-219.jpg")),
        tabPanel("Popularity and Wages", tags$br(), plotlyOutput("popularity_plot"), tags$br(), HTML("<p>", pop1, "</p>"))
      )
    )
  )
))
