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
    variable = "Below basic elementary school English & Language Arts (%)"
    
    plot_data <- d_county_for_website %>%
      dplyr::filter(`County name` == county_name_chosen) %>%
      dplyr::select(`Below basic elementary school English & Language Arts (%)`, year)
      
    barplot(
      plot_data$`Below basic elementary school English & Language Arts (%)`, names.arg = plot_data$year,
      main = input$county_name,
      ylab = "Percentile",
      xlab = "Year"
      
    )
    
  })
}


