# Author: Lesley Duff
# Filename: process_database.R
# Title: Read database data and combine with clean data
# Date Created: 2023-07-30
# Description:
#  Reading meteorite_class database table and combining it with the already
# cleaned data from a CSV file of meteorite landings on earth and >= 1000g
# The new dataset is written to "clean_data/meteorite_landings.csv"
# Meteors Continued - PDA

library(RPostgres)
library(tidyverse)

# Source the script that will clean the original CSV data
source("cleaning.R")

# source credentials file
# this makes variables for database credentials available to use
source("meteorites_credentials.R")

# 3.2 Writing function/program to process data from a database
read_meteorite_class_database <- function(db_host, db_port, db_database,
                                          db_username, db_password) {
  # create connection object using meteorite database credentials
  db_connection <- dbConnect(
    drv = Postgres(),
    host = db_host,
    port = db_port,
    dbname = db_database,
    user = db_username,
    password = db_password,
    bigint = "numeric"
  )
  # Check the structure of the tables
  # list the tables, passing in the connection object
  dbListTables(conn = db_connection)
  # returns one table "meteorite_class"

  # see the fields in the meteorite_class table
  dbListFields(conn = db_connection, name = "meteorite_class")
  # returns  "id"    "class"

  # get the records in the table
  db_data <- dbGetQuery(
    conn = db_connection,
    statement = "SELECT * FROM meteorite_class"
  )

  dbDisconnect(conn = db_connection)

  return(db_data)
}

examine_db_data <- function (db_data) {
  # Examine the structure of the database data frame
  View(db_data)
  dim(db_data) # 45716 rows, 2 columns
  str(db_data)
  head(db_data)
  # After reading in the data we have two columns "id"  and  "class"
  
  # Assumption:
  #   id will match the id column in the cleaned CSV data from cleaning.R
  # process_meteorite_landings_file function,
  # Research: check what the 'class' of a meteorite might be expected to be
  #   and check whether the values in the class column seem OK
  #   https://en.wikipedia.org/wiki/Meteorite_classification
  
  # Just checking whether there are multiple entries for each id
  db_data %>%
    group_by(id) %>% 
    filter(n() > 1) %>% 
    summarise(id_count = n()) %>% 
    print(n = 500)
  # No results for count id > 1, each id appears only once
  
  return(db_data)
}
# 4.2 Data structures including tables and databases
combine_csv_db_data <- function(meteorite_csv_data, 
                    meteorite_db_data) {
  # I want to retain ALL CSV observations regardless of
  # whether they have a meteorite class available
  # We originally had a cleaned dataset where only less than 1000g in mass
  # If we include all records on the right then we would have missing data
  # for several rows and reintroduce records for those < 1000g
  
  # I am choosing a left join
  # to return all records in left table, and any matching records in the
  # right table
  combined_data <- left_join(meteorite_csv_data, meteorite_db_data, by = "id")
  # 4871 obs of 8 variables
  #View(combined_data)
  
  return(combined_data)
}
# 3.2 Writing function/program to process data from a database
write_combined_meteorite_data <- function(combined_meteorite_data, path){
# Write the cleaned and combined data to the clean data folder.
  write_csv(combined_meteorite_data, path)
}

meteorite_db_data <- read_meteorite_class_database(
  meteorites_host,
  meteorites_port,
  meteorites_database,
  meteorites_username,
  meteorites_password
)
# now we have our data don't need credentials anymore
# remove them from global environment
rm(meteorites_host, meteorites_port, meteorites_database, meteorites_username,
   meteorites_password)

# Just check the data structure
#meteorite_db_data <- examine_db_data(meteorite_db_data)
# 45716 obs of 2 variables

# Retrieve the original clean data
# Read the cleaned data into R.
meteorite_csv_data <- process_meteorite_landings_file(
  "data/meteorite_landings.csv")
# 4871 obs of 7 variables

combined_meteorite_data <- combine_csv_db_data(meteorite_csv_data, 
                                               meteorite_db_data)

# Tidy up remove intermediate data frames
rm(meteorite_csv_data, meteorite_db_data)

write_combined_meteorite_data(combined_meteorite_data, 
                              "clean_data/meteorite_landings.csv")
