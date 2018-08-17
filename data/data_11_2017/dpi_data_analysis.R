

# Read data ----
load(file = "dpi_data.rda")

# Requirements ----
require(tidyverse)


# Inspect a single county ----
milwaukee <- d_county %>% filter(county_name == 'Milwaukee')


write.csv(milwaukee, "milwaukee.csv")

