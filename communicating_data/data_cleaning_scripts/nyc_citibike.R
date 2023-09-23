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
library(tsibbledata)

# Load original dataset ----
nyc_bikes_raw <- nyc_bikes

nyc_bikes_age_processed <- nyc_bikes_raw %>% 
# Remove entries where age <= 100 at time of bike hire
  filter(birth_year >= 1918) %>% 
# should only remove 2 records from 4268

  mutate(rider_age = 2018 - birth_year,
         .after = birth_year)

nyc_bikes_clean <- nyc_bikes_age_processed
# Write clean dataset to CSV ----

write_csv(nyc_bikes_clean , "clean_data/nyc_bikes.csv")


