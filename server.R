library(shiny)
library(plotly)

#install.packages("tm")
#install.packages("SnowballC")
#install.packages("wordcloud")
#install.packages("RColorBrewer")
#install.packages("RCurl")
#install.packages("XML")
library(dplyr)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(RCurl)
library(XML)

suppressMessages(library(dplyr))
source("scripts.R")

shinyServer(function(input, output, session) {
  
  # Displays a word cloud of the top 20 popular majors
  output$word_cloud <- renderPlot({
    wordcloud(words = majors_twenty$Major, freq = majors_twenty$Total, min.freq = 1,
              scale=c(3,.1), max.words=200, random.order=FALSE, rot.per=0.5, 
              colors=brewer.pal(8, "Dark2"))
  })
  
  updateSelectInput(session, "select", choices = split(majors_list, all_ages$Major_category))
  
  # Randomizes selected major if the randomize button is pressed
  observeEvent(input$randomize, {
    r_major <- get_random_major()
    updateSelectInput(session, "select", selected = r_major)
  })
  
  # Creates the popularity vs median salary plot with plotly
  output$popularity_plot <- renderPlotly({
    p <- plot_ly(
      data = all_ages, 
      type = "scatter",
      mode = "markers",
      x = ~Median, 
      y = ~Total,
      text = majors_list, 
      color = ~Major_category
      ) %>% config(displayModeBar = FALSE) %>% 
      layout(
        xaxis = list(title = "Median Salary ($)"),
        yaxis = list(title = "# of Graduates")
        )
    
    
    # Adds a marker to the plot indicating where the selected major is
    if (input$select != "") {
      m_info <- filter(all_ages, Major == toupper(input$select))
      p %>% add_annotations(x = m_info$Median,
                            y = m_info$Total,
                            text = input$select,
                            arrowhead = 6,
                            ax = 25,
                            ay = -40)
      # Removes marker if search box is cleared
    } else {p}
    
    # Hides/Shows the legend if corresponding button is pressed
    if (input$toggle %% 2 == 0) {
      p %>% layout(showlegend = TRUE)
    } else {
      p %>% layout(showlegend = FALSE)
    }
  })
  
  # Creates a bar chart to show employment status of recent graduates based on user input
  output$employment_chart <- renderPlotly({
    majors <- filter(recent_grads, Major == toupper(input$select))
    bar_chart<- plot_ly(
      data = recent_grads,
      type = "bar",
      marker = list(color = c('rgba(222,45,38,0.8)', 'rgba(204,204,204,1)',
                              'rgba(204,204,204,1)')),
      x = c("Full Time", "Part Time", "Full Time Year Round"),
      y = c(majors$Full_time, majors$Part_time, majors$Full_time_year_round)
    ) %>% 
      layout(
        xaxis = list(title = "Employment Status"),
        yaxis = list(title = "Number of Recent Graduates")
      )
  })
})
