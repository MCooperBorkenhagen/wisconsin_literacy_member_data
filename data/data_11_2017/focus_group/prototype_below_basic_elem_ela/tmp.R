
names(d_county_for_website)


require(ggplot2)
#histograms

#`Below basic high school English and Language Arts (%)`
hist(d_county_for_website$`Below basic high school English and Language Arts (%)`, main = "Below basic high school English and Language Arts (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Below basic high school English and Language Arts (%)`, na.rm = TRUE), col = 'red')

 
#`Average high school English score (%)`
hist(d_county_for_website$`Average high school English score (%)`, main = "Average high school English score (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Average high school English score (%)`, na.rm = TRUE), col = 'red')


#`Average high school Reading score (%)`
hist(d_county_for_website$`Average high school Reading score (%)`, main = "Average high school Reading score (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Average high school Reading score (%)`, na.rm = TRUE), col = 'red')

#`English language learners in 12th grade (%)`
hist(d_county_for_website$`English language learners in 12th grade (%)`, main = "English language learners in 12th grade (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`English language learners in 12th grade (%)`, na.rm = TRUE), col = 'red')

#`Graduating seniors (%)`
hist(d_county_for_website$`Graduating seniors (%)`, main = "Graduating seniors (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Graduating seniors (%)`, na.rm = TRUE), col = 'red')


#`Below basic elementary school English & Language Arts (%)`
hist(d_county_for_website$`Below basic elementary school English & Language Arts (%)`, main = "Below basic elementary school English & Language Arts (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Below basic elementary school English & Language Arts (%)`, na.rm = TRUE), col = 'red')


#`Below basic 3-5th grade English & Language Arts (%)`
hist(d_county_for_website$`Below basic 3-5th grade English & Language Arts (%)`, main = "Below basic 3-5th grade English & Language Arts (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Below basic 3-5th grade English & Language Arts (%)`, na.rm = TRUE), col = 'red')


#`Below basic 6-8th grade English & Language Arts (%)`
hist(d_county_for_website$`Below basic 6-8th grade English & Language Arts (%)`, main = "Below basic 6-8th grade English & Language Arts (%)", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Below basic 6-8th grade English & Language Arts (%)`, na.rm = TRUE), col = 'red')


#`Unemployment`
hist(d_county_for_website$`Unemployment`, main = "Unemployment", xlab = "Percentile") +
  abline(v=mean(d_county_for_website$`Unemployment`, na.rm = TRUE), col = 'red')

