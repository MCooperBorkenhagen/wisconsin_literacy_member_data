# Requirements ----
require(readxl)


# Read data ----
d2015_2016_county = read.csv("Wisconsin_Literacy_Data_Request_2015-2016_County.csv")
d2016_2017_county = read.csv("Wisconsin_Literacy_Data_Request_2016-2017_County.csv")
d2015_2016_dist = read.csv("Wisconsin_Literacy_Data_Request_2015-2016_District.csv")
d2016_2017_dist = read.csv("Wisconsin_Literacy_Data_Request_2016-2017_District.csv")
dict = readxl::read_xlsx("Wisconsin Literacy Data Request Data Dictionary (11.2017).xlsx")
unemployment = readxl::read_xlsx("WI_county_unemployment_rates.xlsx")



# Clean a little ----
d2015_2016_county$year = 1516
d2016_2017_county$year = 1617
d2015_2016_dist$year = 1516
d2016_2017_dist$year = 1617

# unemployment rates:
unemployment$county_name = toupper(unemployment$County)
unemployment$county_name[unemployment$County == 'St. Croix'] <- "SAINT CROIX" #this needs to be changed to SAINT CROIX to match for merge
unemployment$County <- NULL
unemployment %>% rename(unemployment = Percentage) -> unemployment


# Aggregate data files ----
d_county = rbind(d2015_2016_county, d2016_2017_county)
d_dist = rbind(d2015_2016_dist, d2016_2017_dist)

# Columns to select ----
# County:
vars_county = c("county_name", "percent_act_ela_below_basic", "average_act_english_percentile", 
         "average_act_reading_percentile", "percent_12th_grade_ell",
         "percent_graduates", "percent_wsas_ela_below_basic_3_8", 
         "percent_wsas_ela_below_basic_3_5","percent_wsas_ela_below_basic_6_8", "year")
d_county <- d_county %>% 
  select(vars_county) %>% 
  mutate_if(is.character, as.numeric) %>%
  mutate(county_name = toupper(county_name))
# merge with unemployment data:
d_county = merge(d_county, unemployment, by = "county_name")
# reassign year variable as more descriptive character string:
d_county$year = ifelse(d_county$year == 1516, "2015-2016",
                       ifelse(d_county$year == 1617, "2016-2017", NA))



# District:
vars_dist = c("school_district", "percent_act_ela_below_basic", "average_act_english_percentile", 
                "average_act_reading_percentile", "percent_12th_grade_ell",
                "percent_graduates", "percent_wsas_ela_below_basic_3_8", 
                "percent_wsas_ela_below_basic_3_5","percent_wsas_ela_below_basic_6_8", "year")

d_dist <- d_dist  %>% select(vars_dist) %>% mutate_if(is.character, as.numeric)


# Now create the disagregated data sheets that WL requested:
# Note that the logic of this script is circular because we aggregate and then disaggregated. It is just how the process went with WL.
vars_for_final_wl_data = c("county_name", "percent_act_ela_below_basic",
                "average_act_reading_percentile", "percent_12th_grade_ell",
                "percent_graduates", "percent_wsas_ela_below_basic_3_5", "year", "unemployment")

# first the 2015-2016 data:
d_county %>% select(vars_for_final_wl_data) %>%
  filter(year == "2015-2016") -> data_2015

data_2015 %>% summarise(county_name = "MEANS FOR 15-16...",
                        percent_act_ela_below_basic = mean(percent_act_ela_below_basic),
                        average_act_reading_percentile = mean(average_act_reading_percentile),
                        percent_12th_grade_ell = mean(percent_12th_grade_ell),
                        percent_graduates = mean(percent_graduates),
                        percent_wsas_ela_below_basic_3_5 = mean(percent_wsas_ela_below_basic_3_5),
                        year = "2015-2016", 
                        unemployment = mean(unemployment)) -> means_of_all_cols

data_2015 = rbind(data_2015, means_of_all_cols)
write.csv(data_2015, "WL_county_data_2015_2016.csv")

# now the 2016-17 data:
d_county %>% select(vars_for_final_wl_data) %>%
  filter(year == "2016-2017") -> data_2016

data_2016 %>% summarise(county_name = "MEANS FOR 16-17...",
                        percent_act_ela_below_basic = mean(percent_act_ela_below_basic, na.rm = TRUE),
                        average_act_reading_percentile = mean(average_act_reading_percentile, na.rm = TRUE),
                        percent_12th_grade_ell = mean(percent_12th_grade_ell),
                        percent_graduates = mean(percent_graduates),
                        percent_wsas_ela_below_basic_3_5 = mean(percent_wsas_ela_below_basic_3_5),
                        year = "2016-2017", 
                        unemployment = mean(unemployment)) -> means_of_all_cols

data_2016 = rbind(data_2016, means_of_all_cols)
write.csv(data_2016, "WL_county_data_2016_2017.csv")

# average of the two:
d_county %>% group_by(county_name) %>%
  summarise(percent_act_ela_below_basic = mean(percent_act_ela_below_basic),
            average_act_reading_percentile = mean(average_act_reading_percentile),
            percent_12th_grade_ell = mean(percent_12th_grade_ell),
            percent_graduates = mean(percent_graduates),
            percent_wsas_ela_below_basic_3_5 = mean(percent_wsas_ela_below_basic_3_5),
            year = "2015-2017", 
            unemployment = mean(unemployment)) %>%
  ungroup() -> data_2015_2017_averages

# now get the average of the averages:
data_2015_2017_averages %>% summarise(county_name = "MEANS FOR 15-17...",
                          percent_act_ela_below_basic = mean(percent_act_ela_below_basic, na.rm = TRUE),
                          average_act_reading_percentile = mean(average_act_reading_percentile, na.rm = TRUE),
                          percent_12th_grade_ell = mean(percent_12th_grade_ell),
                          percent_graduates = mean(percent_graduates),
                          percent_wsas_ela_below_basic_3_5 = mean(percent_wsas_ela_below_basic_3_5),
                          year = "2015-2017", 
                          unemployment = mean(unemployment)) -> means_of_all_cols
# rbind them together:
data_2015_2017_averages = rbind(data_2015_2017_averages, means_of_all_cols)
write.csv(data_2015_2017_averages, "WL_county_data_2015_2017_averages.csv")





# Save to rda ----
save(d_county, d_dist, dict, file = "dpi_data.rda") #this is the cleaned generic version of the DPI data
save(data_2015, data_2016, data_2015_2016_averages, file = "wl_data_final.rda")

# Remove what you don't need:
rm(list = ls())



