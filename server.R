library(shiny)
library(plotly)
library(dplyr)
library(wordcloud)



suppressMessages(library(dplyr))
source("scripts.R")

shinyServer(function(input, output, session) {
  
  # Displays a word cloud of the top 20 popular majors
  output$word_cloud <- renderPlot({
    majors <- wordcloud(words = top_majors$Major, freq = top_majors$Total, min.freq = 1,
              scale=c(9,.1), max.words=200, random.order=FALSE, random.color = TRUE, rot.per=.0,
              colors=c("#64EDD9",
                       "#5FE6CD",
                       "#5AE0C1",
                       "#55D9B5",
                       "#50D3A9",
                       "#4BCC9D",
                       "#46C691",
                       "#41BF85",
                       "#3CB979",
                       "#37B36D",
                       "#32AC61",
                       "#2DA655",
                       "#289F49",
                       "#1E9231",
                       "#198C25",
                       "#15861A"))

  })
  
  updateSelectInput(session, "select", choices = split(majors_list, grad$Major_category))
  
  # Randomizes selected major if the randomize button is pressed
  observeEvent(input$randomize, {
    r_major <- get_random_major()
    updateSelectInput(session, "select", selected = r_major)
  })
  
  # Creates the popularity vs median salary plot with plotly
  output$popularity_plot <- renderPlotly({
    wage_dist <- paste(input$status, input$percent, sep = "_")
    total_dist <- paste0(input$status, "_total")
    p <- plot_ly(
      data = grad, 
      type = "scatter",
      mode = "markers",
      x = grad[, wage_dist], 
      y = grad[, total_dist],
      text = majors_list, 
      color = ~Major_category
      ) %>% config(displayModeBar = FALSE) %>% 
      layout(
        title = "Does a More Popular Major Equal Higher Wages?",
        xaxis = list(title = "Wages ($)"),
        yaxis = list(title = paste0("# of Total ", ifelse(input$status == "Grad", "Graduates", "Undergraduates")))
      )
    
    
    #Adds a marker to the plot indicating where the selected major is
    if (input$select != "") {
      m_info <- filter(grad, Major == toupper(input$select))
      p <- p %>% add_annotations(x = m_info[, wage_dist],
                            y = m_info[, total_dist],
                            text = input$select,
                            arrowhead = 6,
                            ax = 25,
                            ay = -40)
      # Removes marker if search box is cleared
    } else {p <- p}
    
    # Hides/Shows the legend if corresponding button is pressed
    if (input$toggle %% 2 == 0) {
      p <- p %>% layout(showlegend = FALSE)
    } else {
      p <- p %>% layout(showlegend = TRUE)
    }
    
  })
  

})
