# load in libraries
library(palmerpenguins)
library(tidyverse)

# Load in data
penguin_data <- palmerpenguins::penguins 




# write data to csv
write.csv(penguin_data, "clean_data/penguins.csv")

