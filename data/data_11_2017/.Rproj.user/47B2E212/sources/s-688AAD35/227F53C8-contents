require(shiny)

load(file = "dpi_data.rda")



# Define a server for the Shiny app
function(input, output) {
  
  # Fill in the spot we created for a plot
  output$plot_percent_act_ela_below_basic <- renderPlot({
    
    # Render a barplot
    require(dplyr)
    require(ggplot2)
    
    plot_data <- d_county %>% select(input$variable_to_display, county_name, year) %>%
      filter(county_name == input$county_name)
    
    
    ggplot(plot_data, aes(x = year, y = input$variable_to_display, fill = year)) + geom_bar(stat = "identity") +
      geom_text(aes(label = input$variable_to_display), vjust = 1.5, size = 17) +
      labs(title = paste(input$variable_to_display), y = "% students at 'below basic' level", x = "Year") +
      #ylim(c(0, max(d_county$percent_act_ela_below_basic, na.rm = TRUE)+5)) +
      theme(text = element_text(size = 21), legend.position = "none")
    
  })
}


write.csv(unique(d_county$county_name), "~/Desktop/county_names.csv")          
