# File: nyc_bikers_helpers.R
# File created: 2023-09-07
# Author: Lesley Duff
# Description:
#   Functions to perform various calculations for us in both the presentation
# and the formal PDA analysis report


print("Hello World!")

get_month_hires_count <- function(df) {
  month_hires_count <- df %>%
    index_by(month_name = month(start_time, label = TRUE)) %>%
    summarise(hires_month_count = n()) %>%
    return(month_hires_count)
}

# Hires per bike and bike count ----
# Break down how many hires each bike had
get_bike_hires <- function(df) {
  hires_per_bike <- df %>%
    # ?count
    # bike_count =
    count(bike_id, name = "hire_count", sort = TRUE)
}

get_trip_count <- function(df) {
  nrow(df)
}

get_bike_count <- function(df) {
  n_distinct(df$bike_id)
}

get_start_station_count <- function(df) {
  n_distinct(df$start_station)
}

get_end_station_count <- function(df) {
  n_distinct(df$end_station)
}

































































































































































































































# Number of stations  -----
#hires_start_station <- nyc_bikes_df %>%
#  distinct(start_station) %>%
#  arrange()
