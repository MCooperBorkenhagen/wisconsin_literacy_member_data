require(shiny)





# Define a server for the Shiny app
function(input, output) {
  
  load(file = "dpi_data_for_website.rda")
  
  # Fill in the spot we created for a plot
  output$plot_variable_by_year <- renderPlot({
    
    # Render a barplot
    require(dplyr)
    require(ggplot2)
    
    county_name_chosen = input$county_name
    variable = "Below basic high school English and Language Arts (%)"
    
    plot_data <- d_county_for_website %>%
      dplyr::filter(`County name` == county_name_chosen) %>%
      dplyr::select(`Below basic high school English and Language Arts (%)`, year)
      
    barplot(
      plot_data$`Below basic high school English and Language Arts (%)`, names.arg = plot_data$year,
      main = input$county_name,
      ylab = "Percentile",
      xlab = "Year"
      
    )
    
    
    #ggplot(plot_data, aes(x = year, y = variable, fill = year)) + geom_bar(stat = "identity") +
      #geom_text(aes(label = variable_chosen), vjust = 1.5, size = 17) +
      #labs(title = paste(input$variable_to_display), y = "% students at 'below basic' level", x = "Year") +
      #ylim(c(0, 100))
      #theme(text = element_text(size = 21), legend.position = "none")
    
  })
}


