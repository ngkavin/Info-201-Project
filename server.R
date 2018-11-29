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
  

})
