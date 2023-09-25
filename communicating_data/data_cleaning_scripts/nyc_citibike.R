# 
# File: nyc_citibike.R
# Author: Lesley Duff
# Date Created: 2023-09-23
# Purpose:
#   Clean original nyc_bikes dataset adding new columns to help visualisation
# Decisions in this script are based on the findings inside file 
# 0_preliminary_analysis.Rmd
#
library(tidyverse)
library(tsibble)
library(tsibbledata)

# Load original dataset ----
nyc_bikes_raw <- nyc_bikes
#View(nyc_bikes)
#str(nyc_bikes)
# Examine time-based info
#index_var(nyc_bikes_raw)
#"start_time"
#key_vars(nyc_bikes_raw)
# bike_id

#head(nyc_bikes_raw)

nyc_bikes_age_processed <- nyc_bikes_raw %>% 
# Remove entries where age <= 100 at time of bike hire
  filter(birth_year >= 1918) %>% 
# should only remove 2 records from 4268

  mutate(rider_age = 2018 - birth_year,
         .after = birth_year)

rm(nyc_bikes_raw)

nyc_bikes_time_processed <- nyc_bikes_age_processed %>% 
  #What is the pattern of bike hires over time 
  #(e.g. within a year, month, week, or day)?
  mutate(
    start_date = date(start_time), # use for across year by day of year within year
    start_month_name = month(start_time, label = TRUE), # Jan, Feb,
    start_day_of_week = wday(start_time, label = TRUE), # Mon,Tue...
    start_hour_of_day = hour(start_time),# 24hr time of day
    
  #  start_month = month(start_time), # use for across year by month of year
    # use for across year by month of year
#    start_week = week(start_time), # use for across year by week of year

    hire_duration = as.duration(stop_time - start_time),
    
    .after = start_time)

rm(nyc_bikes_age_processed)
#head(nyc_bikes_time_processed)
#View(nyc_bikes_time_processed)

nyc_bikes_clean = nyc_bikes_time_processed
rm(nyc_bikes_time_processed)

# Write clean dataset to CSV ----
write_csv(nyc_bikes_clean, "clean_data/nyc_bikes.csv")
#rm(nyc_bikes_clean)
#str(nyc_bikes_clean)
