load(file = "dpi_data.rda")


# set the eligible variables to display:

variables_to_display = c("percent_act_ela_below_basic", "average_act_english_percentile", "average_act_reading_percentile", 
                       "percent_12th_grade_ell", "percent_graduates", "percent_wsas_ela_below_basic_3_8", "percent_wsas_ela_below_basic_3_5",
                       "percent_wsas_ela_below_basic_6_8", "unemployment")
# Use a fluid Bootstrap layout
fluidPage(
  
  # Give the page a title
  titlePanel("Here is some stuff"),
  
  # Generate a row with a sidebar
  sidebarLayout(
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("county_name", "County:", choices=d_county$county_name),
      selectInput("variable_to_display", "Variable:", choices = variables_to_display),
      hr(),
      helpText("Data from Wisconsin Department of Public Instruction")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("plot_variable_by_year")  
    )
    
  )
)




