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

library(assertr)
library(janitor)
library(tidyverse)

# Read the data into R
meteorite_landings <- read_csv("data/meteorite_landings.csv")

# check the data
# dim(meteorite_landings)
# Rows 45716, Columns 6
# head(meteorite_landings)
# names(meteorite_landings)

# make sure that the data has the variable names we expect
expected_variable_names <- c(
  "id", "name", "mass (g)", "fall", "year",
  "GeoLocation"
)

meteorite_landings %>%
  verify(names(.) == expected_variable_names)

# Change the names of the variables to follow our naming standards.
# mass (g) has spaces, GeoLocation is mixed case.
# Use janitor to clean the names
meteorite_landings <- meteorite_landings %>%
  janitor::clean_names()

# names(meteorite_landings)

# Split in column GeoLocation into latitude and longitude, the new latitude
# and longitude columns should be numeric.
# head(meteorite_landings)
# geo_location values e.g (50.775, -6.08333)
# Need to get rid of brackets and comma
# Looks like a pattern for numbers:
# optional minus,
# 1 or more digits
# fullstop
# one or more digits
# Check that (Latitude between -90 and 90, longitude between -180 and 180)
meteorite_landings_new <- meteorite_landings %>%
  # Get rid of bracket at start and end
  mutate(geo_location_new = str_sub(geo_location, start = 2, end = -2)) %>%
  # e.g. now looks like  "54.21667, -113.02"

  # ?separate
  separate(
    col = "geo_location_new",
    into = c("latitude", "longitude"),
    sep = ", "
  ) %>%

  # Convert type of columns into numeric
  # Replace any missing values in latitude and longitude with zeros.
  mutate(
    latitude = coalesce(as.numeric(latitude), 0),
    longitude = coalesce(as.numeric(longitude), 0)
  )
