# Meteorites

## Background

We have a dataset from NASA that has information on meteorites that have been 
found up to the year 2013.

We wish to clean and analyse the dataset.

## Languages

R

## How to run

1. Download all code and data from
https://github.com/dataquine/pda_lesley_duff/tree/main/meteorites
2. Open and run `analysis.Rmd` in [RStudio](https://posit.co/download/rstudio-desktop/)

## Data used

`data/meteorite_landings.csv`

The data contains the following variables:

* `id` - a unique identifier of the meteorite
* `name` = name of meteorite
* `mass (g)` - mass of meteorite in grammes
* `fall` - Did the meteorite fall or was it found
* `year` - The year of discovery
* `GeoLocation` - a latitude and longitude

## Packages
* `assertr` - Assertive Programming for R Analysis Pipelines, 3.0.0
* `janitor` - Simple Tools for Examining and Cleaning Dirty Data, 2.2.0
* `tidyverse` - 2.0.0
* `testthat` - Unit Testing for R, 3.1.10

