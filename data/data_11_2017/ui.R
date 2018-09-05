load(file = "dpi_data_for_website.rda")


# set the eligible variables to display:
variables_to_display = c("Below basic high school English and Language Arts (%)", "Average high school English score (%)", "Average high school Reading score (%)", 
                          "English language learners in 12th grade (%)", "Graduating seniors (%)", "Below basic elementary school English & Language Arts (%)",
                          "Below basic 3-5th grade English & Language Arts (%)", "Below basic 6-8th grade English & Language Arts (%)", "Unemployment")
# Use a fluid Bootstrap layout
fluidPage(
  
  # Give the page a title
  titlePanel("Literacy achievement by county in Wisconsin (PROTOTYPE)"),
  
  # Generate a row with a sidebar
  sidebarLayout(
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("County name", "County:", choices=d_county_for_website$`County name`),
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




