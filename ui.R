library(plotly)
library(shiny)
library(dplyr)
source("text.R")

shinyUI(fluidPage(
  theme = "bootstrap.css",
  tags$br(),
  tags$h1(class="display-4", "Exploring College Majors"),
  tags$br(),

  sidebarLayout(
    sidebarPanel(
      selectizeInput("select",
        label = "Search For a Major",
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
                    selected = "median"),
        actionButton("toggle", label = "Toggle Legend")
      )
    ),
  
    mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel("Welcome!", plotOutput("word_cloud")),
        tabPanel("Employment"),
        tabPanel("Gender"),
        tabPanel("Popularity and Wages", HTML("<br>"), plotlyOutput("popularity_plot"), tags$br(), tags$p(pop1))
      )
    )
  )
))
