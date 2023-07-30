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
# source credentials file
# this makes variables for database credentials available to use
source("meteorites_credentials.R")

# create connection object using meteorite database credentials
db_connection = dbConnect(
  drv = Postgres(), 
  host = meteorites_host,
  port = meteorites_port,
  dbname = meteorites_database,
  user = meteorites_username,
  password = meteorites_password,
  bigint = "numeric"
)

# now we have our connection, don't need credentials anymore
# remove them from global environment
rm(meteorites_host, meteorites_port, meteorites_database, meteorites_username, 
   meteorites_password)

dbDisconnect(conn = db_connection)
