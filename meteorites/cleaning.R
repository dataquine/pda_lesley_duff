# Author: Lesley Duff
# Filename: cleaning.R
# Title: Clean some meteorite landing data
# Date Created: 2023-07-21
# Description:
#   Data comes from NASA and has information on meteorites that have been found
# up to the year 2013.
# Trivia: I once held a piece of meteorite in Geology class.
#     Surprisingly heavy - it was small and dense from all the melted metal.

library(assertr)
library(janitor)
library(tidyverse)

# Creates cleaned meteorite landings data frame
process_meteorite_landings_file <- function(path) {
  # Read the data into R
  meteorite_landings <- read_csv(path)

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

  stopifnot(
    names(meteorite_landings) == expected_variable_names
  )

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
  meteorite_landings <- meteorite_landings %>%
    # Change the names of the variables to follow our naming standards.
    # mass (g) has spaces, GeoLocation is mixed case.
    # Use janitor to clean the names
    janitor::clean_names() %>%
    # Get rid of bracket at start and end
    mutate(geo_location = str_sub(geo_location, start = 2, end = -2)) %>%
    # e.g. now looks like  "54.21667, -113.02"

    # ?separate
    separate(
      col = "geo_location",
      into = c("latitude", "longitude"),
      sep = ", "
    ) %>%
    # Convert type of columns into numeric
    # Replace any missing values in latitude and longitude with zeros.
    mutate(
      latitude = coalesce(as.numeric(latitude), 0),
      longitude = coalesce(as.numeric(longitude), 0)
    ) %>%
    # Remove meteorites less than 1000g in weight from the data.
    filter(mass_g >= 1000) %>%
    # Check that latitude and longitude are valid values.
    # (latitude between -90 and 90, longitude between -180 and 180).
    verify(latitude >= -90 & latitude <= 90) %>%
    verify(longitude >= -180 & longitude <= 180) %>%
    # N.B. Earlier in testing longitude failed on one row,
    # index 29436 32789 Meridiani Planum - These coordinates would appear to
    # be on Mars!
    # However this row was removed from the data when we added the weight filter

    # Order the data by the year of discovery
    arrange(year)
}

# Test call of cleaning function
#meteorite_data <- process_meteorite_landings_file("data/meteorite_landings.csv")
#meteorite_data
