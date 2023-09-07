# File: nyc_bikers_helpers.R
# File created: 2023-09-07
# Author: Lesley Duff
# Description:
#   Functions to perform various calculations for us in both the presentation
# and the formal PDA analysis report


print("Hello World!")

get_month_hires_count = function(df)
  month_hires_count <- df %>%
  # index_by(month = month(start_time, label = TRUE)) %>%
  #?index_by
 #   index_by(month) %>%
  index_by(month = month(start_time, label = TRUE)) %>%
  
    summarise(hires_month_count = n()) %>% 
  return(month_hires_count)

#elec_month <- nyc_bikes_clean %>%
#  index_by(month = month(start_time, label = TRUE)) %>%
#  summarise(month_count = n())

