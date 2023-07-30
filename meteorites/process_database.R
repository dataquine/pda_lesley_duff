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

