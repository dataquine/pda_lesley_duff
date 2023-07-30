# Author: Lesley Duff
# Filename: process_database.R
# Title: Read database data and combine with clean data
# Date Created: 2023-07-30
# Description:
#  add the data in this table into your clean data.
# When you’ve added the extra information into the table then write it to a CSV
# in the clean data folder.
# Meteors Continued - PDA

library(RPostgres)
library(tidyverse)

# source credentials file
# this makes variables for database credentials available to use
source("meteorites_credentials.R")

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
  return(db_data)
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
examine_db_data(meteorite_db_data)

# Retrieve the original clean data
# Read the cleaned data into R.
#meteorite_csv_data <- process_meteorite_landings_file("data/meteorite_landings.csv")


