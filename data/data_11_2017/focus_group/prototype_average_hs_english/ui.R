load(file = "dpi_data_for_website.rda")

variable = "Average high school English score (%)"
county_names = unique(d_county_for_website$`County name`)

# Use a fluid Bootstrap layout
fluidPage(
  
  # Give the page a title
  titlePanel(variable),
  
  # Generate a row with a sidebar
  sidebarLayout(
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("county_name", "County:", choices=county_names),
      hr(),
      helpText("Data from Wisconsin Department of Public Instruction")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("plot_variable_by_year")  
    )
    
  )
)



