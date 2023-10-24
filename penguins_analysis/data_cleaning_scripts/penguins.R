# load in libraries
library(janitor)
library(palmerpenguins)
library(tidyverse)

# Load in data
penguin_data <- palmerpenguins::penguins 
#View(penguin_data)
#str(penguin_data)
# Initial examination of dataset
#dim(penguins)

#glimpse(penguins)

#skimr::skim(penguins)

#penguins %>% 
#  count(species)

# Take a closer look at the NA rows
#penguins %>% 
#  filter(is.na(bill_length_mm))

# Which species of penguin are we interested in?
penguin_species <-  c("Adelie", "Chinstrap", "Gentoo") 


# Just two rows with NAs - drop them
penguin_data_clean <- penguin_data %>%
  filter(!is.na(bill_length_mm)) %>% 
  # Check that we only take the species of interest
  filter(species %in% penguin_species) %>% 
  
  # Adjust cleaning script for correlation analysis need more columns
  #Need to add bill depth, flipper length and body mass
  select(species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g)


# write data to csv
write_csv(penguin_data_clean, "clean_data/penguins.csv")
#View(penguin_data_clean)
