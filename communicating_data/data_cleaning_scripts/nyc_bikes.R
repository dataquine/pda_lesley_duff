library(tidyverse)
library(tsibble) # time series tibble for the tidyverse
library(tsibbledata)

# Load data set ----
# ?nyc_bikes comes from the tsibbledata package
nyc_bikes_df <- nyc_bikes
#View(nyc_bikes_df)
#class(nyc_bikes_df)

#names(nyc_bikes_df)
# "bike_id"       "start_time"    "stop_time"     "start_station" "start_lat"
# "start_long"    "end_station"   "end_lat"       "end_long"      "type"
# "birth_year"    "gender"

# Generate dataset containing only the variables of interest
nyc_bikes_minimum <- nyc_bikes_df %>%
  # start_time and bike_id will be here by default
  
  # add columns for convenience in plots
  mutate(age = 2018 - birth_year,
         month_name = month(start_time, label = TRUE),
         month = month(start_time)
  ) %>%
  # Select only columns needed for analysis
  select(bike_id, start_time, age,
         #month_name,
         month, 
         start_station, end_station) 

rm(nyc_bikes_df)

# replace observations in the age column where ages >=130
# I strongly suspect the ages were typing mistakes typing 8 instead of 9
# however we do not have knowledge of how it was obtained
# There are only 2 entries so we are choosing to drop these couple of rows
nyc_bikes_clean_age <- nyc_bikes_minimum[which(nyc_bikes_minimum$age < 130),]

rm(nyc_bikes_minimum)

# Check that ages look more believable
#nyc_bikes_clean_age %>%
#  ggplot() +
#  geom_histogram(aes(x = age))

# write clean data to csv
write_csv(nyc_bikes_clean_age, "clean_data/nyc_bikes_clean.csv")
class(nyc_bikes_clean_age)
rm(nyc_bikes_clean_age)


