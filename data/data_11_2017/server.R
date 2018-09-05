require(shiny)

load(file = "dpi_data_for_website.rda")



# Define a server for the Shiny app
function(input, output) {
  
  # Fill in the spot we created for a plot
  output$plot_variable_by_year <- renderPlot({
    
    # Render a barplot
    require(dplyr)
    require(ggplot2)
    
    plot_data <- d_county_for_website %>% select(variable_chosen = input$variable_to_display, `County name`, year) %>%
      filter(`County name` == input$`County name`)
    
    
    ggplot(plot_data, aes(x = year, y = variable_chosen, fill = year)) + geom_bar(stat = "identity") +
      #geom_text(aes(label = variable_chosen), vjust = 1.5, size = 17) +
      labs(title = paste(input$variable_to_display), y = "% students at 'below basic' level", x = "Year") +
      #ylim(c(0, max(d_county$percent_act_ela_below_basic, na.rm = TRUE)+5)) +
      theme(text = element_text(size = 21), legend.position = "none")
    
  })
}


        
