
library(tsibbledata)

# Load data set ----
# ?nyc_bikes comes from the tsibbledata package
nyc_bikes_df <- nyc_bikes

names(nyc_bikes_df)

# rename columns and select necessary columns
nyc_bikes_clean <- nyc_bikes_df %>%
  # add an age column
  mutate(age = 2018 - birth_year)
#  rename(
#    common_name = species_common_name_taxon_age_sex_plumage_phase,
#    scientific_name = species_scientific_name_taxon_age_sex_plumage_phase,
#  ) %>%
#  select(record_id, common_name, scientific_name, species_abbreviation, count)
nyc_bikes_clean
