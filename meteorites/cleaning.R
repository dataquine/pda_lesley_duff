# Author: Lesley Duff
# Title: Cleans some data on meteorites
# Date: 2023-07-21
# Description:
#   Data comes from NASA and has information on meteorites that have been found 
# up to the year 2013.
#
# Tasks to be completed
# 1. Read the data into R
# 2. Change the names of the variables to follow our naming standards.
# 3. Split in column GeoLocation into latitude and longitude, the new latitude 
# and longitude columns should be numeric.
# 4. Replace any missing values in latitude and longitude with zeros.
# 5. Remove meteorites less than 1000g in weight from the data.
# 6. Order the data by the year of discovery.

# We would also like you to include assertive programming to make sure that:
# 1. The data has the variable names we expect ("id", "name", "mass (g)", "fall2
# , "year", "GeoLocation").
# 2. Latitude and longitude are valid values. (Latitude between -90 and 90, 
# longitude between -180 and 180).

library(janitor)
library(tidyverse)

# Read the data into R
meteorite_landings <- read_csv("data/meteorite_landings.csv")

# check the data
# dim(meteorite_landings)
# Rows 45716, Columns 6 
# head(meteorite_landings)
names(meteorite_landings)

# Change the names of the variables to follow our naming standards.
# mass (g) has spaces, GeoLocation is mixed case.
# Use janitor to clean the names
meteorite_landings_clean <- meteorite_landings %>% 
  clean_names() %>% 
  #names()

meteorite_landings_clean