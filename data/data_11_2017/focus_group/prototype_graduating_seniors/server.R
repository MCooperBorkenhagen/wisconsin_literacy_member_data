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
    variable = "Graduating seniors (%)"
    
    plot_data <- d_county_for_website %>%
      dplyr::filter(`County name` == county_name_chosen) %>%
      dplyr::select(`Graduating seniors (%)`, year)
      
    barplot(
      plot_data$`Graduating seniors (%)`, names.arg = plot_data$year,
      main = input$county_name,
      ylab = "Percentile",
      xlab = "Year"
      
    )
    
  })
}


