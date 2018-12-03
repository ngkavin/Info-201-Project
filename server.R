library(shiny)
library(plotly)
library(dplyr)
library(wordcloud2)

source("scripts.R")

shinyServer(function(input, output, session) {
  # Displays a word cloud of majors based on popularity
  output$word_cloud2 <- renderWordcloud2({
    all_majors <- wordcloud2(all_majors, size = .4, shape = 'circle', color = c(
      "#64EDD9",
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
      "#15861A"
    ))
    all_majors
  })
  # Randomizes selected major if the randomize button is pressed
  observeEvent(input$randomize, {
    r_major <- get_random_major()
    updateSelectInput(session, "select", selected = r_major)
  })
  
  # opens popup box that displays all availible majors in alphabetical order
  observeEvent(input$popup,{
    showModal(modalDialog(
      title = "Major List",
      easyClose = TRUE,
      HTML(paste(unlist(sort(majors_list)), collapse = "<br>"))
    ))
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
    ) %>%
      config(displayModeBar = FALSE) %>%
      layout(
        title = "Does a More Popular Major Equal Higher Wages?",
        xaxis = list(title = "Wages ($)"),
        yaxis = list(title = paste0("# of Total ", ifelse(input$status == "Grad", "Graduates", "Undergraduates")))
      )


    # Adds a marker to the plot indicating where the selected major is
    if (input$select != "") {
      m_info <- filter(grad, Major == toupper(input$select))
      p <- p %>% add_annotations(
        x = m_info[, wage_dist],
        y = m_info[, total_dist],
        text = input$select,
        arrowhead = 6,
        ax = 25,
        ay = -40
      )
      # Removes marker if search box is cleared
    } else {
      p <- p
    }

    # Hides/Shows the legend if corresponding button is pressed
    if (input$toggle %% 2 == 0) {
      p <- p %>% layout(showlegend = FALSE)
    } else {
      p <- p %>% layout(showlegend = TRUE)
    }
  })

  # Creates a bar chart to show employment status of recent graduates based on user input
  output$employment_chart <- renderPlotly({
     majors <- filter(recent_grads, Major == toupper(input$select))
      all_grads <- select(recent_grads, Full_time, Part_time, Full_time_year_round, Unemployed) %>% colSums()
      all_grads <- as.data.frame(t(as.data.frame(all_grads)))
      bar_chart <- plot_ly(
      data = recent_grads,
      type = "bar",
      marker = list(color = c('rgba(222,45,38,0.8)', 'rgba(204,204,204,1)',
                              'rgba(204,204,204,1)','rgba(222,45,38,0.8)')),
      x = c("Full Time", "Part Time", "Full Time Year Round", "Unemployed"),
      y = ifelse(input$select != "", 
                c(majors$Full_time, majors$Part_time, majors$Full_time_year_round, majors$Unemployed),
                c(all_grads$Full_time, all_grads$Part_time, all_grads$Full_time_year_round, all_grads$Unemployed))
      ) %>% 
      layout(
        title = "Employment Status Based on Majors",
        xaxis = list(title = "Employment Status"),
        yaxis = list(title = "Number of Recent Graduates")
      )

  })
  
  # Creates a pie chart to show the ratio of men to women in each major
  output$gender_chart <- renderPlotly({
    gender_grads1 <- filter(gender_grads1, Major == toupper(input$select))
    colors <- c('rgb(10, 147, 80)', 'rgb(115, 226, 172)')
    pie_chart <- plot_ly(gender_grads1, labels = (colnames(gender_grads1[1:2])), values =(list(gender_grads1$Men,gender_grads1$Women)), type = 'pie',
                  insidetextfont = list(color = '#FFFFFF'),
                  marker = list(colors = colors,
                                line = list(color = '#FFFFFF', width = 1),
                                textposition = 'inside')) %>%
      layout(title = 'Ratio of Men to Women in Each Major',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
  })
})
