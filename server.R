library(shiny)
library(plotly)
suppressMessages(library(dplyr))

all_ages <- read.csv("data/all-ages.csv", stringsAsFactors = FALSE)
majors_list <- sapply(tolower(all_ages$Major), tools::toTitleCase)
majors_list <- as.data.frame(majors_list)$majors_list

shinyServer(function(input, output, session) {
  
  updateSelectInput(session, "select", choices = split(majors_list, all_ages$Major_category))
  
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
    # Hides/Shows the legend if corresponding button is pressed
    if (input$toggle %% 2 == 0) {
      p %>% layout(showlegend = TRUE)
    } else {
      p %>% layout(showlegend = FALSE)
    }
    
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
    
  })

})
