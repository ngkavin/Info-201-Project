library(shiny)
library(plotly)
library(dplyr)
library(wordcloud2)

source("scripts.R")

shinyServer(function(input, output, session) {
  # Displays a word cloud of majors based on popularity
  output$word_cloud2 <- renderWordcloud2({
    all_majors <- wordcloud2(all_majors, size = .4, shape = 'circle', color = w_color)
    all_majors
  })
  # Randomizes selected major if the randomize button is pressed
  observeEvent(input$randomize, {
    r_major <- 
      if (input$checkbox == TRUE) {
        get_random_stem_major()
      } else {
        get_random_major()
      }
    updateSelectInput(session, "select", selected = r_major)
  })
  
  # opens popup box that displays all availible majors in alphabetical order
  observeEvent(input$popup,{
    showModal(modalDialog(
      title = "Major List",
      easyClose = TRUE,
      if (input$checkbox == TRUE) {
        HTML(paste(unlist(sort(stem_majors_list)), collapse = "<br>"))
      } else {
        HTML(paste(unlist(sort(majors_list)), collapse = "<br>"))
      }
    ))
  })
    
  # Creates the popularity vs median salary plot with plotly. Points colored based on major category
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
      # Removes the plotly bar the appears on hover
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
    # Adds up all employment statistics for all majors
    all_grads <- select(recent_grads, Full_time, Part_time, Full_time_year_round, Unemployed) %>% colSums()
    all_grads <- as.data.frame(t(as.data.frame(all_grads)))
    if (input$select != "") {
      e_data <- c(majors$Full_time, majors$Part_time, majors$Full_time_year_round, majors$Unemployed)
      e_title <- paste("Employment Statistics for", input$select)  
    } else {
      e_data <- c(all_grads$Full_time, all_grads$Part_time, all_grads$Full_time_year_round, all_grads$Unemployed)
      e_title <- paste("Employment Statistics for All Majors")  
    }

    bar_chart <- plot_ly(
    data = recent_grads,
    type = "bar",
    marker = list(color = c('rgba(120,194,174,1)', 'rgba(120,194,174,1)',
                            'rgba(120,194,174,1)','rgba(204,204,204,1)')),
    x = c("Full Time", "Part Time", "Full Time Year Round", "Unemployed"),
    y = e_data
    ) %>% 
    layout(
      title = e_title,
      xaxis = list(title = "Employment Status"),
      yaxis = list(title = "Number of Recent Graduates")
    ) %>% 
    # Removes the plotly bar the appears on hover
    config(displayModeBar = FALSE)
  })
  
  # Creates a pie chart to show the ratio of men to women in each major
  output$gender_chart <- renderPlotly({
    gender_grads_major <- filter(gender_grads1, Major == toupper(input$select))
    # Adds up all men and women for all of the majors
    gender_grads_all <- select(gender_grads1, Men, Women) %>% colSums(na.rm = TRUE)
    gender_grads_all <- as.data.frame(t(as.data.frame(gender_grads_all)))
    
    gender_grads_stem <- filter(gender_stem_grads, Major == toupper(input$select))
    # Adds up all men and women for all of the STEM majors
    gender_grads_stem_all <- select(gender_stem_grads, Men, Women) %>% colSums(na.rm = TRUE)
    gender_grads_stem_all <- as.data.frame(t(as.data.frame(gender_grads_stem_all)))
    # Check if checkbox is selected to show STEM MAjors only, if not it selects all Majors
    if (input$checkbox == FALSE) {
      # Adjust data and title depending on if a major is selected or not
      if (input$select != "") {
        g_data <- list(gender_grads_major$Men,gender_grads_major$Women)
        g_title <- paste('Ratio of Men to Women for', input$select)
      } else {
        g_data <- list(gender_grads_all$Men,gender_grads_all$Women)
        g_title <- 'Ratio of Men to Women for All Recent College Graduates'
      } 
    colors <- c('rgb(10, 147, 80)', 'rgb(115, 226, 172)')
    pie_chart <- plot_ly(gender_grads1, labels = (colnames(gender_grads1[1:2])), values = g_data, type = 'pie',
                         insidetextfont = list(color = '#FFFFFF'),
                         marker = list(colors = colors,
                                line = list(color = '#FFFFFF', width = 1),
                                textposition = 'inside')) %>%
    layout(title = g_title,
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)) %>% 
        # Removes the plotly bar that appears on hover.
    config(displayModeBar = FALSE)
    } else {
        if (input$select != "") {
          g_data <- list(gender_grads_stem$Men,gender_grads_stem$Women)
          g_title <- paste('Ratio of Men to Women for', input$select)
        } else {
          g_data <- list(gender_grads_stem_all$Men,gender_grads_stem_all$Women)
          g_title <- 'Ratio of Men to Women for All Recent STEM College Graduates'
        }
    colors <- c('rgb(10, 147, 80)', 'rgb(115, 226, 172)')
    pie_chart <- plot_ly(gender_stem_grads, labels = (colnames(gender_stem_grads[1:2])), values = g_data, type = 'pie',
                         insidetextfont = list(color = '#FFFFFF'),
                         marker = list(colors = colors,
                                         line = list(color = '#FFFFFF', width = 1),
                                         textposition = 'inside')) %>%
    layout(title = g_title,
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)) %>% 
          # Removes the plotly bar that appears on hover.
    config(displayModeBar = FALSE)
    }
})
})